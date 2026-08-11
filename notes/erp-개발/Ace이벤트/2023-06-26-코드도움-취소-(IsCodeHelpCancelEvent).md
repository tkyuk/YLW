---
title: 코드도움 취소 (IsCodeHelpCancelEvent)
date: 2023-06-26
tags: [erp, 개발, Ace이벤트]
---

# 코드도움 취소 (IsCodeHelpCancelEvent)

--==============================================================

-- 값이 없는 경우 코드도움 실행 취소 (FrmWSLWeighBridge_emk)

--==============================================================

local strTag, strCollector

strTag                         = '00'

strCollector        = ''

 

-- 운반업체 코드도움 없으면 거래처 코드도움 실행취소

if txtCollectorName.TextCd == 0 or txtCollectorName.TextCd == '' or txtCollectorName.TextCd == '0' or txtCollectorName.TextCd == nil then

> SS1.IsCodeHelpCancelEvent = true

else

> if tonumber(txtWeighBridgeTypeName.Value) == 1000661001 or tonumber(txtWeighBridgeTypeName.Value) == 1000661004 then
>
> strTag = '01'
>
> end

 

> strCollector        = txtCollectorName.TextCd
>
>  
>
> SS1.ActiveColumnName = 'CustName'
>
> SS1.ColumnCodeHelpParams = strTag..'\|\|\|'..strCollector

end

if txtDeptName.Value == 0 or txtDeptName.Value == null or txtDeptName.Value == '' then

> MessageBox('부서를 입력해주세요.', '', 'MsgBoxTypeOK')
>
> SS.IsCodeHelpCancelEvent = true
>
> return

end

SS.ColumnCodeHelpParams = txtDeptName.Value..'\|\|\|'