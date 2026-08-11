---
title: 전체 회색 적용 후 특정 컬럼만 controlkey 색상 지정
date: 2026-02-04
tags: [erp, 개발, Ace이벤트]
---

# 전체 회색 적용 후 특정 컬럼만 controlkey 색상 지정

local row, rowOld

local COLOR_WHITE = -1 -- 기본(white)

local COLOR_CODEHELP = '#eef8ff' -- 코드도움(skyblue)

local COLOR_NOS = '#fff5f5' -- NOS 필수값(pink)

local COLOR_DIS = -1118482 -- 비활성(gray)

 

-- 긴급도 관련 색상 정의

local COLOR_EMERGENCY_RED = '#FFBBBB' -- 수주일 = 납기일 (붉은색)

local COLOR_EMERGENCY_ORANGE = '#FFCC99' -- 수주일 + 1일 = 납기일 (주황색)

 

-- DIS가 아니거나 별도 관리가 필요한 컬럼 Map

local editColMap = {

\['Sel'\] = true,

\['IsGoodStock'\] = true,

\['WorkCenterName'\] = true,

\['DVDate'\] = true,

\['WHName'\] = true,

\['Message'\] = true

}

 

-- 현재 활성화된 행 저장

rowOld = SS1.ActiveRow

 

-- 1. 전체 데이터 행 반복

for row = 0, SS1.DataRowCnt - 1 do

SS1.ActiveRow = row

-- 현재 행의 날짜 데이터 가져오기

local orderDate = CellText(SS1, row, 'OrderDate')

local dvDate = CellText(SS1, row, 'DVDate')

-- 수주일 + 1일 계산

local orderDatePlus1 = ''

if orderDate ~= nil and orderDate ~= '' then

orderDatePlus1 = DateAdd('Day', 1, orderDate)

end

 

-- 2. 우선순위 판단: 긴급도 색상 결정

local emergencyColor = nil

if orderDate ~= '' and dvDate ~= '' then

if orderDate == dvDate then

emergencyColor = COLOR_EMERGENCY_RED

elseif orderDatePlus1 == dvDate then

emergencyColor = COLOR_EMERGENCY_ORANGE

end

end

 

-- 3. 루프를 돌며 컬럼별 색상 적용

local maxCol = SS1.MaxCols - 1

for col = 0, maxCol do

SS1.ActiveCol = col

local colName = SS1.ActiveColumnName

 

if emergencyColor ~= nil then

-- \[IF\] 빨강 또는 주황 조건인 경우: 모든 컬럼 강제 적용

SS1.ActiveCellBackColor = emergencyColor

else

-- \[ELSE\] 조건에 해당하지 않는 경우 (기본 하양 베이스)

if editColMap\[colName\] == true then

-- 담긴 항목(DIS 아님 등)인 경우 컨트롤키 및 타입에 맞는 색상 적용

if SS1.ColumnCellType == 'enCodeHelp' then

SS1.ActiveCellBackColor = COLOR_CODEHELP

elseif string.find(SS1.ColumnControlKey, 'NOS') then

SS1.ActiveCellBackColor = COLOR_NOS

else

SS1.ActiveCellBackColor = COLOR_WHITE

end

else

-- 그 외 일반 컬럼은 하양(기본) 처리

SS1.ActiveCellBackColor = COLOR_DIS

end

end

end

end

 

-- 원래 활성화된 행으로 복구

SS1.ActiveRow = rowOld