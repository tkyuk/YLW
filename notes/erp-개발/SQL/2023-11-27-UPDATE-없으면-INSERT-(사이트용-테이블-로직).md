---
title: UPDATE / 없으면 INSERT (사이트용 테이블 로직)
date: 2023-11-27
tags: [erp, 개발, SQL]
---

# UPDATE / 없으면 INSERT (사이트용 테이블 로직)

-- 로그테이블 남기기(마지막 파라메터는 반드시 한줄로 보내기)

EXEC \_SCOMXmlLog @CompanySeq ,

@UserSeq ,

'gcos_TSLOrderItem', -- 원테이블명

'#BIZ_OUT_DataBlock2', -- 템프테이블명

'OrderSeq,OrderSerl' , -- 키가 여러개일 경우는 , 로 연결한다.

@PgmSeq, ''

IF EXISTS (SELECT 1 FROM \#BIZ_OUT_DataBlock2 WHERE WorkingTag = 'U' AND Status = 0 )

BEGIN

UPDATE gcos_TSLOrderItem

SET PackingSheetLink = A.PackingSheetLink,

LastUserSeq = @UserSeq,

LastDateTime = GETDATE(),

PgmSeq = @PgmSeq

FROM \#BIZ_OUT_DataBlock2 AS A

JOIN gcos_TSLOrderItem AS B ON B.CompanySeq = @CompanySeq

AND B.OrderSeq = A.OrderSeq

AND B.OrderSerl = A.OrderSerl

WHERE A.WorkingTag = 'U' AND A.Status = 0

IF @@ERROR \<\> 0

BEGIN

RETURN

END

-- 사이트용 테이블 로직(수정 시 사이트용 테이블에 데이터 없을 경우 신규 생성합니다.)

INSERT INTO gcos_TSLOrderItem(

CompanySeq,

OrderSeq,

OrderSerl,

OrderSubSerl,

PackingSheetLink,

LastUserSeq,

LastDateTime,

PgmSeq)

SELECT @CompanySeq,

A.OrderSeq,

A.OrderSerl,

ISNULL(A.OrderSubSerl,0),

A.PackingSheetLink,

@UserSeq,

GETDATE(),

@pgmSeq

FROM \#BIZ_OUT_DataBlock2 A

WHERE WorkingTag = 'U'

AND Status = 0

AND NOT EXISTS(SELECT 1

FROM gcos_TSLOrderItem AS B WITH(NOLOCK)

WHERE B.CompanySeq = @CompanySeq

AND A.OrderSeq = B.OrderSeq

AND A.OrderSerl = B.OrderSerl

AND A.OrderSubSerl = B.OrderSubSerl)

IF @@ERROR \<\> 0

BEGIN

RETURN

END

END