---
title: 대표거래처 조회 IsStdCust
date: 2022-11-02
tags: [erp, 개발, SQL]
---

# 대표거래처 조회 IsStdCust

CREATE TABLE \#CreditLimitDataUpperCust (

CustSeq INT ,

BillCustSeq INT ,

StdCustSeq INT )

IF @IsStdCust = '1'

BEGIN

INSERT INTO \#CreditLimitDataUpperCust(CustSeq, BillCustSeq, StdCustSeq)

SELECT DISTINCT B.CustSeq, A.UpperCustSeq, B.UpperCustSeq

FROM \_TDACustGroup AS A WITH(NOLOCK)

JOIN ( SELECT DISTINCT CustSeq, UpperCustSeq

FROM \_TDACustGroup WITH(NOLOCK)

WHERE CompanySeq = @CompanySeq

AND UMCustGroup = 8014001 ) AS B ON B.CustSeq = A.CustSeq

WHERE CompanySeq = @CompanySeq

AND UMCustGroup = 8014002

 

END

 

 

대표거래처 : StdCustSeq

mcf_SWSLSalesPlanHitRateListQuery