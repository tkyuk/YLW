---
title: GNI - 오류 메세지 생성 및 RETURN
date: 2024-09-27
tags: [erp, 개발, SQL]
---

# GNI - 오류 메세지 생성 및 RETURN

begin tran

insert into TDAErrorMsg select 'DeliveryCust','거래처의 납품처가 아닙니다.','10019'

rollback tran

 

IF NOT EXISTS(SELECT TOP 1 1 fROM TSBDeliveryCust WHERE CustCode = @wCustCd AND Seq = @vDeliCustCd)

BEGIN

EXEC SDAErrMsg 'DeliveryCust', @vcResults OUTPUT, @vcStatus OUTPUT

IF @wRETURNType = '' SELECT @vcStatus, LTRIM(RTRIM(@vcResults)), '#ERROR'

IF @wRETURNType = '' continue ELSE RETURN

END