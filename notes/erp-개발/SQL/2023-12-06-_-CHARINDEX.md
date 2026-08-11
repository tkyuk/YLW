---
title: \_/ CHARINDEX
date: 2023-12-06
tags: [erp, 개발, SQL]
---

# \_/ CHARINDEX

WHILE (1=1)

BEGIN

INSERT \#Item (ItemSeq)

SELECT SUBSTRING(@GoodItemSeq, @Tmp, CHARINDEX('\_/', @GoodItemSeq, @Tmp) - @Tmp)

 

SELECT @Tmp = CHARINDEX('\_/', @GoodItemSeq, @Tmp) + 2

 

IF @Tmp \> LEN(@GoodItemSeq)

BREAK

END