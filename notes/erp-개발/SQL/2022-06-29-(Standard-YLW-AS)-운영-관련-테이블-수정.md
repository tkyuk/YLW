---
title: (Standard -\> YLW-AS) 운영 관련 테이블 수정
date: 2022-06-29
tags: [erp, 개발, SQL]
---

# (Standard -\> YLW-AS) 운영 관련 테이블 수정

CS에 테이블이 YLW-AS 가 아니라 Standard 로 되어 있음

=\> 체크아웃이 불가능하기 때문에 직접 db에서 바꿔줘야함

 

데이터를 입력하는 업무가 아니라 운영관련 정보들은

Common 에 저장되어있음 (SYSDEVWKCommon)

 

 

 

SELECT \* FROM \_TCATables WHERE TableName LIKE 'SYS\_%'

SELECT DEVMODE FROM \_TCATables

 

BEGIN TRAN

UPDATE \_TCATables

SET DevMode = 272003

WHERE TableName LIKE 'SYS\_%' AND TABLESEQ in (18820234,18820235)

COMMIT TRAN