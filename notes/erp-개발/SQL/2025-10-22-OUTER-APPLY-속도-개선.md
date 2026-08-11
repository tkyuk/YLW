---
title: OUTER APPLY 속도 개선
date: 2025-10-22
tags: [erp, 개발, SQL]
---

# OUTER APPLY 속도 개선

<span class="mark">-- 변경 전</span>

OUTER APPLY (SELECT TOP 1 PODomPrice, POCurPrice, PODate, SUM(POQty) AS POQty

FROM das_TPUORDPriceSummary AS D8 WITH(NOLOCK)

WHERE D8.CompanySeq = @CompanySeq

AND D8.ItemSeq = A.ItemSeq

AND D8.UMModule = 6224001

--AND D8.CustSeq = A.CustSeq

AND D8.PODate \< B.ApproReqDate -- 20251001. jhkweon. 주석제거

GROUP BY PODomPrice, POCurPrice, PODate

ORDER BY PODate DESC) AS D8

 

<span class="mark">-- 변경 후</span>

> LEFT OUTER JOIN (SELECT D8.CompanySeq, D8.ItemSeq, D8.PODomPrice, D8.POCurPrice, D8.PODate, SUM(D8.POQty) AS POQty,

ROW_NUMBER() OVER(PARTITION BY D8.ItemSeq ORDER BY D8.PODate DESC) AS RN

FROM das_TPUORDPriceSummary AS D8 WITH(NOLOCK)

WHERE D8.CompanySeq = @CompanySeq

AND D8.UMModule = 6224001

GROUP BY D8.CompanySeq, D8.ItemSeq, D8.PODomPrice, D8.POCurPrice, D8.PODate) AS D8 ON D8.CompanySeq = @CompanySeq

AND D8.ItemSeq = A.ItemSeq

AND D8.PODate \< B.ApproReqDate

AND D8.RN = 1 -- 가장 최근 데이터만 선택