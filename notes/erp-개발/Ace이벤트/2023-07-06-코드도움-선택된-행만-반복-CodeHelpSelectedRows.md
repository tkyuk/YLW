---
title: 코드도움 선택된 행만 반복 CodeHelpSelectedRows
date: 2023-07-06
tags: [erp, 개발, Ace이벤트]
---

# 코드도움 선택된 행만 반복 CodeHelpSelectedRows

-- 코드도움에서 여러 항목 선택 시에도 성상 및 처리방법이 정상 설정되도록 수정하였습니다.

-- CodeHelpSelectedRows를 정상적으로 가져오기 위해, SS1에 Changed로 연결하여 로직 작성하였습니다.

local ActCol, StrRow, EndRow, ActiveRowOld, row

ActCol = SS1.ActiveColumnName

 

EndRow = SS1.ActiveRow + SS1.CodeHelpSelectedRows - 1

 

if SS1.ActiveRow \> EndRow then

> EndRow = SS1.ActiveRow

end

 

-- 여기서 ActiveRow에 대해 동작하는 이벤트메서드를 호출합니다.

ActiveRowOld = SS1.ActiveRow

for row = SS1.ActiveRow, EndRow, 1 do

> SS1.ActiveRow = row
>
> RunPgmMethod('SS1GetWasteInfo') -- SS ActiveRow Get...
>
> RunPgmMethod('SS1ItemNameChg')

end

SS1.ActiveRow = ActiveRowOld