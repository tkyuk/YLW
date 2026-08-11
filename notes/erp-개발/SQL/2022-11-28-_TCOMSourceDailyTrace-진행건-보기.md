---
title: \_TCOMSourceDailyTrace 진행건 보기
date: 2022-11-28
tags: [erp, 개발, SQL]
---

# \_TCOMSourceDailyTrace 진행건 보기

\<===========================

=======================\>

-- 구매요청 -\> 구매품의 -\> 구매발주

-- 구매발주에서 구매요청 볼 때

SELECT c.\*

FROM \_TPUORDPO AS A

JOIN \_TPUORDPOItem AS B ON A.POSeq = B.POSeq

OUTER APPLY (SELECT POReqNo AS ReqNo ,

ReqDate AS ReqDate ,

EmpSeq AS ReqEmpSeq ,

DeptSeq AS ReqDeptSeq

FROM \_TCOMSourceDailyTrace AS Z WITH(NOLOCK)

JOIN \_TPUORDPOReq AS D WITH(NOLOCK) ON Z.FromSeq = D.POReqSeq

WHERE Z.CompanySeq = B.CompanySeq

AND Z.ToSeq = B.POSeq

AND Z.ToSerl = B.POSerl

AND Z.FromTableSeq = 12 -- 구매요청

AND Z.ToTableSeq = 13 -- 구매발주

) as c

ORDER BY A.LastDateTime DESC

-- 수주에서 거래명세서로 진행된 건 볼 때

SELECT \*

FROM \_TSLOrder AS A

JOIN \_TSLOrderItem AS B ON A.OrderSeq = B.OrderSeq

OUTER APPLY (SELECT SUM(Z.ToQty) AS InvoiceQty

FROM \_TCOMSourceDailyTrace AS Z WITH(NOLOCK)

WHERE Z.CompanySeq = B.CompanySeq

AND Z.FromSeq = B.OrderSeq

AND Z.FromSerl = B.OrderSerl

AND Z.FromTableSeq = 16 -- 수주

AND Z.ToTableSeq = 18 -- 거래명세서

) as c

WHERE A.CompanySeq = @CompanySeq

and a.BizUnit = @BizUnit

AND A.OrderDate BETWEEN @StdDate/\*6개월전\*/ AND @StdDate