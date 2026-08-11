---
title: 뷰테이블 패치 스크립트 (없으면 CREATE 있으면 ALTER)
date: 2024-09-03
tags: [erp, 개발, SQL]
---

# 뷰테이블 패치 스크립트 (없으면 CREATE 있으면 ALTER)

IF NOT EXISTS (SELECT \* FROM sys.views WHERE name = 'dhi_VPDPartsList')

BEGIN

EXEC('

CREATE VIEW dhi_VPDPartsList

AS

SELECT A.ItemNo AS \[대호코드\]

,A.ItemName AS \[품명(공정명)\]

--,A.ItemSpec AS \[규격\]

--,A.BOMRev AS \[차수\]

,ISNULL(A.RawMaterialCostSum, 0) AS \[원자재비\]

,ISNULL(A.SubMaterialCostSum, 0) AS \[부자재비\]

,ISNULL(A.MaterialCostSum , 0) AS \[자재비합계\]

,ISNULL(A.ProdCost , 0) AS \[가공비\]

,ISNULL(A.SalesPrice , 0) AS \[견적 단가(판매단가)\]

FROM dhi_IF_TPDPartsList AS A

WHERE A.CompanySeq = 1

')

END

ELSE

EXEC('

ALTER VIEW dhi_VPDPartsList

AS

SELECT A.ItemNo AS \[대호코드\]

,A.ItemName AS \[품명(공정명)\]

--,A.ItemSpec AS \[규격\]

--,A.BOMRev AS \[차수\]

,ISNULL(A.RawMaterialCostSum, 0) AS \[원자재비\]

,ISNULL(A.SubMaterialCostSum, 0) AS \[부자재비\]

,ISNULL(A.MaterialCostSum , 0) AS \[자재비합계\]

,ISNULL(A.ProdCost , 0) AS \[가공비\]

,ISNULL(A.SalesPrice , 0) AS \[견적 단가(판매단가)\]

FROM dhi_IF_TPDPartsList AS A

WHERE A.CompanySeq = 1

')