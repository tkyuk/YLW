---
title: TopUnitName,UpperUnitName 최상위, 상위
date: 2023-10-10
tags: [erp, 개발, SQL]
---

# TopUnitName,UpperUnitName 최상위, 상위

,M4.ItemName AS TopUnitName

,M4.ItemNo AS TopUnitNo

,M2.ItemNo AS UpperUnitNo

,M2.ItemName AS UpperUnitName

 

 

 

 

-- 최상위

LEFT OUTER JOIN \_TPJTBOM AS M0 WITH(NOLOCK) ON A.CompanySeq = M.CompanySEq

AND A.PJTSeq = M0.PJTSeq

AND A.WBSSeq = M0.BOMSerl

LEFT OUTER JOIN \_TPJTBOM AS M1 WITH(NOLOCK) ON A.CompanySeq = M1.CompanySeq

AND A.PJTSeq = M1.PJTSeq

AND M1.BOMSerl \<\> -1

AND M0.UpperBOMSerl = M1.BOMSerl

AND ISNULL(M1.BeforeBOMSerl,0) = 0 -- 상위 BOM

LEFT OUTER JOIN \_TDAItem AS M2 WITH(NOLOCK) ON A.CompanySEq = M2.CompanySeq

AND M1.ItemSeq = M2.ItemSeq

LEFT OUTER JOIN \_TPJTBOM AS M3 WITH(NOLOCK) ON A.CompanySeq = M3.CompanySeq

AND A.PJTSeq = M3.PJTSeq

AND M3.BOMSerl \<\> -1

AND ISNULL(M3.BeforeBOMSerl,0) = 0

AND SUBSTRING(M1.TreeCode,1,6) = M3.TreeCode -- 최상위

> AND ISNUMERIC(REPLACE(M3.BOMLevel,'.','/')) = 1

LEFT OUTER JOIN \_TDAItem AS M4 WITH(NOLOCK) ON A.CompanySeq = M4.CompanySeq

AND M3.ItemSeq = M4.ItemSeq

참고 SP - ets_SPDMMOutProcItemQuery

 

 

DROP PROC ets_SPDMMOutProcItemQuery

GO

CREATE PROC ets_SPDMMOutProcItemQuery

@xmlDocument NVARCHAR(MAX),

@xmlFlags INT = 0,

@ServiceSeq INT = 0,

@WorkingTag NVARCHAR(10)= '',

@CompanySeq INT = 1,

@LanguageSeq INT = 1,

@UserSeq INT = 0,

@PgmSeq INT = 0

AS

SET NOCOUNT ON

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

DECLARE @docHandle INT,

@MatOutSeq INT,

@BizUnit INT,

@UseType INT

 

EXEC sp_xml_preparedocument @docHandle OUTPUT, @xmlDocument

EXEC sp_xml_removedocument @docHandle

-- 원천테이블

CREATE TABLE \#TMP_SOURCETABLE (IDOrder INT, TABLENAME NVARCHAR(100))

-- 원천 데이터 테이블

CREATE TABLE \#TCOMSourceTracking (IDX_NO INT, IDOrder INT, Seq INT, Serl INT, SubSerl INT,

Qty DECIMAL(19, 5), STDQty DECIMAL(19, 5), Amt DECIMAL(19, 5), VAT DECIMAL(19, 5))

-- 수탁자재 창고담기

CREATE TABLE \#SuTak (IDX_NO INT, CustSeq INT, CustOutWhSeq INT, OutWhName NVARCHAR(100), CustInWhSeq INT, InWhName NVARCHAR(100))

--select @WorkingTag -- S

IF @WorkingTag IN ('','Q')

GOTO QryProc

ELSE IF @WorkingTag IN ('S','L', 'T') -- 출고요청현황에서 점프해 왔을 경우

GOTO FrReqList

ELSE IF @WorkingTag = 'P' -- 외주자재출고요청현황에서 점프해 왔을 경우

GOTO OSPOMat

RETURN

QryProc:

 

CREATE TABLE \#OutItem (WorkingTag NCHAR(1) NULL)

EXEC dbo.\_SCAOpenXmlToTemp @xmlDocument, @xmlFlags, @CompanySeq, @ServiceSeq, 'DataBlock3', '#OutItem'

IF @@ERROR \<\> 0 RETURN

 

SELECT

IDENTITY(INT,0,1) AS IDX_NO

,A.MatOutSeq

,A.OutItemSerl

,A.ItemSeq

,A.OutWHSeq

,A.InWHSeq

,A.UnitSeq

,A.Qty

,A.StdUnitQty

,A.Price

,A.Amt

,A.ItemLotNo

,A.SerialNoFrom

,A.WorkOrderSeq

,A.WorkOrderSerl

,A.ConsgnmtCustSeq

,CASE WHEN ISNULL(A.ConsgnmtCustSeq,0) = 0 THEN ''

ELSE (SELECT CustName FROM \_TDACust WITH(NOLOCK)

WHERE CompanySeq = @CompanySeq

AND CustSeq = A.ConsgnmtCustSeq) END AS ConsgnmtCustName -- 수탁거래처 컬럼 추가 2019.12.16 by 최보라

,A.Remark

,A.OutReqSeq

,A.OutReqItemSerl

,A.PJTSeq

,A.WBSSeq

,W.WorkOrderNo AS WorkOrderNo

,I.ItemName AS ItemName

,I.ItemNo AS ItemNo

,I.Spec AS Spec

,R.Qty AS ReqQty

,U.UnitName AS UnitName

,Q.PJTName AS PJTName -- 프로젝트명

,Q.PJTNo AS PJTNo -- 프로젝트번호

,S.WBSName AS WBSName -- WBS명

,(CASE WHEN A.OutWHSeq \> 0 THEN (SELECT WHName FROM \_TDAWH WHERE CompanySeq = A.CompanySeq AND WHSeq = A.OutWHSeq) ELSE '' END) AS OutWHName

,(CASE WHEN A.InWHSeq \> 0 THEN (SELECT WHName FROM \_TDAWH WHERE CompanySeq = A.CompanySeq AND WHSeq = A.InWHSeq) ELSE '' END) AS InWHName

,M.UseType

,ISNULL(A.AlterRate,0) AS AlterRate

,ISNULL(A.Memo1,'') AS Memo1

,ISNULL(A.Memo2,'') AS Memo2

