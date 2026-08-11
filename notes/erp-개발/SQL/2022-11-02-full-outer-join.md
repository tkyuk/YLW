---
title: full outer join
date: 2022-11-02
tags: [erp, 개발, SQL]
---

# full outer join

SELECT ISNULL(A.CustSeq, B.CustSeq) AS CustSeq,

ISNULL(A.DeptSeq, B.DeptSeq) AS DeptSeq,

ISNULL(A.ItemSeq, B.ItemSeq) AS ItemSeq,

         ISNULL(A.SalesQty,0) AS SalesQty,

         ISNULL(B.PlanQty ,0) AS PlanQty

INTO \#Result

FROM \#SalesQty AS A

FULL OUTER JOIN \#PlanQty AS B ON A.CustSeq = B.CustSeq

AND A.DeptSeq = B.DeptSeq

AND A.ItemSeq = B.ItemSeq

GROUP BY ISNULL(A.CustSeq, B.CustSeq),

ISNULL(A.DeptSeq, B.DeptSeq),

ISNULL(A.ItemSeq, B.ItemSeq),        

ISNULL(A.SalesQty,0),

ISNULL(B.PlanQty ,0)