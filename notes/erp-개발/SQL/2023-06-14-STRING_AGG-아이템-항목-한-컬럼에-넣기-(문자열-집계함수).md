---
title: STRING_AGG - 아이템 항목 한 컬럼에 넣기 (문자열 집계함수)
date: 2023-06-14
tags: [erp, 개발, SQL]
---

# STRING_AGG - 아이템 항목 한 컬럼에 넣기 (문자열 집계함수)

SELECT M.OrderSeq,

ISNULL(STRING_AGG(A.ItemName, ','),'') AS ItemValues

FROM sjpark_TSLSalesOrder AS M

LEFT OUTER JOIN sjpark_TSLSalesOrderItem AS I ON M.OrderSeq = I.OrderSeq

LEFT OUTER JOIN \_TDAItem AS A ON A.ItemSeq = I.ItemSeq

GROUP BY M.OrderSeq

 

 

 

 

-- 정렬 추가

STRING_AGG(A.DocNo, '.') WITHIN GROUP (ORDER BY A.IsORDPOPrt DESC,A.ORDPOPrtSeq) AS DocNo

 

 

 

 

 

 

SELECT Z.ReceiptSeq

,SUM(ISNULL(Z.CurAmt, 0)) AS TotAmt

,SUM(ISNULL(Z.CurVAT, 0)) AS TotVat

,SUM(ISNULL(Z.CurAmt, 0) + ISNULL(Z.CurVAT, 0)) AS TotalAmt

,SUM(IIF(ISNULL(F.ValueText, '0') \<\> '1', ISNULL(Z.CurAmt, 0) + ISNULL(Z.CurVAT, 0), 0)) AS TotPartsCost -- 부품비: ValueText가 '1'이 아닌 경우

,SUM(IIF(ISNULL(F.ValueText, '0') = '1', ISNULL(Z.CurAmt, 0) + ISNULL(Z.CurVAT, 0), 0)) AS TotLaborCost -- 공임비: ValueText가 '1'인 경우

-- 품명 추가

, STRING_AGG(IIF(ISNULL(F.ValueText, '0') \<\> '1', G.ItemName, NULL), ', ') AS ItemNames

FROM svs_TSIASServiceMaster AS A WITH(NOLOCK)

JOIN svs_TSIASServiceRepair AS Z WITH(NOLOCK) ON Z.CompanySeq = @CompanySeq

AND Z.ReceiptSeq = A.ReceiptSeq

LEFT OUTER JOIN \_TDAUMinorValue AS F WITH(NOLOCK) ON F.CompanySeq = Z.CompanySeq

AND F.MinorSeq = Z.UMCostType

AND F.Serl = 15000001

LEFT OUTER JOIN \_TDAItem AS G WITH(NOLOCK) ON G.CompanySeq = Z.CompanySeq

AND G.ItemSeq = Z.ItemSeq

GROUP BY Z.ReceiptSeq