,ISNULL(A.Memo3,'') AS Memo3

,ISNULL(A.Memo4,0) AS Memo4

,ISNULL(A.Memo5,0) AS Memo5

,ISNULL(A.Memo6,0) AS Memo6 -- 메모1~6컬럼추가 성지원 2016-11-14

,A.MatOutType AS MatOutType -- 반품유형컬럼추가 김지훈 2010-07-14

,A.CustSeq AS CustSeq -- 반품거래처컬럼추가 김지훈 2010-07-14

,CASE WHEN ISNULL(A.CustSeq,0) = 0 THEN ''

ELSE (SELECT CustName FROM \_TDACust WITH(NOLOCK)

WHERE CompanySeq = @CompanySeq

AND CustSeq = A.CustSeq) END AS CustName

,CASE WHEN ISNULL(A.MatOutType,0) = 0 THEN ''

ELSE (SELECT MinorName FROM \_TDAUMinor WITH(NOLOCK)

WHERE CompanySeq = @CompanySeq

AND MinorSeq = A.MatOutType) END AS MatOutTypeName

,P.ProcName

,U2.UnitName AS StdUnitName -- 기준단위 추가 12.12.14 BY 김세호

,U2.UnitSeq AS StdUnitSeq -- 기준단위 추가 12.12.14 BY 김세호

,A.ItemLotNo AS LotNo -- 현재고 조회 LotNo컬럼 추가 20140918 :: 조성환(2014)

,Z.IsLotMng AS IsLotMng -- Lot 관린여부 추가 ::2016.03.24 박수영

,O.OutReqNo AS OutReqNo -- 출고요청번호 추가 16.05.31 임희진

,W.AssyItemSeq

,N.ItemName AS AssyItemName -- 2015.03.12 김용현 추가

,N.ItemNo AS AssyItemNo -- 2015.03.12 김용현 추가

,N.Spec AS AssySpec -- 2015.03.12 김용현 추가

--,L.DWGNo AS DWGNo , -- 도면번호

-- P1.MinorName AS UMMatQualityName , -- 재질

-- L.UMMatQuality AS UMMatQuality , -- 재질코드

-- H.MngValText AS AfterTx , -- 후처리

-- J.MngValText AS HeatTx , -- 열처리

-- X.ItemName AS UpperUnitName , -- Assy명

-- IT.ItemName AS TopUnitName , -- 최상위Unit명

-- CS.CustName AS MakerName -- Maker

-- 자재-추가정보정의로 추가컬럼 조회 23.09.12 SJPARK

,V2.AfterTx AS AfterTx -- 후처리

,V2.HeatTx AS HeatTx -- 열처리

,V2.DWGNo AS DWGNo -- 도면번호

,V2.UMMatQualityName AS UMMatQualityName -- 재질

,V2.UMMatQuality AS UMMatQuality -- 재질코드

,V2.MakerName AS MakerName -- 제조사

,V2.MakerSeq AS MakerSeq -- 제조사코드

,V2.UMSupplyTypeName AS UMSupplyTypeName -- 조달구분

,V2.UMSupplyType AS UMSupplyType -- 조달구분코드

,M4.ItemName AS TopUnitName

,M4.ItemNo AS TopUnitNo

,M2.ItemNo AS UpperUnitNo

,M2.ItemName AS UpperUnitName

INTO \#OutItemList

FROM \_TPDMMOutItem AS A WITH(NOLOCK)

JOIN \_TPDMMOutM AS M WITH(NOLOCK) ON A.CompanySeq = M.CompanySeq

AND A.MatOutSeq = M.MatOutSeq

JOIN \#OutItem AS T ON A.MatOutSeq = T.MatOutSeq

LEFT OUTER JOIN \_TPDMMOutReqItem AS R WITH(NOLOCK) ON A.CompanySeq = R.CompanySeq

AND A.OutReqSeq = R.OutReqSeq

AND A.OutReqItemSerl = R.OutReqItemSerl

LEFT OUTER JOIN \_TPDMMOutReqM AS O WITH(NOLOCK) ON R.CompanySeq = O.CompanySeq

AND R.OutReqSeq = O.OutReqSeq

LEFT OUTER JOIN \_TPDSFCWorkOrder AS W WITH(NOLOCK) ON A.CompanySeq = W.CompanySeq

AND A.WorkOrderSeq = W.WorkOrderSeq

AND A.WorkOrderSerl= W.WorkOrderSerl

LEFT OUTER JOIN \_TDAItem AS I WITH(NOLOCK) ON A.CompanySeq = I.CompanySeq

AND A.ItemSeq = I.ItemSeq

LEFT OUTER JOIN \_TDAUnit AS U WITH(NOLOCK) ON A.CompanySeq = U.CompanySeq

AND A.UnitSeq = U.UnitSeq

LEFT OUTER JOIN \_TDAUnit AS U2 WITH(NOLOCK) ON I.CompanySeq = U2.CompanySeq

AND I.UnitSeq = U2.UnitSeq

LEFT OUTER JOIN \_TPJTProject AS Q WITH(NOLOCK) ON A.CompanySeq = Q.CompanySeq

AND A.PJTSeq = Q.PJTSeq

LEFT OUTER JOIN \_TPJTWBS AS S WITH(NOLOCK) ON A.CompanySeq = S.CompanySeq

AND A.PJTSeq = S.PJTSeq

AND A.WBSSeq = S.WBSSeq

LEFT OUTER JOIN \_TPDBaseProcess AS P WITH(NOLOCK) ON A.CompanySeq = P.CompanySeq

AND W.ProcSeq = P.ProcSeq

LEFT OUTER JOIN \_TDAItemStock AS Z WITH(NOLOCK) ON A.ItemSeq = Z.ItemSeq

AND Z.CompanySeq = @CompanySeq

--2018.01.02 박수영 ::작업지시의 공정품으로 가져온다.(작업지시 1건을 분할하여 처리할 경우 중복 조회됨)

--LEFT OUTER JOIN \_TPDMMOutGood AS K WITH(NOLOCK) ON A.WorkOrderSeq = K.WorkOrderSeq

-- AND A.WorkOrderSerl = K.WorkOrderSerl

-- AND A.MatOutSeq = K.MatOutSeq

-- AND A.CompanySeq = K.CompanySeq

LEFT OUTER JOIN \_TDAItem AS N WITH(NOLOCK) ON W.AssyItemSeq = N.ItemSeq

