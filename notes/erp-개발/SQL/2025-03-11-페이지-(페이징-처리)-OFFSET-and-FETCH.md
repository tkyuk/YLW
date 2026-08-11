---
title: 페이지 (페이징 처리) OFFSET and FETCH
date: 2025-03-11
tags: [erp, 개발, SQL]
---

# 페이지 (페이징 처리) OFFSET and FETCH

-- 임시 테이블 생성

CREATE TABLE \#TempNumbers (Number INT);

 

-- 1부터 100까지 숫자 삽입

WITH Numbers AS (

SELECT 1 AS Num

UNION ALL

SELECT Num + 1 FROM Numbers WHERE Num \< 100

)

INSERT INTO \#TempNumbers (Number)

SELECT Num FROM Numbers OPTION (MAXRECURSION 100);

 

-- 결과 확인

--SELECT \* FROM \#TempNumbers;

 

-- 필요 없으면 임시 테이블 삭제

-- DROP TABLE \#TempNumbers;

 

DECLARE @PageNumber INT = 2; -- 현재 페이지

DECLARE @PageSize INT = 10; -- 한 페이지당 개수

 

SELECT \* FROM \#TempNumbers

ORDER BY Number

OFFSET (@PageNumber - 1) \* @PageSize ROWS FETCH NEXT @PageSize ROWS ONLY;

 

 

DROP TABLE \#TempNumbers