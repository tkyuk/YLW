---
title: HSNo / HSCode
date: 2026-01-14
tags: [erp, 개발, SQL]
---

# HSNo / HSCode

<span class="mark">-- 가져오기</span>

 

CREATE TABLE \#TEMP_HSNo

(

IDX_NO INT,

CompanySeq INT,

CustSeq INT,

ItemSeq INT,

HSNo NVARCHAR(20),

STDDate NCHAR(8) -- 2025.01.23 김영석 : 일자 추가

)

 

INSERT INTO \#TEMP_HSNo(IDX_NO, CompanySeq, CustSeq, ItemSeq, HSNo, STDDate)

SELECT A.IDX_NO, A.CompanySeq, C.CustSeq, B.ItemSeq, N'', C.BillDate

FROM \#TSLBill AS A

JOIN \_TPJTSLBillItem AS B WITH(NOLOCK) ON B.CompanySeq = A.CompanySeq

AND B.BillSeq = A.BillSeq

AND B.PJTBillSerl = A.BillSerl

JOIN \_TSLBill AS C WITH(NOLOCK) ON C.CompanySeq = A.CompanySeq

AND C.BillSeq = A.BillSeq

UNION ALL

SELECT A.IDX_NO, A.CompanySeq, C.CustSeq, B.ItemSeq, N'', C.Billdate

FROM \#TSLBill AS A

JOIN \_TSLSalesItem AS B WITH(NOLOCK) ON B.CompanySeq = A.CompanySeq

AND B.SalesSeq = A.SalesSeq

AND B.SalesSerl = A.SalesSerl

JOIN \_TSLBill AS C WITH(NOLOCK) ON C.CompanySeq = A.CompanySeq

AND C.BillSeq = A.BillSeq

 

EXEC \_SWSLGetHSNoSub '#TEMP_HSNo', 'HSNo', 'ItemSeq', @CompanySeq, 'STDDate'

--============================================================================

--============================================================================

LEFT OUTER JOIN \#TEMP_HSNo AS HS WITH(NOLOCK) ON HS.CompanySeq = BL.CompanySeq -- 2023.07.25 김영석 추가

AND HS.IDX_NO = BL.IDX_NO

<span class="mark">-- 출력용 max 값 사용 예시 (\_SWSLPerformerInvoiceRptQuery)</span>

 

LEFT OUTER JOIN (SELECT A.ItemSeq, ISNULL(MAX(HS.HSCode),'') AS HSCode

FROM \#Temp AS A

JOIN \_TDAItemClass AS CL WITH (NOLOCK) ON CL.CompanySeq = @CompanySeq

AND A.ItemSeq = CL.ItemSeq

AND CL.UMajorItemClass IN (2001,2004)

JOIN \_TSLHSCodeItemClass AS HS WITH (NOLOCK) ON HS.CompanySeq = @CompanySeq

AND CL.UMItemClass = HS.UMItemClass

AND HS.UMItemClass \<\> 0

GROUP BY A.ItemSeq) AS Y ON C.ItemSeq = Y.ItemSeq