AND W.CompanySeq = N.CompanySeq -- 2015.03.12 김용현 추가

-- 자재 추가정보 뷰테이블로 변경 23.09.12 SJPARK

LEFT OUTER JOIN ets_VDAItemPjtInfo AS V2 WITH(NOLOCK) ON V2.CompanySeq = A.CompanySeq

AND V2.ItemSeq = A.ItemSeq

-- 최상위

LEFT OUTER JOIN \_TPJTBOM AS M0 WITH(NOLOCK) ON A.CompanySeq = M.CompanySEq

AND A.PJTSeq = M0.PJTSeq

AND A.WBSSeq = M0.BOMSerl

LEFT OUTER JOIN \_TPJTBOM AS M1 WITH(NOLOCK) ON A.CompanySeq = M1.CompanySeq

AND A.PJTSeq = M1.PJTSeq

AND M1.BOMSerl \<\> -1

AND M0.UpperBOMSerl = M1.BOMSerl

AND ISNULL(M1.BeforeBOMSerl,0) = 0 -- 상위 BOM

LEFT OUTER JOIN \_TDAItem AS M2 WITH(NOLOCK) ON A.CompanySEq = M2.CompanySeq

AND M1.ItemSeq = M2.ItemSeq

LEFT OUTER JOIN \_TPJTBOM AS M3 WITH(NOLOCK) ON A.CompanySeq = M3.CompanySeq

AND A.PJTSeq = M3.PJTSeq

AND M3.BOMSerl \<\> -1

AND ISNULL(M3.BeforeBOMSerl,0) = 0

AND SUBSTRING(M1.TreeCode,1,6) = M3.TreeCode -- 최상위

> AND ISNUMERIC(REPLACE(M3.BOMLevel,'.','/')) = 1

LEFT OUTER JOIN \_TDAItem AS M4 WITH(NOLOCK) ON A.CompanySeq = M4.CompanySeq

AND M3.ItemSeq = M4.ItemSeq

WHERE A.CompanySeq = @CompanySeq

 

-- 외주는 요청수량을 외주발주에서 가져와야하므로 수정.

-- 우선은 코딩의 편리성을 위해서 (아직 추가, 수정할 것이 많기 때문에) 이렇게 하지만 추후 조회성능을 위해서 출고유형별로 분기할 필요 있음. (정동혁)

UPDATE A

SET ReqQty = M.Qty

FROM \#OutItemList AS A

JOIN \_TPDOSPPOItemMat AS M WITH(NOLOCK) ON A.OutReqSeq = M.OSPPOSeq

AND A.OutReqItemSerl = M.OSPMatSerl

AND M.CompanySeq = @CompanySeq

WHERE A.UseType IN (6044003,6044004)

-- 최상위Unit품목,상위Unit품목 가져오기 위해 구매요청 SourceTracking로직 추가 19.06.24 By 이혜민

-- \[프로젝트자재출고등록\] 최상위Unit품명, 최상위Unit품번, 상위Unit품명, 상위Unit품번 추가

INSERT \#TMP_SOURCETABLE

SELECT 1, '\_TPUORDPOReqItem'

EXEC \_SCOMSourceTracking @CompanySeq, '\_TPDMMOutItem', '#OutItemList', 'MatOutSeq', 'OutItemSerl', ''

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

RETURN

FrReqList:

-- 조회조건을 임시테이블로 생성

CREATE TABLE \#ReqList (WorkingTag NCHAR(1) NULL)

EXEC dbo.\_SCAOpenXmlToTemp @xmlDocument, @xmlFlags, @CompanySeq, @ServiceSeq, 'DataBlock3', '#ReqList'

IF @@ERROR \<\> 0 RETURN

