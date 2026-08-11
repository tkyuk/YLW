---
title: (자재출고)TopUnitName,UpperUnitName 최상위, 상위
date: 2023-11-15
tags: [erp, 개발, SQL]
---

# (자재출고)TopUnitName,UpperUnitName 최상위, 상위

구매와 다르게 작성

참고 SP : ets_SPDMMOutProcItemQuery

 

마지막에 최종임시테이블에 JOIN 하는 방식으로 해야한다

 

SELECT A.\*,

F.ItemName AS TopUnitName,

F.ItemNo AS TopUnitNo,

G.ItemName AS UpperUnitName,

G.ItemNo AS UpperUnitNo

FROM \#OutItemList AS A

LEFT OUTER JOIN \#TCOMSourceTracking AS S WITH(NOLOCK) ON A.IDX_NO = S.IDX_NO LEFT OUTER JOIN \_TPUORDPOReqItem AS P WITH(NOLOCK) ON P.CompanySeq = @CompanySeq

AND S.Seq = P.POReqSeq

AND S.Serl = P.POReqSerl

LEFT OUTER JOIN \_TPJTBOM AS C WITH(NOLOCK) ON P.CompanySeq = C.CompanySeq

AND P.PJTSeq = C.PJTSeq

AND P.BOMSerl = C.BOMSerl

LEFT OUTER JOIN \_TPJTBOM AS D WITH(NOLOCK) ON C.CompanySeq = D.CompanySeq

AND C.PJTSeq = D.PJTSeq

AND D.BOMSerl \<\> -1

AND C.UpperBOMSerl = D.BOMSerl

AND ISNULL(D.BeforeBOMSerl,0) = 0 -- 상위 BOM

LEFT OUTER JOIN \_TPJTBOM AS E WITH(NOLOCK) ON C.CompanySeq = E.CompanySeq

AND C.PJTSeq = E.PJTSeq

AND E.BOMSerl \<\> -1

AND ISNULL(E.BeforeBOMSerl,0) = 0

AND SUBSTRING(D.TreeCode,1,6) = E.TreeCode -- 최상위 BOM

AND ISNULL(CHARINDEX('.',E.BOMlevel),0) \< 1

AND ISNUMERIC(REPLACE(E.BOMLevel,'.','/')) = 1

LEFT OUTER JOIN \_TDAItem AS F WITH(NOLOCK) ON E.CompanySeq = F.CompanySeq

AND E.ItemSeq = F.ItemSeq

LEFT OUTER JOIN \_TDAItem AS G WITH(NOLOCK) ON D.CompanySeq = G.CompanySeq

AND D.ItemSeq = G.ItemSeq

ORDER BY MatOutSeq, OutItemSerl --17.02.08 이혜민 추가