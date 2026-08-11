---
title: Action 권한이 없는 경우 DIS 처리 GetActionSecu
date: 2025-12-03
tags: [erp, 개발, Ace이벤트]
---

# Action 권한이 없는 경우 DIS 처리 GetActionSecu

--Action 권한이 없는 경우 담당자확인 DIS 처리 : 2025.05.12 정민찬

local mySecu

mySecu = GetActionSecu('AC_ReceiptCfm')

 

if mySecu == 0 then

> chkIsConfirm.ControlKey = 'DIS;'

End

 

 

참고화면 : FrmWSLServiceReceipt 서비스접수