IF EXISTS (SELECT 1 FROM \#ReqList WHERE FromTableSeq = 50 )

GOTO OSPOMat

SELECT A.IDX_NO AS IDX_NO

--IDENTITY(INT,1,1) AS IDX_NO

,W.WorkOrderNo AS WorkOrderNo

,I.ItemName AS ItemName

,I.ItemNo AS ItemNo

,I.Spec AS Spec

,U.UnitName AS UnitName

,R.Qty AS ReqQty

,R.Qty

,R.Remark AS Remark

,R.ItemSeq AS ItemSeq

,R.UnitSeq AS UnitSeq

,R.OutReqSeq AS OutReqSeq

,R.OutReqItemSerl AS OutReqItemSerl

,R.WorkOrderSeq AS WorkOrderSeq

,R.WorkOrderSerl AS WorkOrderSerl

,R.PJTSeq

,R.WBSSeq

,M.IsReturn

,Q.PJTName AS PJTName -- 프로젝트명

,Q.PJTNo AS PJTNo -- 프로젝트번호

,S.WBSName AS WBSName -- WBS명

,ISNULL(C.FieldWhSeq,0) AS InWHSeq

,ISNULL(C.MatOutWhSeq,0) AS OutWHSeq -- 창고별품목이 아니면 워크센터의 출고창고.

,M.FactUnit AS FactUnit

,0 AS SMDelvType

,W.GoodItemSeq AS GoodItemSeq

,R.MatOutType AS MatOutType -- 반품유형컬럼추가 김지훈 2010-07-14

,R.CustSeq AS CustSeq -- 반품거래처컬럼추가 김지훈 2010-07-14

,CASE WHEN ISNULL(R.CustSeq,0) = 0 THEN ''

ELSE (SELECT CustName FROM \_TDACust WITH(NOLOCK)

WHERE CompanySeq = @CompanySeq

AND CustSeq = R.CustSeq

)

END AS CustName

,CASE WHEN ISNULL(R.MatOutType,0) = 0 THEN ''

ELSE (SELECT MinorName FROM \_TDAUMinor WITH(NOLOCK)

WHERE CompanySeq = @CompanySeq

AND MinorSeq = R.MatOutType

)

END AS MatOutTypeName

,W.ItemBomRev

,W.ProcRev

,W.ProcSeq

,FU.FactUnitName AS FactUnitName -- 생산사업장명 추가 엄효진 2010-11-26

,M.IsOutSide AS IsOutSide -- 외주여부 추가 엄효진 2010-11-26

,M.SupplyContCustSeq AS SupplyContCustSeq -- 외주처 추가 엄효진 2010-11-26

,MC.CustName AS SupplyContCustName -- 외주처명 추가 엄효진 2010-11-26

,U2.UnitName AS StdUnitName -- 기준단위 추가 12.12.14 BY 김세호

,U2.UnitSeq AS StdUnitSeq -- 기준단위 추가 12.12.14 BY 김세호

,R.WorkCenterSeq AS WorkCenterSeq, --외주거래처 정보를 가져오기 위해서 WorkCenter값으로 찾아오기위해 추가(외주추가경우) --2013.02.13 by 허승남

Z.IsLotMng

,K.AssyItemSeq

,N.ItemName AS AssyItemName -- 2015.03.12 김용현 추가

,N.ItemNo AS AssyItemNo -- 2015.03.12 김용현 추가

,N.Spec AS AssySpec -- 2015.03.12 김용현 추가

,M.OutReqNo AS OutReqNo -- 2016.05.31 임희진 추가

,ISNULL(R.Memo1,'') AS Memo1

,ISNULL(R.Memo2,'') AS Memo2

,ISNULL(R.Memo3,'') AS Memo3

,ISNULL(R.Memo4,0) AS Memo4

,ISNULL(R.Memo5,0) AS Memo5

,ISNULL(R.Memo6,0) AS Memo6 -- 2016.11.14 성지원 추가

,M.UseType AS UseType

,R.RealLotNo AS ItemLotNo -- 2017.12.14 이형민 추가 :: 프로젝트자재반품등록 화면에서 조회

-- 자재-추가정보정의로 추가컬럼 조회 23.09.12 SJPARK

,V2.AfterTx AS AfterTx -- 후처리

,V2.HeatTx AS HeatTx -- 열처리

,V2.DWGNo AS DWGNo -- 도면번호

,V2.UMMatQualityName AS UMMatQualityName -- 재질

,V2.UMMatQuality AS UMMatQuality -- 재질코드

,V2.MakerName AS MakerName -- 제조사

,V2.MakerSeq AS MakerSeq -- 제조사코드

,V2.UMSupplyTypeName AS UMSupplyTypeName -- 조달구분

,V2.UMSupplyType AS UMSupplyType -- 조달구분코드

,M4.ItemName AS TopUnitName

,M4.ItemNo AS TopUnitNo

,M2.ItemNo AS UpperUnitNo

,M2.ItemName AS UpperUnitName

INTO \#TPDMMOutReqItem

FROM \_TPDMMOutReqItem AS R WITH(NOLOCK)

JOIN \_TPDMMOutReqM AS M WITH(NOLOCK) ON ( M.CompanySeq = @CompanySeq AND R.OutReqSeq = M.OutReqSeq )

JOIN \#ReqList AS A ON R.OutReqSeq = A.OutReqSeq AND (R.OutReqItemSerl = A.OutReqItemSerl OR A.OutReqItemSerl = 0 )

LEFT OUTER JOIN \_TPDSFCWorkOrder AS W WITH(NOLOCK) ON R.CompanySeq = W.CompanySeq

AND R.WorkOrderSeq = W.WorkOrderSeq

AND R.WorkOrderSerl= W.WorkOrderSerl

LEFT OUTER JOIN \_TDAUnit AS U WITH(NOLOCK) ON R.CompanySeq = U.CompanySeq

AND R.UnitSeq = U.UnitSeq

LEFT OUTER JOIN \_TDAItem AS I WITH(NOLOCK) ON ( I.CompanySeq = @CompanySeq AND I.ItemSeq = R.ItemSeq ) --2015.07.15 임희진 (LEFT OUTER JOIN 으로 수정)

LEFT OUTER JOIN \_TDAItemStock AS Z WITH(NOLOCK) ON ( Z.CompanySeq = @CompanySeq AND Z.ItemSeq = R.ItemSeq ) --2015.07.15 임희진 (LEFT OUTER JOIN 으로 수정)

LEFT OUTER JOIN \_TDAUnit AS U2 WITH(NOLOCK) ON I.CompanySeq = U2.CompanySeq

AND I.UnitSeq = U2.UnitSeq

LEFT OUTER JOIN \_TPJTProject AS Q WITH(NOLOCK) ON R.CompanySeq = Q.CompanySeq

AND R.PJTSeq = Q.PJTSeq

LEFT OUTER JOIN \_TPJTWBS AS S WITH(NOLOCK) ON R.CompanySeq = S.CompanySeq

AND R.PJTSeq = S.PJTSeq

AND R.WBSSeq = S.WBSSeq

LEFT OUTER JOIN \_TPDBaseWorkCenter AS C WITH(NOLOCK) ON R.CompanySeq = C.CompanySeq

AND R.WorkCenterSeq= C.WorkCenterSeq

LEFT OUTER JOIN \_TDAFactUnit AS FU WITH(NOLOCK) ON M.CompanySeq = FU.CompanySeq -- 생산사업장명 추가 엄효진 2010-11-26

AND M.FactUnit = FU.FactUnit

LEFT OUTER JOIN \_TDACust AS MC WITH(NOLOCK) ON M.CompanySeq = MC.CompanySeq

AND M.SupplyContCustSeq = MC.CustSeq

LEFT OUTER JOIN \_TPDMMOutReqGood AS K WITH(NOLOCK) ON R.WorkOrderSeq = K.WorkOrderSeq

AND R.WorkOrderSerl = K.WorkOrderSerl

AND R.OutReqSeq = K.OutReqSeq

AND R.CompanySeq = K.CompanySeq

LEFT OUTER JOIN \_TDAItem AS N WITH(NOLOCK) ON K.AssyItemSeq = N.ItemSeq

AND K.CompanySeq = N.CompanySeq -- 2015.03.12 김용현 추가

-- 자재 추가정보 뷰테이블로 변경 23.09.12 SJPARK

LEFT OUTER JOIN ets_VDAItemPjtInfo AS V2 WITH(NOLOCK) ON V2.CompanySeq = R.CompanySeq

AND V2.ItemSeq = R.ItemSeq

-- 최상위

LEFT OUTER JOIN \_TPJTBOM AS M0 WITH(NOLOCK) ON R.CompanySeq = M.CompanySEq

AND R.PJTSeq = M0.PJTSeq

AND R.WBSSeq = M0.BOMSerl

LEFT OUTER JOIN \_TPJTBOM AS M1 WITH(NOLOCK) ON R.CompanySeq = M1.CompanySeq

AND R.PJTSeq = M1.PJTSeq

AND M1.BOMSerl \<\> -1

AND M0.UpperBOMSerl = M1.BOMSerl

AND ISNULL(M1.BeforeBOMSerl,0) = 0 -- 상위 BOM

LEFT OUTER JOIN \_TDAItem AS M2 WITH(NOLOCK) ON R.CompanySEq = M2.CompanySeq

AND M1.ItemSeq = M2.ItemSeq

LEFT OUTER JOIN \_TPJTBOM AS M3 WITH(NOLOCK) ON R.CompanySeq = M3.CompanySeq

AND R.PJTSeq = M3.PJTSeq

AND M3.BOMSerl \<\> -1

AND ISNULL(M3.BeforeBOMSerl,0) = 0

AND SUBSTRING(M1.TreeCode,1,6) = M3.TreeCode -- 최상위

> AND ISNUMERIC(REPLACE(M3.BOMLevel,'.','/')) = 1

LEFT OUTER JOIN \_TDAItem AS M4 WITH(NOLOCK) ON R.CompanySeq = M4.CompanySeq

AND M3.ItemSeq = M4.ItemSeq

WHERE R.CompanySeq = @CompanySeq

AND R.Qty \<\> 0

AND ISNULL(Q.ISComplete,'') \<\> '1' -- 완료프로젝트는 뺌

AND ISNULL(R.IsStop, '') \<\> '1' -- 중단처리된 데이터는 제외

AND ISNULL(M.IsStop, '') \<\> '1' -- 현황에서 중단처리될 경우, 마스터의 IsStop 만 처리되기 때문에 추가 2016.05.26 박수영

AND ISNULL(Q.IsStop,'') \<\> '1' -- 중단처리된 프로젝트 제외 :: 2020.10.22 나태형

--출고요청(외주추가)인 경우, 입고창고를 워크센터의 현장창고가 아닌 창고등록에 있는 사업부문, 생산사업장, 위탁거래처의 창고로 가져오도록 변경(2013.01.07 by snheo)

IF @WorkingTag = 'T' OR EXISTS (SELECT 1 FROM \#TPDMMOutReqItem WHERE UseType = 6044004)

BEGIN

--거래처가 저장이 되어있지 않을 경우, 워크센터 값을 이용해서 외주거래처 찾아옴.

UPDATE \#TPDMMOutReqItem SET CustSeq = B.CustSeq

FROM \#TPDMMOutReqItem AS A

JOIN \_TPDBaseWorkCenter AS B ON A.WorkCenterSeq = B.WorkCenterSeq

WHERE B.CompanySeq = @CompanySeq

 

-- 생산사업장과 엮여있는 사업부문 코드 가져오기

SELECT @BizUnit = A.BizUnit

FROM \_TDAFactUnit AS A

WHERE A.CompanySeq = @CompanySeq

AND A.FactUnit IN (SELECT TOP 1 M.FactUnit

FROM \_TPDMMOutReqItem AS R WITH(NOLOCK)

JOIN \_TPDMMOutReqM AS M ON R.CompanySeq = M.CompanySeq

AND R.OutReqSeq = M.OutReqSeq

JOIN \#ReqList AS A ON R.OutReqSeq = A.OutReqSeq

AND (R.OutReqItemSerl = A.OutReqItemSerl OR A.OutReqItemSerl = 0 )

WHERE R.CompanySeq = @CompanySeq

)

 

UPDATE \#TPDMMOutReqItem

SET InWHSeq = ISNULL(CASE ISNULL(E.WHSeq, 0) WHEN 0

THEN (SELECT TOP 1 WHSeq FROM \_TDAWH WHERE CompanySeq = @CompanySeq AND A.CustSeq = CommissionCustSeq AND IsNotUse \<\> '1' AND SMWHKind = 8002024 AND BizUnit = @BizUnit)

ELSE E.WHSeq END,0)

FROM \#TPDMMOutReqItem AS A

LEFT OUTER JOIN \_TDAWH AS E WITH(NOLOCK) ON E.CompanySeq = @CompanySeq

AND A.FactUnit = E.FactUnit

AND A.CustSeq = E.CommissionCustSeq

AND E.SMWHKind = 8002024

AND @BizUnit = E.BizUnit

AND E.IsNotUse \<\> '1'

END

--==============================================--

-- 1순위 품목별 기본창고에서 출고창고가져오기 -- 2014.11.04 김용현 수정

--==============================================--

UPDATE \#TPDMMOutReqItem

SET OutWHSeq = ISNULL(B.OutWHSeq,0)

FROM \#TPDMMOutReqItem AS A

JOIN \_TDAItemStdWh AS B WITH(NOLOCK) ON A.ItemSeq = B.ItemSeq

AND A.FactUnit = B.FactUnit

AND B.CompanySeq = @CompanySeq

--===========================================================--

-- 2순위 1순위가 없다면, 워크센터의 불출창고로 가져오도록 함 -- 2014.11.04 김용현 추가

--===========================================================--

UPDATE \#TPDMMOutReqItem

SET OutWHSeq = ISNULL(B.MatOutWhSeq,0)

FROM \#TPDMMOutReqItem AS A

JOIN \_TPDBaseWorkCenter AS B WITH(NOLOCK) ON A.WorkCenterSeq = B.WorkCenterSeq

AND A.FactUnit = B.FactUnit

AND B.CompanySeq = @CompanySeq

WHERE ISNULL(A.OutWHSeq,0) = 0

-- 조달구분.

-- 같은 제품에 같은 자재가 달리는 경우 2줄로 조회되어서 따로 뺌. 2010.07.20 정동혁

UPDATE W

SET SMDelvType = D.SMDelvType

FROM \#TPDMMOutReqItem AS W

JOIN \_TPDROUItemProcMat AS D ON D.CompanySeq = @CompanySeq

AND W.GoodItemSeq = D.ItemSeq

AND W.ItemBOMRev = D.BOMRev

AND W.ProcRev = D.ProcRev

AND W.ProcSeq = D.ProcSeq

AND W.ItemSeq = D.MatItemSeq

 

--===================================================================================================

-- 수탁자재가 존재할 경우

--1. \[거래처별OEM품목등록\] 에서 해당 품목에 연결된 거래처

--2. 원천 생산의뢰의 거래처

--3. 반제품생산계획의 원천 생산의뢰가 존재하지 않을 경우, 모제품의 원천 생산의뢰 거래처 :: 19.05.28 \#임희진 추가

--===================================================================================================

IF (SELECT Count(\*) FROM \#TPDMMOutReqItem WHERE SMDelvType = 6032004) \> 0

BEGIN

INSERT INTO \#SuTak(IDX_NO, CustSeq , CustOutWhSeq, OutWhName, CustInWhSeq, InWhName)

SELECT A.IDX_NO, B.CustSeq, 0, '', 0,''

FROM \#TPDMMOutReqItem AS A

JOIN \_TPDBaseCustOEMItem AS B ON A.GoodItemSeq = B.ItemSeq AND CompanySeq = @CompanySeq

WHERE A.SMDelvType = 6032004

/\*\*\*\*\*\*\*\*\*\*\*\[수탁자재 창고 담기\] 송기연 추가 \*\*\*\*\*\*\*\*\*\*\*\*\*\*/

DELETE FROM \#TCOMSourceTracking

DELETE FROM \#TMP_SOURCETABLE

INSERT \#TMP_SOURCETABLE

SELECT 1, '\_TPDMPSProdReqItem' -- 생산의뢰

-- 원천 생산의뢰를 찾기위해 대상 담기

SELECT A.IDX_NO, A.WorkOrderSeq, A.WorkOrderSerl

INTO \#ConsignTemp

FROM \#TPDMMOutReqItem AS A

LEFT OUTER JOIN \#SuTak AS B ON A.IDX_NO = B.IDX_NO

WHERE SMDelvType = 6032004 -- 조달구분(수탁)

AND ISNULL(WorkOrderSeq,0) \<\> 0 -- 작업지시 존재하는 건

AND B.IDX_NO IS NULL

EXEC \_SCOMSourceTracking @CompanySeq, '\_TPDSFCWorkOrder', '#ConsignTemp','WorkOrderSeq', 'WorkOrderSerl',''

--수탁품에 대해서만 적용될 수 있도록 변경 -- 2014.12.08 노영진

--원천 생산의뢰가 존재할 경우 담기

INSERT INTO \#SuTak(IDX_NO, CustSeq , CustOutWhSeq, OutWhName, CustInWhSeq, InWhName)

SELECT DISTINCT

A.IDX_NO ,

ISNULL(T.CustSeq, 0) AS CustSeq ,

0, '', 0, ''

FROM \#TCOMSourceTracking AS A

JOIN \_TPDMPSProdReqItem AS T WITH(NOLOCK) ON A.Seq = T.ProdReqSeq AND A.Serl = T.Serl

JOIn \#ConsignTemp AS B ON A.IDX_NO = B.IDX_NO

WHERE T.CompanySeq = @CompanySeq

-- 원천 생산의뢰가 존재하지 않거나, 거래처가 입력되지 않은 경우 반제품생산계획 건인지 확인.

-- 반제품생산계획이라면 모제품 생산계획코드를 담는다. (반제품생산계획의 원천 생산의뢰 존재하지 않을 경우, 모제품의 원천 생산의뢰 거래처를 가져오기 위함)

SELECT A.IDX_NO, D.ProdPlanSeq

INTO \#ProdPlanSource

FROM \#ConsignTemp AS A

LEFT OUTER JOIN \#SuTak AS B ON A.IDX_NO = B.IDX_NO

JOIN \_TPDSFCWorkOrder AS C WITH(NOLOCK) ON C.CompanySeq = @CompanySeq

AND A.WorkOrderSeq = C.WorkOrderSeq

AND A.WorkOrderSerl= C.WorkOrderSerl

JOIN \_TPDDailyProdPlanSemiPlan AS D WITH(NOLOCK) ON C.ProdPlanSeq = D.SemiProdPlanSeq -- 반제품생산계획

AND C.CompanySeq = D.CompanySeq

WHERE B.IDX_NO IS NULL -- 원천 생산의뢰가 없는 건만

-- 모제품생산계획코드로 생산의뢰 찾기

DELETE FROM \#TCOMSourceTracking

EXEC \_SCOMSourceTracking @CompanySeq, '\_TPDMPSDailyProdPlan', '#ProdPlanSource','ProdPlanSeq', '',''

-- 모제품생산계획의 원천 생산의뢰가 존재할 경우 담기

INSERT INTO \#SuTak(IDX_NO , CustSeq , CustOutWhSeq, OutWhName, CustInWhSeq, InWhName )

SELECT DISTINCT

A.IDX_NO ,

ISNULL(T.CustSeq, 0) AS CustSeq,

0, '', 0, ''

FROM \#TCOMSourceTracking AS A

JOIN \_TPDMPSProdReqItem AS T WITH(NOLOCK) ON A.Seq = T.ProdReqSeq AND A.Serl = T.Serl

JOIN \#ConsignTemp AS B ON A.IDX_NO = B.IDX_NO

LEFT OUTER JOIN \#SuTak AS C ON A.IDX_NO = C.IDX_NO

WHERE T.CompanySeq = @CompanySeq

AND C.IDX_NO IS NULL -- 원천 생산의뢰가 없는 건만

UPDATE \#SuTak

SET CustOutWhSeq = B.WHSeq,OutWHName = B.WHName

FROM \#SuTak AS A JOIN \_TDAWHSub AS B ON A.CustSeq = B.TrustCustSeq AND B.SMWHKind = 8002004 AND B.CompanySeq = @CompanySeq -- 2014.05.27

-- 법인코드추가 김용현

UPDATE \#SuTak

SET CustInWhSeq = C.WHSeq,InWHName = C.WHName

FROM \#SuTak AS A JOIN \#TPDMMOutReqItem AS B ON A.IDX_No = B.IDX_No

JOIN \_TDAWHSub AS C ON B.InWhSeq = C.UPWhSeq AND C.SMWHKind = 8002004 and C.CompanySeq = @CompanySeq

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

END

-- 출고수량에서 기출고수량빼기

SELECT

R.OutReqSeq

,R.OutReqItemSerl

,SUM(R.Qty) AS Qty

INTO \#PrevQty

FROM \_TPDMMOutItem AS R WITH(NOLOCK)

JOIN \_TPDMMOutM AS M WITH(NOLOCK) ON R.CompanySeq = M.CompanySeq

AND R.MatOutSeq = M.MatOutSeq

WHERE R.CompanySeq = @CompanySeq

AND M.UseType IN (6044001,6044002,6044004, 6044005)

AND EXISTS (SELECT 1 FROM \#ReqList WHERE OutReqSeq = R.OutReqSeq AND (OutReqItemSerl = R.OutReqItemSerl OR OutReqItemSerl = 0 ))

GROUP BY

R.OutReqSeq

,R.OutReqItemSerl

UPDATE \#TPDMMOutReqItem

SET InWHSeq = ISNULL(A.OutWHSeq,0) ,

OutWHSeq = ISNULL(A.InWHSeq,0)

FROM \#TPDMMOutReqItem AS A

WHERE IsReturn = '1'

UPDATE A

SET Qty = A.Qty - P.Qty

FROM \#TPDMMOutReqItem AS A

JOIN \#PrevQty AS P ON A.OutReqSeq = P.OutReqSeq

AND A.OutReqItemSerl = P.OutReqItemSerl

-- 최상위Unit품목,상위Unit품목 가져오기 위해 구매요청 SourceTracking로직 추가 19.06.24 By 이혜민

-- \[프로젝트자재출고요청\] -\> \[프로젝트자재출고등록\] Jump 시 최상위Unit품명, 최상위Unit품번, 상위Unit품명, 상위Unit품번 가져가도록 추가

DELETE FROM \#TCOMSourceTracking

DELETE FROM \#TMP_SOURCETABLE

INSERT \#TMP_SOURCETABLE

SELECT 1, '\_TPUORDPOReqItem' -- 구매요청

EXEC \_SCOMSourceTracking @CompanySeq, '\_TPDMMOutReqItem', '#TPDMMOutReqItem', 'OutReqSeq', 'OutReqItemSerl', ''

SELECT A.\*

,(CASE WHEN A.OutWHSeq \> 0 THEN (SELECT WHName FROM \_TDAWH WHERE CompanySeq = @CompanySeq AND WHSeq = A.OutWHSeq) ELSE '' END ) AS OutWHName

,(CASE WHEN A.InWHSeq \> 0 THEN (SELECT WHName FROM \_TDAWH WHERE CompanySeq = @CompanySeq AND WHSeq = A.InWHSeq) ELSE '' END ) AS InWHName -- 반품인 경우

, B.CustSeq AS ConsgnmtCustSeq

, X.CustName AS ConsgnmtCustName

, F.ItemName AS TopUnitName

, F.ItemNo AS TopUnitNo

, G.ItemName AS UpperUnitName

, G.ItemNo AS UpperUnitNo

FROM \#TPDMMOutReqItem AS A

LEFT OUTER JOIN \#SuTak AS B ON A.IDX_NO = B.IDX_NO

LEFT OUTER JOIN \#TCOMSourceTracking AS S WITH(NOLOCK) ON A.IDX_NO = S.IDX_NO

LEFT OUTER JOIN \_TPUORDPOReqItem AS P WITH(NOLOCK) ON P.CompanySeq = @CompanySeq

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

LEFT OUTER JOIN \_TDACust AS X WITH(NOLOCK) ON P.CompanySeq = X.CompanySeq

AND P.CustSeq = X.CustSeq

WHERE (A.Qty \> 0 OR @WorkingTag \<\> 'L')

AND A.Qty \<\> 0

RETURN

OSPOMat:

-- 조회조건을 임시테이블로 생성

CREATE TABLE \#ReqPOList (WorkingTag NCHAR(1) NULL)

EXEC dbo.\_SCAOpenXmlToTemp @xmlDocument, @xmlFlags, @CompanySeq, @ServiceSeq, 'DataBlock3', '#ReqPOList'

IF @@ERROR \<\> 0 RETURN

UPDATE \#ReqPOList

SET OSPPOSeq = A.OutReqSeq ,

OSPMatSerl = A.OutReqItemSerl

FROM \#ReqPOList AS A

 

-- 생산사업장과 엮여있는 사업부문 코드 가져오기

SELECT @BizUnit = A.BizUnit

FROM \_TDAFactUnit AS A

WHERE A.CompanySeq = @CompanySeq

AND A.FactUnit IN (SELECT TOP 1 M.FactUnit

FROM \_TPDOSPPOItemMat AS R WITH(NOLOCK)

JOIN \_TPDOSPPO AS M ON R.CompanySeq = M.CompanySeq

AND R.OSPPOSeq = M.OSPPOSeq

JOIN \#ReqPOList AS A ON R.OSPPOSeq = A.OSPPOSeq

AND R.OSPMatSerl = A.OSPMatSerl

WHERE R.CompanySeq = @CompanySeq

)

SELECT

A.IDX_NO AS IDX_NO

,W.WorkOrderNo AS WorkOrderNo

,I.ItemName AS ItemName

,I.ItemNo AS ItemNo

,I.Spec AS Spec

,U.UnitName AS UnitName

,R.Qty AS ReqQty

,R.Qty AS Qty

,R.Remark AS Remark

,R.ItemSeq AS ItemSeq

,R.UnitSeq AS UnitSeq

,R.OSPPOSeq AS OutReqSeq

,R.OSPMatSerl AS OutReqItemSerl

,R.WorkOrderSeq AS WorkOrderSeq

,R.WorkOrderSerl AS WorkOrderSerl

,W.PJTSeq

,W.WBSSeq

,Q.PJTName AS PJTName -- 프로젝트명

,Q.PJTNo AS PJTNo -- 프로젝트번호

,S.WBSName AS WBSName -- WBS명

-- 사업부문, 생산사업장, 위탁처의 생산외주창고를 가져오되 없으면, 생산사업장 조건 제외 BY 11.11.22 김세호 수정

,CASE ISNULL(E.WHSeq, 0) WHEN 0

THEN (SELECT TOP 1 WHSeq FROM \_TDAWH WHERE M.CompanySeq= CompanySeq AND M.CustSeq = CommissionCustSeq AND IsNotUse \<\> '1' AND SMWHKind = 8002024 AND BizUnit = @BizUnit)

ELSE E.WHSeq END AS InWHSeq

 

,C.MatOutWhSeq AS OutWHSeq -- 창고별품목이 아니면 워크센터의 출고창고.

,M.FactUnit AS FactUnit

,U2.UnitName AS StdUnitName -- 기준단위 추가 12.12.14 BY 김세호

,U2.UnitSeq AS StdUnitSeq -- 기준단위 추가 12.12.14 BY 김세호

,K.OSPAssySeq AS AssyItemSeq

,N.ItemName AS AssyItemName -- 2015.03.16 김용현 추가

,N.ItemNo AS AssyItemNo -- 2015.03.16 김용현 추가

,N.Spec AS AssySpec -- 2015.03.16 김용현 추가

,Z.IsLotMng -- 2016.03.24 박수영 추가

,M.OSPPONo AS OutReqNo -- 2016.05.31 임희진 추가

,ISNULL(R.Memo1,'') AS Memo1

,ISNULL(R.Memo2,'') AS Memo2

,ISNULL(R.Memo3,'') AS Memo3

,ISNULL(R.Memo4,0) AS Memo4

,ISNULL(R.Memo5,0) AS Memo5

,ISNULL(R.Memo6,0) AS Memo6 -- 2020.12.02 최보라 추가

INTO \#TPDMMOutReqPOItem

FROM \_TPDOSPPOItemMat AS R WITH(NOLOCK)

JOIN \_TPDOSPPO AS M ON R.CompanySeq = M.CompanySeq

AND R.OSPPOSeq = M.OSPPOSeq

JOIN \#ReqPOList AS A ON R.OSPPOSeq = A.OSPPOSeq

AND R.OSPMatSerl = A.OSPMatSerl

LEFT OUTER JOIN \_TPDSFCWorkOrder AS W WITH(NOLOCK) ON R.CompanySeq = W.CompanySeq

AND R.WorkOrderSeq = W.WorkOrderSeq

AND R.WorkOrderSerl= W.WorkOrderSerl

LEFT OUTER JOIN \_TDAUnit AS U WITH(NOLOCK) ON R.CompanySeq = U.CompanySeq

AND R.UnitSeq = U.UnitSeq

LEFT OUTER JOIN \_TDAItem AS I WITH(NOLOCK) ON R.CompanySeq = I.CompanySeq

AND R.ItemSeq = I.ItemSeq

LEFT OUTER JOIN \_TDAUnit AS U2 WITH(NOLOCK) ON I.CompanySeq = U2.CompanySeq

AND I.UnitSeq = U2.UnitSeq

LEFT OUTER JOIN \_TPJTProject AS Q WITH(NOLOCK) ON W.CompanySeq = Q.CompanySeq

AND W.PJTSeq = Q.PJTSeq

LEFT OUTER JOIN \_TPJTWBS AS S WITH(NOLOCK) ON W.CompanySeq = S.CompanySeq

AND W.PJTSeq = S.PJTSeq

AND W.WBSSeq = S.WBSSeq

LEFT OUTER JOIN \_TPDBaseWorkCenter AS C WITH(NOLOCK) ON R.CompanySeq = C.CompanySeq

AND W.WorkCenterSeq= C.WorkCenterSeq

LEFT OUTER JOIN \_TDAWH AS E WITH(NOLOCK) ON M.CompanySeq = E.CompanySeq

AND M.FactUnit = E.FactUnit

AND M.CustSeq = E.CommissionCustSeq

AND E.SMWHKind = 8002024

AND @BizUnit = E.BizUnit

AND E.IsNotUse \<\> '1'

LEFT OUTER JOIN \_TPDOSPPOItem AS K WITH(NOLOCK) ON R.OSPPOSeq = K.OSPPOSeq

AND R.OSPPOSerl = K.OSPPOSerl

AND R.companySeq = K.companySeq

LEFT OUTER JOIN \_TDAItem AS N WITH(NOLOCK) ON K.OSPAssySeq = N.ItemSeq

AND K.companySeq = N.CompanySeq -- 2015.03.16 김용현 추가

LEFT OUTER JOIN \_TDAItemStock AS Z WITH(NOLOCK) ON R.ItemSeq = Z.ItemSeq

AND Z.CompanySeq = @CompanySeq

WHERE R.CompanySeq = @CompanySeq

AND ISNULL(R.IsSale,'') \<\> '1'

-- 품목별 기본창고에서 출고창고가져오기

UPDATE \#TPDMMOutReqPOItem

SET OutWHSeq = B.OutWHSeq

FROM \#TPDMMOutReqPOItem AS A

JOIN \_TDAItemStdWh AS B WITH(NOLOCK) ON A.ItemSeq = B.ItemSeq

AND A.FactUnit = B.FactUnit

AND B.CompanySeq = @CompanySeq

-- 출고수량에서 기출고수량빼기

SELECT

R.OutReqSeq

,R.OutReqItemSerl

,SUM(R.Qty ) AS Qty

INTO \#PrevPOQty

FROM \_TPDMMOutItem AS R WITH(NOLOCK)

JOIN \_TPDMMOutM AS M WITH(NOLOCK) ON R.CompanySeq = M.CompanySeq

AND R.MatOutSeq = M.MatOutSeq

WHERE R.CompanySeq = @CompanySeq

AND M.UseType IN (6044003,6044004)

AND EXISTS (SELECT 1 FROM \#ReqPOList WHERE OutReqSeq = R.OutReqSeq AND OutReqItemSerl = R.OutReqItemSerl)

AND R.ProgFromTableSeq = 50 -- 2011. 2. 7 hkim 외주건만 수량을 가져와야 하는데 생산의 자재요청에서 넘어온 건도 OutReqSeq가 같으면 빠지게 되어 수정

GROUP BY

R.OutReqSeq

,R.OutReqItemSerl

 

UPDATE A

SET Qty = A.Qty - P.Qty

FROM \#TPDMMOutReqPOItem AS A

JOIN \#PrevPOQty AS P ON A.OutReqSeq = P.OutReqSeq

AND A.OutReqItemSerl = P.OutReqItemSerl

SELECT A.\*

,(CASE WHEN A.OutWHSeq \> 0 THEN (SELECT WHName FROM \_TDAWH WHERE CompanySeq = @CompanySeq AND WHSeq = A.OutWHSeq) ELSE '' END ) AS OutWHName

,(CASE WHEN A.InWHSeq \> 0 THEN (SELECT WHName FROM \_TDAWH WHERE CompanySeq = @CompanySeq AND WHSeq = A.InWHSeq) ELSE '' END ) AS InWHName

FROM \#TPDMMOutReqPOItem AS A

WHERE Qty \<\> 0

RETURN