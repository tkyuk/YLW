---
title: 에스디생명공학 Jump진행관리 UPDATE
date: 2024-02-29
tags: [erp, 개발, SQL]
---

# 에스디생명공학 Jump진행관리 UPDATE

BEGIN TRAN

UPDATE \_TCAJump

SET ToPgmSeq = 70320138

,JumpInType = 251001

,CustSeq = 3102035

,ClientSeq = 703

,DevMode = 272004

FROM \_TCAJump

where JumpName like '%emk'

ROLLBACK TRAN