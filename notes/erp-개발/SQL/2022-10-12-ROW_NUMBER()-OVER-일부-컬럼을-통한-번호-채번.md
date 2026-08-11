---
title: ROW_NUMBER() OVER 일부 컬럼을 통한 번호 채번
date: 2022-10-12
tags: [erp, 개발, SQL]
---

# ROW_NUMBER() OVER 일부 컬럼을 통한 번호 채번

JOIN (SELECT ROW_NUMBER() OVER(PARTITION BY A.CustSeq ORDER BY A.ResultClassNo,A.CustSeq) AS Serl,

A.ResultClassNo,A.CustSeq

FROM (SELECT DISTINCT

ResultClassNo,CustSeq

FROM \#TMP_Result) AS A ) AS D ON A.ResultClassNo = D.ResultClassNo AND A.CustSeq = D.CustSeq