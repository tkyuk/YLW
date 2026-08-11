---
title: 제뉴인 \_TCOMSourceDaily JOIN SUM
date: 2024-04-22
tags: [erp, 개발, SQL]
---

# 제뉴인 \_TCOMSourceDaily JOIN SUM

JOIN \_TCOMSourceDaily AS P WITH(NOLOCK) ON P.CompanySeq = A.CompanySeq

AND P.FromTableSeq = 10

AND P.ToTableSeq = 9

AND P.ToSeq = A.DelvInSeq

AND P.ToSerl = a.DelvInSerl

JOIN (SELECT CompanySeq, FromSeq, FromSerl, ToSeq,ToSerl, FromTableSeq, ToTableSeq, SUM(ADD_DEL \* ToQty) AS ToQty -- 24.04.22 SJPARK

FROM \_TCOMSourceDaily

GROUP BY CompanySeq, FromSeq, FromSerl, ToSeq,ToSerl,FromTableSeq, ToTableSeq

)AS P ON P.CompanySeq = A.CompanySeq

AND P.FromTableSeq = 10

AND P.ToTableSeq = 9

AND P.ToSeq = A.DelvInSeq

AND P.ToSerl = A.DelvInSerl

=\>