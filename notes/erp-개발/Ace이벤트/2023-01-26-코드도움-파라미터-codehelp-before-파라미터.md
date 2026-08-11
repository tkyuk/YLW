---
title: 코드도움 파라미터 codehelp before 파라미터
date: 2023-01-26
tags: [erp, 개발, Ace이벤트]
---

# 코드도움 파라미터 codehelp before 파라미터

-- 시트

 

if SS1.ActiveColumnName == 'UMRLCUnitName' then

SS1.ColumnCodeHelpParams = CellText(SS1, SS1.ActiveRow, 'UMRLCSeq')..'\|\|\|'

end

 

-- Param1 =\> 대분류 코드

-- Param2 =\> 일련번호 (시트설정에서 HID 풀어줘야함)

 

if SS1.ActiveColumnName == 'UMFactoryUnitName' then

> SS1.ColumnCodeHelpParams = '1000365\|15000001\|'..tostring(cmbBizUnitName.Value)..'\|'

end

 

 

if SS2.ActiveColumnName == 'UMQCTitleName' then

SS2.ColumnCodeHelpParams = cmbQCKind.Value..'\|'..''..'\|'..fltItemClass.Value

SS2.ColumnCodeHelpParams = cmbQCKind.Value..'\|'..'\|'..fltItemClass.Value

SS2.ColumnCodeHelpParams = cmbQCKind.Value..'\|\|'..fltItemClass.Value

end

-- 컨트롤

 

txtUnitSeq.CodeHelpParams = tostring(txtPJTNo.TextCd)..'\|\|\|'

txtAssySeq.CodeHelpParams = tostring(txtPJTNo.TextCd)..'\|\|\|'

 

 

txtEtcWkItem.CodeHelpParams = cmbWkItemName.Value..'\|\|'..datAppDate.Text..'\|'..txtEmpName.TextCd