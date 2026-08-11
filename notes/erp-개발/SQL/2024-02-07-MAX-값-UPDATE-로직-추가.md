---
title: MAX 값 UPDATE 로직 추가
date: 2024-02-07
tags: [erp, 개발, SQL]
---

# MAX 값 UPDATE 로직 추가

--=================================================

-- MAX UPDATE 로직 추가 24.02.07 SJPARK

DECLARE @MAXOrderSeq INT

SELECT @MAXOrderSeq = MAX(OrderSeq)

FROM \_TSLOrder

-- 실제 MAX값으로 업데이트

UPDATE \_TCOMCreateSeqMax

SET MaxSeq = @MAXOrderSeq

WHERE TableName = '\_TSLOrder'

--=================================================

 

-- 키값생성코드부분 시작

EXEC @Seq = dbo.\_SCOMCreateSeq @CompanySeq, '\_TSLOrder', 'OrderSeq', @Count

-- Temp Talbe 에 생성된 키값 UPDATE

UPDATE \#TSLOrder

SET OrderSeq = @Seq + DataSeq

WHERE WorkingTag = 'A'

AND Status = 0

UPDATE \#TSLOrderItem

SET OrderSeq = B.OrderSeq

FROM \#TSLOrderItem A JOIN \#TSLOrder B ON A.IDX_NO = B.IDX_NO

WHERE A.WorkingTag = 'A'