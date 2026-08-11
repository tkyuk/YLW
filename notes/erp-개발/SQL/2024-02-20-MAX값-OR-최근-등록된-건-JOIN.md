---
title: MAX값 OR 최근 등록된 건 JOIN
date: 2024-02-20
tags: [erp, 개발, SQL]
---

# MAX값 OR 최근 등록된 건 JOIN

OUTER APPLY (SELECT TOP 1 TelNo

FROM \_TDACustEmpInfo AS Z1

WHERE A.CompanySeq = Z1.CompanySeq

AND A.CustSeq = Z1.CustSeq

AND Z1.UMJobRollKind = 8024001

AND ISNULL(Z1.TELNo,'') \<\> ''

ORDER BY EmpSerl DESC

) AS Z1