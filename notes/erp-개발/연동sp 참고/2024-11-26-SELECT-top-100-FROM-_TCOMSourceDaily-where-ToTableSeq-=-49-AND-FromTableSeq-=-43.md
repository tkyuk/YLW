---
title: SELECT top 100 \* FROM \_TCOMSourceDaily where ToTableSeq = 49 AND FromTableSeq = 43 AND FromSeq \>= 259 ORDER BY ToSerl,ToSeq Desc
date: 2024-11-26
tags: [erp, 개발, 연동sp 참고]
---

# SELECT top 100 \* FROM \_TCOMSourceDaily where ToTableSeq = 49 AND FromTableSeq = 43 AND FromSeq \>= 259 ORDER BY ToSerl,ToSeq Desc

- 신규, 삭제만 조회

- BLSeq 1건에 BLSerl \_/ 묶어서 전송

 

DROP PROC smc_SUIDelvInProc

GO

CREATE PROC smc_SUIDelvInProc

@WorkingTag         NCHAR(1)         -- 저장상태값                A:삽입 D:삭제

,@BLSeq         INT         -- 발주내부코드         필수 여러 BLSeq로 입고생성 안함.

,@BLSerl         NVARCHAR(MAX) -- 발주순번                 필수 \_/로 묶어서 전송 ex 한 건이 경우 1\_/, 여러 건인 경우 1\_/2\_/3…

,@DelvInDate         NCHAR(8)         -- 입고일자                 필수

,@UserSeq         INT -- 사용자ID                 필수

,@WHSeq         NVARCHAR(MAX) -- 창고코드                 필수 건 수 만큼 \_/로 묶어서 전송

,@Qty         NVARCHAR(MAX) -- 입고수량                 필수 건 수 만큼 \_/로 묶어서 전송

,@DelvSeq INT = 0 OUTPUT

,@Status NVARCHAR(100) OUTPUT

,@Results NVARCHAR(250) = '' OUTPUT

 

AS

 

SET NOCOUNT ON

 

DECLARE @CompanySeq INT = 1

,@LanguageSeq INT = 1

,@PgmSeq INT = 52920053 -- FrmWDAMESProc_smc MES시스템처리_smc

,@EmpSeq INT

,@DeptSeq INT

,@CurrDateTime DATETIME

 

SELECT @WorkingTag = LTRIM(RTRIM(ISNULL(@WorkingTag, ''))),

@DelvInDate = LTRIM(RTRIM(ISNULL(@DelvInDate , ''))),

@BLSeq = LTRIM(RTRIM(ISNULL(@BLSeq , 0))),

@UserSeq = LTRIM(RTRIM(ISNULL(@UserSeq , 0))),

@CurrDateTime = GETDATE()

 

 

SELECT @EmpSeq = ISNULL(B.EmpSeq,0),

@DeptSeq = A.DeptSeq

FROM \_TCAUser AS B WITH(NOLOCK)

JOIN \_fnAdmEmpOrd(@CompanySeq, '') AS A ON A.EmpSeq = B.EmpSeq

WHERE B.CompanySeq = @CompanySeq

AND B.UserSeq = @UserSeq

 

 

SELECT @EmpSeq = ISNULL(@EmpSeq ,0),

@DeptSeq = ISNULL(@DeptSeq ,0)

SELECT @DeptSeq = 9 , @EmpSeq = 18 --@@@@

 

 

> --------------------------------------------------------

-- 전량 진행이 아닌 경우, 기준단위수량/금액/부가세 등 재계산

--------------------------------------------------------

DECLARE @DomDec INT,

@DomAmtValue INT,

@DomVatValue INT,

@StdDomCurrSeq INT,

@AmtDecLength INT,

@DomDecLength INT,

@DomAmtType INT,

@DomVatType INT,

@GoodQtyDecLength INT,

@DomPriceDec INT,

@DomVatPoint INT,

@DomAmtPoint INT

-- EnvSeq = 13        (자국통화)

EXEC @StdDomCurrSeq = dbo.\_SWCOMEnvR @CompanySeq, 13, @UserSeq, @@PROCID

-- EnvSeq = 14        (거래금액소수점자리수)

EXEC @AmtDecLength = dbo.\_SWCOMEnvR @CompanySeq, 14, @UserSeq, @@PROCID

-- EnvSeq = 15        (자국통화금액소수점자리수)

EXEC @DomDecLength = dbo.\_SWCOMEnvR @CompanySeq, 15, @UserSeq, @@PROCID

-- EnvSeq = 8041 (\[영업기본\] 원화금액소수점처리(판매))

EXEC @DomAmtType = dbo.\_SWCOMEnvR @CompanySeq, 8041, @UserSeq, @@PROCID

-- EnvSeq = 8040 (\[영업기본\] 원화부가세소수점처리(판매))

EXEC @DomVatType = dbo.\_SWCOMEnvR @CompanySeq, 8040, @UserSeq, @@PROCID

-- EnvSeq = 8        (판매/제품 수량 소수점 자릿수)

EXEC @GoodQtyDecLength = dbo.\_SWCOMEnvR @CompanySeq, 8, @UserSeq, @@PROCID

-- EnvSeq = 9        (판매/제품 원화단가 소수점 자릿수)

EXEC @DomPriceDec = dbo.\_SWCOMEnvR @CompanySeq, 9, @UserSeq, @@PROCID

 

-- 원화부가세, 원화금액 소수점 처리 환경설정 가져오기(수입)

EXEC dbo.\_SWCOMEnv @CompanySeq,6509,@UserSeq,@@PROCID,@DomVatPoint OUTPUT

EXEC dbo.\_SWCOMEnv @CompanySeq,6510,@UserSeq,@@PROCID,@DomAmtPoint OUTPUT

--=======================================================================

-- 호출 Log 남기기

--=======================================================================

IF NOT EXISTS (SELECT \* FROM Sysobjects where Name = 'SMC_TMESImpDelvProclog' AND xtype = 'U' )

CREATE TABLE SMC_TMESImpDelvProclog

(

LogSeq INT IDENTITY(1,1) NOT NULL,

WorkingTag NVARCHAR(2) ,

DelvDate NCHAR(8) ,

UserSeq INT ,

BLSeq INT ,

BLSerl NVARCHAR(MAX),

WHSeq NVARCHAR(MAX),

Qty NVARCHAR(MAX),

DelvSeq INT,

Status NVARCHAR(10) NULL,

Results NVARCHAR(250) NULL,

LogDateTime DATETIME NOT NULL

)

INSERT SMC_TMESImpDelvProclog

(

WorkingTag ,

DelvDate,

UserSeq ,

BLSeq ,

BLSerl ,

WHSeq ,

Qty ,

DelvSeq ,

Status ,

Results ,

LogDateTime

)

SELECT @WorkingTag,

@DelvInDate,

@UserSeq,

@BLSeq,

@BLSerl,

@WHSeq,

@Qty,

@DelvSeq,

@Status,

@Results,

@CurrDateTime

--=======================================================================

-- 호출 Log 남기기

--=======================================================================

 

IF @WorkingTag NOT IN ('A', 'D')

BEGIN

SELECT @Status = 'ERR', @Results = '잘못된 작업코드 입니다.'

GOTO ERR_PROC

END

 

IF @BLSeq = 0

BEGIN

SELECT @Status = 'ERR', @Results = '수입BL 내부코드가 없습니다..'

GOTO ERR_PROC

END

 

-- 처리일자 체크

IF (IsDate(@DelvInDate) \<\> 1 )

BEGIN

SELECT @Status = 'ERR',

@Results = '입고일자가 잘못된 형식입니다.'

GOTO ERR_PROC

END

 

-- 처리자 체크

IF NOT EXISTS (SELECT 1 FROM \_TDAEmp WHERE CompanySeq = 1 AND EmpSeq = @EmpSeq)

BEGIN

SELECT @Status = '2',

@Results = '처리자가 잘못 되었습니다.'

GOTO ERR_PROC

END

 

 

 

CREATE TABLE \#Tmp_Delv(

IDX_NO INT IDENTITY(1,1)

,BLSeq INT

,BLSerl INT

,WHSeq INT

,Qty DECIMAL(19,5)

)

 

INSERT INTO \#Tmp_Delv(BLSeq,BLSerl,WHSeq,Qty)

SELECT @BLSeq, A.Code, B.Code, C.Code

FROM \_FCOMSplit(@BLSerl, '\_/') AS A

JOIN \_FCOMSplit(@WHSeq, '\_/') AS B ON A.IDX_No = B.IDX_No

JOIN \_FCOMSplit(@Qty , '\_/') AS C ON A.IDX_No = C.IDX_No

 

IF EXISTS (SELECT TOP 1 1

FROM \_TUIImpBL WITH(NOLOCK)

WHERE CompanySeq = @CompanySeq

AND BLSeq = @BLSeq

AND BLDate \> @DelvInDate

AND @WorkingTag = 'A'

)

BEGIN

SELECT @Status = 'ERR',

@Results = '입고일은 B/L Date보다 커야 합니다.'

GOTO ERR_PROC

END

 

-- 삭제 시 입고건 유효성 체크

IF NOT EXISTS(SELECT TOP 1 1 FROM \_TUIImpDelv WITH(NOLOCK) WHERE DelvSeq = @DelvSeq) AND @WorkingTag = 'D'

BEGIN

SELECT @Status = 'ERR',

@Results = '삭제 건이 존재하지 하지 않습니다.'

 

GOTO ERR_PROC

RETURN

END

 

 

DECLARE @MessageType INT,

@ErrorMsg NVARCHAR(4000),

@Results1 NVARCHAR(250),

@Results2 NVARCHAR(250),

@Results3 NVARCHAR(250),

@Count INT,

@Seq INT,

@DelvNo NVARCHAR(30),

 

@IDXSeq INT,

@Date NCHAR(8),

@AutoDelvIn NVARCHAR(100),

@DelvInSeq INT,

@DelvInNo NVARCHAR(50),

@BizUnit INT,

@Word NVARCHAR(30),

@Word2 NVARCHAR(30),

@ItemNo NVARCHAR(100),

@ItemNoTXT NVARCHAR(30)

-- 재고반영

CREATE TABLE \#TLGInOutMonth

(

InOutYM NCHAR(6),

WHSeq INT,

ItemSeq INT

)

CREATE TABLE \#TLGInOutMonthLot

(

InOutYM NCHAR(6),

WHSeq INT,

LotNo NVARCHAR(30),

ItemSeq INT

)

CREATE TABLE \#TLGInOutDailyBatch

(

WorkingTag NVARCHAR(10),

InOutType INT,

InOutSeq INT,

InOutSerl INT,

InOutSubSerl INT,

DataKind INT,

MessageType INT,

Result NVARCHAR(250),

Status INT

)

 

-- 구매입고

CREATE TABLE \#TUIImpDelv

(

IDXSeq INT IDENTITY(1,1)

, WorkingTag NVARCHAR(10)

, BLSeq INT

, CompanySeq INT

, DelvSeq INT

, BizUnit INT

, DelvDate NCHAR(8)

, CustSeq INT

, DelvNo NVARCHAR(20)

, InvoiceSeq INT

, PaymentSeq INT

, POSeq INT

, EmpSeq INT

, DeptSeq INT

, CurrSeq INT

, ExRate DECIMAL(19,5)

, Remark NVARCHAR(1000)

, LastUserSeq INT

, LastDateTime DATETIME

, SMImpKind INT

, IsPJT NCHAR(1)

, UMPriceTerms INT

, PgmSeq INT

, MessageType INT

, Result NVARCHAR(250)

, Status INT

, IsMES NCHAR(1)

)

 

-- 구매입고

CREATE TABLE \#TUIImpDelvItem

(

IDXSerl INT IDENTITY(1,1)

, WorkingTag NVARCHAR(10)

, IDX_NO BIGINT

, BLSeq INT

, BLSerl INT

, CompanySeq INT

, DelvSeq INT

, DelvSerl INT

, ItemSeq INT

, UnitSeq INT

, Qty DECIMAL(19,5)

, Price DECIMAL(19,5)

>  

, CurAmt DECIMAL(19,5)

>  

, DomAmt DECIMAL(19,5)

, WHSeq INT

, LotNo NVARCHAR(30)

, FromSerlNo NVARCHAR(100)

, ToSerlNo NVARCHAR(100)

, ProdDate NCHAR(8)

, STDUnitSeq INT

, STDQty DECIMAL(19,5)

, LastUserSeq INT

, LastDateTime DATETIME

, OKCurAmt DECIMAL(19,5)

, OKDomAmt DECIMAL(19,5)

, AccSeq INT

, VATAccSeq INT

, OppAccSeq INT

, SlipSeq INT

, IsCostCalc NCHAR(1)

, PJTSeq INT

, WBSSeq INT

, MakerSeq INT

, Remark NVARCHAR(1000)

>  
>
>  

, Dummy1 NVARCHAR(100)

, Dummy2 NVARCHAR(100)

, Dummy3 NVARCHAR(100)

, Dummy4 NVARCHAR(100)

, Dummy5 NVARCHAR(100)

, Dummy6 NVARCHAR(100)

, Dummy7 DECIMAL(19,5)

, Dummy8 DECIMAL(19,5)

, Dummy9 DECIMAL(19,5)

, Dummy10 DECIMAL(19,5)

, ValiDate NCHAR(8)

, PgmSeq INT

, IsReCalc NCHAR(1)

)

 

-- 진행

CREATE TABLE \#SComSourceDailyBatch

(

ToTableName NVARCHAR(100),

ToSeq INT,

ToSerl INT,

ToSubSerl INT,

FromTableName NVARCHAR(100),

FromSeq INT,

FromSerl INT,

FromSubSerl INT,

ToQty DECIMAL(19,5),

ToStdQty DECIMAL(19,5),

ToAmt DECIMAL(19,5),

ToVAT DECIMAL(19,5),

ToDOMAmt DECIMAL(19,5),

ToDOMVAT DECIMAL(19,5),

FromQty DECIMAL(19,5),

FromSTDQty DECIMAL(19,5),

FromAmt DECIMAL(19,5),

FromVAT DECIMAL(19,5),

FromDOMAmt DECIMAL(19,5),

FromDOMVAT DECIMAL(19,5)

)

 

--WBS 품질에 맞게 검사품 가져올 수 있도록 설정

CREATE TABLE \#QCItem

(

ItemSeq INT,

CustSeq INT,

IsQC NCHAR(1)

)

 

CREATE TABLE \#Temp_InOutReqItemProg(IDX_NO INT IDENTITY,

BLSeq INT,

BLSerl INT,

CompleteCHECK INT,

ReqQty DECIMAL(19,5),

InQty DECIMAL(19,5),

SMProgressType INT NULL,

Confirm INT,

ConfirmEmp NVARCHAR(100),

ConfirmDate NCHAR(8),

ConfirmReason NVARCHAR(500),

IsStop NCHAR(1),

StopEmp NVARCHAR(100),

StopDate NCHAR(8),

StopReason NVARCHAR(500))

 

-- 진행체크할 테이블값 테이블

CREATE TABLE \#TMP_PROGRESSTABLE

(

IDOrder INT,

TABLENAME NVARCHAR(100)

)

-- 진행된 내역 테이블 : \_SCOMProgressTracking 에서 사용

CREATE TABLE \#TCOMProgressTracking

(

IDX_NO INT,

IDInOut INT,

Seq INT,

Serl INT,

SubSerl INT,

Qty DECIMAL(19,5),

StdQty DECIMAL(19,5),

Amt DECIMAL(19,5),

VAT DECIMAL(19,5),

DOMAmt DECIMAL(19,5),

DOMVAT DECIMAL(19,5)

)

-- 삭제 대상 테이블

CREATE TABLE \#ImpDelvDEL

(

IDX_NO INT,

WorkingTag NCHAR(1),

BLSeq INT,

BLSerl INT,

DelvSeq INT,

DelvSerl INT,

Kind INT,

Status INT

)

 

-- 생성 대상 테이블

CREATE TABLE \#ImpDelvINS

(

IDX_NO INT,

WorkingTag NCHAR(1),

BLSeq INT,

BLSerl INT,

DelvSeq INT,

DelvSerl INT,

Kind INT

)

CREATE TABLE \#ImpDelvProg

(

IDX_NO INT,

BLSeq INT,

BLSerl INT,

DelvSeq INT,

DelvSerl INT,

DelvNo NVARCHAR(20),

DelvDate NCHAR(8),

DelvQty DECIMAL(19,5),

DelvSTDQty DECIMAL(19,5),

IsSlip INT

)

EXEC dbo.\_SWCOMGetDictionary @LanguageSeq, 21303 , @Word OUTPUT -- 수입입고

IF @Word IS NULL SELECT @Word = N'수입입고'

EXEC dbo.\_SWCOMGetDictionary @LanguageSeq, 2642 , @Word2 OUTPUT -- 자동입고

IF @Word2 IS NULL SELECT @Word2 = N'자동입고'

EXEC dbo.\_SWCOMGetDictionary @LanguageSeq, 2091 , @ItemNoTXT OUTPUT --품번

IF @ItemNoTXT IS NULL SELECT @ItemNoTXT = N'품번'

--#========================================================================================

-- ① 처리대상 담기

--=========================================================================================

CREATE TABLE \#TMESPUDelvInterface

(

IDX_NO INT,

CompanySeq INT,

WorkingTag NCHAR(1),

BLSeq INT,

BLSerl INT,

DelvSeq INT,

DelvSerl INT,

ERPDateTime DATETIME,

ERPStatus NCHAR(1),

ERPERRMSG NVARCHAR(250),

 

RegBizUnit INT,

BizUnit INT,

EmpSeq INT,

DeptSeq INT,

CustSeq INT,

InWHSeq INT,

OutWHSeq INT,

ProcDate NCHAR(8),

Remark NVARCHAR(1000),

ItemSeq INT,

UnitSeq INT,

Qty DECIMAL(19,5),

ItemRemark NVARCHAR(1000),

LotNo NVARCHAR(200),

WorkCenterSeq INT,

GoodItemSeq INT,

ProcRev NCHAR(2),

ProcSeq INT,

ProdQty DECIMAL(19,5),

BadQty DECIMAL(19,5),

WorkStartTime NCHAR(4),

WorkEndTime NCHAR(4),

WorkHour DECIMAL(19,5),

ProcHour DECIMAL(19,5),

WorkerQty DECIMAL(19,5),

IsReturn NCHAR(1),

InOutDetailKind INT,

Dummy1 NVARCHAR(100),

Dummy2 NVARCHAR(100),

Dummy3 NVARCHAR(100),

Dummy4 NVARCHAR(100),

Dummy5 NVARCHAR(100),

Dummy6 NVARCHAR(100),

Dummy7 DECIMAL(19,5),

Dummy8 DECIMAL(19,5),

Dummy9 DECIMAL(19,5),

Dummy10 DECIMAL(19,5),

MessageType INT,

Status INT,

Result NVARCHAR(250),

InOutERR NCHAR(1),

CurrSeq INT,

ExRate DECIMAL(19,5),

CurAmt DECIMAL(19,5),

CurVAT DECIMAL(19,5),

DomAmt DECIMAL(19,5),

DomVAT DECIMAL(19,5),

Price DECIMAL(19,5),

LastUserSeq INT

)

--#========================================================================================

-- ② 데이터 가공

--=========================================================================================

INSERT INTO \#TMESPUDelvInterface

(

CompanySeq , WorkingTag , IDX_NO , BLSeq , BLSerl ,

DelvSeq ,

DelvSerl ,

ERPDateTime , ERPStatus ,

ERPERRMSG , BizUnit , EmpSeq , DeptSeq , CustSeq ,

InWHSeq , OutWHSeq , ProcDate , Remark , ItemSeq ,

UnitSeq , Qty , ItemRemark , LotNo , WorkCenterSeq ,

GoodItemSeq , ProcRev , ProcSeq , ProdQty , BadQty ,

WorkStartTime , WorkEndTime , WorkHour , ProcHour , WorkerQty ,

IsReturn , InOutDetailKind, Dummy1 , Dummy2 , Dummy3 ,

Dummy4 , Dummy5 , Dummy6 , Dummy7 , Dummy8 ,

Dummy9 , Dummy10 , Status , Result , InOutERR ,

CurrSeq , ExRate , CurAmt , CurVAT , DomAmt ,

DomVAT , Price , LastUserSeq

)

SELECT @CompanySeq , @WorkingTag , A.IDX_NO , A.BLSeq , A.BLSerl ,

CASE WHEN @WorkingTag = 'D' THEN @DelvSeq ELSE 0 END ,

CASE WHEN @WorkingTag = 'D' THEN E.DelvSerl ELSE 0 END ,

'' , '0' ,

'' , 1 AS BizUnit , @EmpSeq , @DeptSeq , C.CustSeq ,

A.WHSeq , 0 , @DelvInDate , '\[MES 자동생성\]' , D.ItemSeq ,

D.UnitSeq , A.Qty , D.Remark , D.LotNo , 0 ,

0 , '' , 0 , 0 , 0 ,

0 , '' , 0 , 0 , 0 ,

'' , 0 , D.Dummy1 , D.Dummy2 , D.Dummy3 ,

D.Dummy4 , D.Dummy5 , D.Dummy6 , D.Dummy7 , D.Dummy8 ,

D.Dummy9 , D.Dummy10 , 0 , '' , '0' ,

C.CurrSeq , C.ExRate , D.CurAmt , 0 AS CurVAT , D.DomAmt ,

0 AS DomVAT , D.Price , @UserSeq

FROM \#Tmp_Delv AS A

JOIN \_TUIImpBL AS C WITH(NOLOCK) ON C.CompanySeq = @CompanySeq

AND C.BLSeq = A.BLSeq

JOIN \_TUIImpBLItem AS D WITH(NOLOCK) ON D.CompanySeq = @CompanySeq

AND D.BLSeq = A.BLSeq

AND D.BLSerl = A.BLSerl

LEFT OUTER JOIN \_TUIImpDelvItem AS E WITH(NOLOCK) ON E.CompanySeq = @CompanySeq

AND E.ProgFromSeq = A.BLSeq

AND E.ProgFromSerl = A.BLSerl

AND E.ProgFromTableSeq = 43

 

IF NOT EXISTS(SELECT TOP 1 1 FROM \#TMESPUDelvInterface)

BEGIN

SELECT @Status = 'ERR', @Results = '처리할 건이 없습니다.'

GOTO ERR_PROC

 

RETURN

END

 

INSERT INTO \#ImpDelvDEL (IDX_NO, WorkingTag, BLSeq, BLSerl, DelvSeq, DelvSerl, Kind)

SELECT A.IDX_NO, A.WorkingTag, A.BLSeq, A.BLSerl, A.DelvSeq, A.DelvSerl, CASE WHEN A.WorkingTag = N'D' THEN 1 ELSE 0 END

FROM \#TMESPUDelvInterface AS A

JOIN \_TUIImpDelvItem AS B WITH(NOLOCK) ON A.DelvSeq = B.DelvSeq

AND A.DelvSerl = B.DelvSerl

AND B.CompanySeq = @CompanySeq

WHERE A.WorkingTag = 'D'

AND A.DelvSeq \> 0

INSERT INTO \#ImpDelvINS (IDX_NO, WorkingTag, BLSeq, BLSerl, DelvSeq, DelvSerl, Kind)

SELECT A.IDX_NO, A.WorkingTag, A.BLSeq, A.BLSerl, A.DelvSeq, A.DelvSerl, 0

FROM \#TMESPUDelvInterface AS A

WHERE A.WorkingTag = N'A'

IF NOT EXISTS(SELECT TOP 1 1 FROM \#ImpDelvINS) AND @WorkingTag = 'A'

BEGIN

SELECT @Status = 'ERR', @Results = '처리할 건이 없습니다.'

GOTO ERR_PROC

 

RETURN

END

IF NOT EXISTS(SELECT TOP 1 1 FROM \#ImpDelvDEL) AND @WorkingTag = 'D'

BEGIN

SELECT @Status = 'ERR', @Results = '처리할 건이 없습니다.'

GOTO ERR_PROC

 

RETURN

END

-------------------------------------------------------

-- 입고진행된 건 찾기

-------------------------------------------------------

BEGIN

TRUNCATE TABLE \#TMP_PROGRESSTABLE

TRUNCATE TABLE \#TCOMProgressTracking

 

INSERT INTO \#TMP_PROGRESSTABLE

SELECT 1, N'\_TUIImpDelvInItem' -- 구매입고

 

EXEC dbo.\_SWCOMProgressTracking

@CompanySeq = @CompanySeq

, @TableName = N'\_TUIImpDelvItem'

, @TempTableName = N'#ImpDelvDEL'

, @TempSeqColumnName = N'DelvSeq'

, @TempSerlColumnName = N'DelvSerl'

, @TempSubSerlColumnName = N''

 

 

INSERT INTO \#ImpDelvProg

SELECT DISTINCT

A.IDX_NO

, A.DelvSeq

, A.DelvSerl

, C.DelvSeq

, C.DelvSerl

, N.DelvNo

, N.DelvDate

, C.Qty

, C.STDQty

, (CASE WHEN C.SlipSeq \> 0 THEN 1 ELSE 0 END)

FROM \#ImpDelvDEL AS A

JOIN \#TCOMProgressTracking AS B ON A.IDX_NO = B.IDX_NO

JOIN \_TUIImpDelvItem AS C WITH(NOLOCK) ON B.Seq = C.DelvSeq

AND B.Serl = C.DelvSerl

AND C.CompanySeq = @CompanySeq

JOIN \_TUIImpDelv AS N WITH(NOLOCK) ON C.DelvSeq = N.DelvSeq

AND N.CompanySeq = @CompanySeq

WHERE C.CompanySeq = @CompanySeq

 

-------------------------

-- 입고데이터 UPDATE

-------------------------

UPDATE A

SET DelvSeq = B.DelvSeq

, DelvSerl = B.DelvSerl

FROM \#ImpDelvDEL AS A

JOIN \#ImpDelvProg AS B ON A.IDX_NO = B.IDX_NO

END

 

--#========================================================================================

-- ③ Check

-- 수불마감체크

-- 품목마스터 유효성 체크

-- 중단, 미확정여부 체크

-- 발주수량보다 입고수량이 많을 경우 체크

-- 전표처리여부 체크

-- 검사진행여부 체크

-- 반품으로 진행된 건일 경우 체크

-- Lot관리여부 체크

--=========================================================================================

--------------------------------------------------------------------------------------------------------------------------

-- 0. 수불마감체크 20200812 박수영

--------------------------------------------------------------------------------------------------------------------------

CREATE TABLE \#TLGClosingCheck

(

IDX_NO INT ,

InOutYM NCHAR(6) ,

ItemSeq INT ,

WHSeq INT ,

MessageType INT ,

Status INT ,

Result NVARCHAR(255)

)

 

INSERT INTO \#TLGClosingCheck

SELECT A.IDX_NO, LEFT(A.ProcDate,6), A.ItemSeq, A.InWHSeq, 0, 0, ''

FROM \#TMESPUDelvInterface AS A

JOIN \#ImpDelvDEL AS B WITH(NOLOCK) ON A.IDX_NO = B.IDX_NO

WHERE A.Status = 0

AND A.Qty \<\> 0

UNION

SELECT A.IDX_NO, LEFT(A.ProcDate,6), A.ItemSeq, A.InWHSeq, 0, 0, ''

FROM \#TMESPUDelvInterface AS A

JOIN \#ImpDelvINS AS B WITH(NOLOCK) ON A.IDX_NO = B.IDX_NO

WHERE A.Status = 0

AND A.Qty \<\> 0

 

EXEC \_SWLGClosingCheck @CompanySeq, @LanguageSeq

 

 

UPDATE A

SET Result = B.Result,

Status = 2 --2020.08.12 박수영 수불연동에서는 2로 처리

FROM \#TMESPUDelvInterface AS A

JOIN \#TLGClosingCheck AS B WITH(NOLOCK) ON A.IDX_NO = B.IDX_NO

WHERE A.Status = 0

AND A.Qty \<\> 0

AND B.Status \<\> 0

 

-------------------------------------------------

-- 1. 품목마스터 유효성 체크

-------------------------------------------------

EXEC dbo.\_SWCOMMessage @MessageType OUTPUT,

@Status OUTPUT,

@Results OUTPUT,

1302 , -- @1이(가) 등록되지 않았습니다.....(SELECT \* FROM \_TCAMessageLanguage WHERE MessageSeq = 1152)

@LanguageSeq ,

7,N'품목' -- SELECT \* FROM \_TCADictionary WHERE Word like '품목'

UPDATE \#TMESPUDelvInterface

SET Result = @Results,

Status = 2

FROM \#TMESPUDelvInterface AS A

LEFT OUTER JOIN \_TDAItem AS B WITH(NOLOCK) ON A.CompanySeq = B.CompanySeq

AND A.ItemSeq = B.ItemSeq

JOIN \#ImpDelvINS AS I ON A.IDX_NO = I.IDX_NO

WHERE A.Status = 0

AND ISNULL(B.ItemSeq,0) = 0

 

---------------------------------------

-- 2. 중단, 미확정 오류 체크

---------------------------------------

INSERT INTO \#Temp_InOutReqItemProg(BLSeq, BLSerl, ReqQty, InQty, CompleteCHECK)

SELECT A.BLSeq, A.BLSerl, B.Qty, SUM(A.Qty), -1

FROM \#TMESPUDelvInterface AS A

JOIN \_TUIImpBLItem AS B WITH(NOLOCK) ON A.BLSeq = B.BLSeq

AND A.BLSerl = B.BLSerl

JOIN \#ImpDelvINS AS I ON A.IDX_NO = I.IDX_NO

WHERE B.CompanySeq = @CompanySeq

GROUP BY A.BLSeq, A.BLSerl, B.Qty

ORDER BY A.BLSeq, A.BLSerl

EXEC \_SWCOMConfirmStopUpdate @CompanySeq, '#Temp_InOutReqItemProg', 'BLSeq','BLSerl','',501077

 

--진행상태

EXEC \_SWCOMProgStatus @CompanySeq, '\_TUIImpBLItem', 1036002, '#Temp_InOutReqItemProg', 'BLSeq', 'BLSerl', '', '', '', '', '', '', 'CompleteCHECK',

1, 'Qty', 'STDQty', '', '', 'BLSeq', 'BLSerl', '', '\_TUIImpBL', 501077

BEGIN

EXEC dbo.\_SWCOMMessage @MessageType OUTPUT,

@Status OUTPUT,

@Results1 OUTPUT,

1152 , -- @1된 건이 선택되었습니다.....(SELECT \* FROM \_TCAMessageLanguage WHERE MessageSeq = 1152)

@LanguageSeq ,

1326,'' -- SELECT \* FROM \_TCADictionary WHERE Word like '%중단%'

 

EXEC dbo.\_SWCOMMessage @MessageType OUTPUT,

@Status OUTPUT,

@Results2 OUTPUT,

1152 , -- @1된 건이 선택되었습니다.....(SELECT \* FROM \_TCAMessageLanguage WHERE Message like '%선택%')

@LanguageSeq ,

11177,'' -- SELECT \* FROM \_TCADictionary WHERE Word like '%미확정%'

EXEC dbo.\_SWCOMMessage @MessageType OUTPUT,

@Status OUTPUT,

@Results3 OUTPUT,

1152 , -- @1된 건이 선택되었습니다.....(SELECT \* FROM \_TCAMessageLanguage WHERE Message like '%선택%')

@LanguageSeq ,

25474,'' -- SELECT \* FROM \_TCADictionary WHERE Word like '%입고완료%'

UPDATE \#TMESPUDelvInterface

SET Result = CASE WHEN ISNULL(B.IsStop, '') = '1' THEN @Results1

WHEN ISNULL(B.Confirm, '') = '0' THEN @Results2

WHEN ISNULL(B.CompleteCHECK, '') = 40 AND I.WorkingTag = N'A' THEN @Results3 ELSE '' END,

Status = 2

FROM \#TMESPUDelvInterface AS A

JOIN \#Temp_InOutReqItemProg AS B ON A.BLSeq = B.BLSeq

AND A.BLSerl = B.BLSerl

JOIN \#ImpDelvINS AS I ON A.IDX_NO = I.IDX_NO

WHERE (ISNULL(B.IsStop, '') = '1'

OR ISNULL(B.Confirm, '1') = '0')

AND A.Status = 0

 

UPDATE \#TMESPUDelvInterface

SET Result = @Results3,

Status = 2

FROM \#TMESPUDelvInterface AS A

JOIN \#Temp_InOutReqItemProg AS B ON A.BLSeq = B.BLSeq

AND A.BLSerl = B.BLSerl

JOIN \#ImpDelvINS AS I ON A.IDX_NO = I.IDX_NO

WHERE (ISNULL(B.CompleteCHECK, '') = 40 AND I.WorkingTag = N'A')

AND A.Status = 0

 

END

-------------------------------------------------

-- 4. 수입BL수량보다 입고수량이 많을 경우 체크

-------------------------------------------------

TRUNCATE TABLE \#TMP_PROGRESSTABLE

TRUNCATE TABLE \#TCOMProgressTracking

 

DECLARE @SMProgCheckKind INT,

@IsOverFlow NCHAR(1)

 

SELECT @IsOverFlow = '0'

 

SELECT @IsOverFlow = ISNULL(IsOverFlow,'0'),

@SMProgCheckKind = SMProgCheckKind

FROM \_TCOMProgRelativeTables WITH(NOLOCK)

WHERE CompanySeq = @CompanySeq

AND FromTableSeq = 13

AND ToTableSeq = 10

 

INSERT \#TMP_PROGRESSTABLE

SELECT 1, '\_TUIImpDelvItem' -- 구매입고

CREATE TABLE \#Temp_SourceItem (

IDX_NO INT IDENTITY ,

BLSeq INT ,

BLSerl INT ,

POQty DECIMAL(19, 5),

 

POSTDQty DECIMAL(19, 5),

POAmt DECIMAL(19, 5),

ProgQty DECIMAL(19, 5),

ProgSTDQty DECIMAL(19, 5),

ProgAmt DECIMAL(19, 5),

)

INSERT INTO \#Temp_SourceItem(BLSeq, BLSerl,POQty, POSTDQty, POAmt, ProgQty, ProgSTDQty, ProgAmt)

SELECT A.BLSeq, A.BLSerl, B.Qty, B.STDQty, B.CurAmt, A.Qty, B.STDQty, A.CurAmt -- 연동테이블에 기준단위수량 없음

FROM \#TMESPUDelvInterface AS A

JOIN \_TUIImpBLItem AS B WITH(NOLOCK) ON B.CompanySeq = @CompanySeq

AND B.BLSeq = A.BLSeq

AND B.BLSerl = A.BLSerl

 

EXEC \_SWCOMProgressTracking @CompanySeq, '\_TUIImpBLItem', '#Temp_SourceItem', 'BLSeq', 'BLSerl', ''

 

 

CREATE TABLE \#Temp_Prog (

IDX_NO INT ,

DelvQty DECIMAL(19, 5),

DelvSTDQty DECIMAL(19, 5),

DelvAmt DECIMAL(19, 5))

 

 

INSERT INTO \#Temp_Prog(IDX_NO, DelvQty, DelvSTDQty, DelvAmt)

SELECT A.IDX_NO, SUM(CASE IDInOut WHEN 1 THEN A.Qty ELSE 0 END),

SUM(CASE IDInOut WHEN 1 THEN A.STDQty ELSE 0 END),

SUM(CASE IDInOut WHEN 1 THEN A.Amt ELSE 0 END)

FROM \#TCOMProgressTracking AS A

GROUP BY A.IDX_NO

SELECT A.BLSeq ,

A.BLSerl ,

A.POQty ,

A.POSTDQty,

A.POAmt ,

A.ProgQty ,

A.ProgSTDQty ,

A.ProgAmt ,

ISNULL(B.DelvQty , 0) AS DelvQty ,

ISNULL(B.DelvSTDQty, 0) AS DelvSTDQty,

ISNULL(B.DelvAmt , 0) AS DelvAmt ,

CASE WHEN B.IDX_NO IS NULL THEN '0'

ELSE '1' END AS IsExists

INTO \#TempProgCheck

FROM \#Temp_SourceItem AS A

LEFT OUTER JOIN \#Temp_Prog AS B ON A.IDX_NO = B.IDX_NO

EXEC dbo.\_SWCOMMessage @MessageType OUTPUT,

@Status OUTPUT,

@Results OUTPUT,

1192 , -- 해당 @1 @2이(가) 초과되었습니다. (SELECT \* FROM \_TCAMessageLanguage WITH(NOLOCK) WHERE LanguageSeq = 1 AND MessageSeq = 1192)

@LanguageSeq ,

2529, '건' , -- SELECT \* FROM \_TCADictionary WITH(NOLOCK) WHERE LanguageSeq = 1 AND Word = '건'

9110, '진행정보' -- SELECT \* FROM \_TCADictionary WITH(NOLOCK) WHERE LanguageSeq = 1 AND Word = '진행정보'

UPDATE A

SET A.Result = @Results ,

A.MessageType = @MessageType,

A.Status = 2

FROM \#TMESPUDelvInterface AS A

JOIN \#ImpDelvINS AS I ON A.IDX_NO = I.IDX_NO

JOIN \#TempProgCheck AS C ON C.BLSeq = A.BLSeq

AND C.BLSerl = A.BLSerl

WHERE A.Status = 0

AND ((@SMProgCheckKind = 1045001 AND @IsOverFlow \<\> '1' AND C.POQty \< C.ProgQty + C.DelvQty ) OR -- 수량

(@SMProgCheckKind = 1045002 AND @IsOverFlow \<\> '1' AND C.POSTDQty \< C.ProgSTDQty + C.DelvSTDQty) OR -- 기준단위수량

(@SMProgCheckKind = 1045003 AND @IsOverFlow \<\> '1' AND C.POAmt \< C.ProgAmt + C.DelvAmt ) OR -- 금액

(@SMProgCheckKind = 1045004 AND C.IsExists = '1')) -- 존재

-- 진행체크 END

 

 

-------------------------------------------------

-- 5. 조정처리 테이블 체크

-------------------------------------------------

BEGIN

EXEC dbo.\_SWCOMMessage @MessageType OUTPUT,

@Status OUTPUT,

@Results OUTPUT,

8 , -- 진행된 건이 있어 수정/삭제 할 수 없습니다.

@LanguageSeq

--17472,N'조정처리', -- SELECT \* FROM \_TCADICTIONARY WHERE WORD LIKE '건'

--2529,'건'

UPDATE \#TMESPUDelvInterface

SET Result = @Results,

Status = 2

FROM \#TMESPUDelvInterface AS A

JOIN \#ImpDelvDEL AS D ON A.IDX_NO = D.IDX_NO

JOIN \_TUIImpCostDiffSlipItem AS B WITH(NOLOCK) ON A.CompanySeq = B.CompanySeq

AND D.DelvSeq = B.DelvSeq

AND D.DelvSerl = B.DelvSerl

WHERE A.Status = 0

AND A.WorkingTag = 'D'

END

 

-------------------------------------------------

-- 6. 비용데이터 체크

-------------------------------------------------

BEGIN

EXEC dbo.\_SWCOMMessage @MessageType OUTPUT,

@Status OUTPUT,

@Results OUTPUT,

102 , -- @1 데이터가 존재합니다.(SELECT \* FROM \_TCAMessageLanguage WHERE MessageSeq = 102)

@LanguageSeq ,

6073,N'비용처리' -- SELECT \* FROM \_TCADictionary WHERE Word like '%비용처리%'

UPDATE \#TMESPUDelvInterface

SET Result = @Results,

Status = 2

FROM \#TMESPUDelvInterface AS A

JOIN \#ImpDelvDEL AS D ON A.IDX_NO = D.IDX_NO

JOIN \_TSLExpExpense AS B WITH(NOLOCK) ON B.CompanySeq = @CompanySeq

AND B.SMSourceType = 8215006

AND D.DelvSeq = B.SourceSeq

JOIN \_TSLExpExpenseDesc AS C WITH(NOLOCK) ON C.CompanySeq = @CompanySeq

AND B.ExpenseSeq = C.ExpenseSeq

WHERE A.Status = 0

END

 

-------------------------------------------------

-- 7. 진행여부 체크

-------------------------------------------------

--BEGIN

 

-- EXEC dbo.\_SWCOMProgressCheck @CompanySeq, '\_TUIImpDelvItem', 2, '#ImpDelvDEL', 'DelvSeq', 'DelvSerl', '', 'Status'

 

-- EXEC dbo.\_SWCOMMessage @MessageType OUTPUT,

-- @Status OUTPUT,

-- @Results OUTPUT,

-- 1044 , -- 다음작업이진행되어서변경,삭제할수없습니다..(SELECT \* FROM \_TCAMessageLanguage WHERE MessageSeq = 1044)

-- @LanguageSeq ,

-- 0,N'' -- SELECT \* FROM \_TCADictionary WHERE Word like '%%'

-- UPDATE \#TMESPUDelvInterface

-- SET Result = @Results,

-- Status = 2

-- FROM \#TMESPUDelvInterface AS A

-- JOIN \#ImpDelvDEL AS D ON A.IDX_NO = D.IDX_NO

--END

-------------------------------------------------

-- 수입원가계산 체크

-------------------------------------------------

BEGIN

EXEC dbo.\_SWCOMMessage @MessageType OUTPUT,

@Status OUTPUT,

@Results OUTPUT,

5 , -- 이미 @1가(이) 완료된 @2입니다. (SELECT \* FROM \_TCAMessageLanguage WHERE MessageSeq = 5)

@LanguageSeq ,

15327,N'수입원가계산',-- SELECT \* FROM \_TCADictionary WHERE Word like '%수입원가계산%'

16624,N'입고'

UPDATE \#TMESPUDelvInterface

SET Result = @Results,

Status = 2

FROM \#TMESPUDelvInterface AS A

JOIN \#ImpDelvDEL AS D ON A.IDX_NO = D.IDX_NO

JOIN \_TUIImpDelvCostDiv AS B WITH(NOLOCK) ON B.CompanySeq = @CompanySeq

AND A.DelvSeq = B.DelvSeq

>  

WHERE A.Status = 0

END

 

-------------------------------------------------

-- Lot관리여부 체크

-------------------------------------------------

EXEC dbo.\_SWCOMMessage @MessageType OUTPUT,

@Status OUTPUT,

@Results OUTPUT,

1171 , -- 해당품목은 Lot번호 관리 품목입니다. Lot번호를 필수로 입력하십시오.....(SELECT \* FROM \_TCAMessageLanguage WHERE MessageSeq = 1171)

@LanguageSeq ,

0,N'' -- SELECT \* FROM \_TCADictionary WHERE Word like '품목'

UPDATE \#TMESPUDelvInterface

SET Result = @Results,

Status = 2,

InOutERR = N'1' -- 수불에러

FROM \#TMESPUDelvInterface AS A

JOIN \_TDAItemStock AS B WITH(NOLOCK) ON A.CompanySeq = B.CompanySeq

AND A.ItemSeq = B.ItemSeq

JOIN \#ImpDelvINS AS I ON A.IDX_NO = I.IDX_NO

WHERE A.Status = 0

AND B.IsLotMng ='1'

AND ISNULL(A.LotNo,'') = ''

 

 

--------------------------------------------------------------------------------

-- Lot관리 체크에 의해 수불오류 발생 시 전체 오류 처리

--------------------------------------------------------------------------------

IF EXISTS ( SELECT 1 FROM \#TMESPUDelvInterface WHERE Status = 2 AND InOutERR = N'1' )

BEGIN

SELECT TOP 1

@ItemNo = B.ItemNo

FROM \#TMESPUDelvInterface AS A

JOIN \_TDAItem AS B WITH(NOLOCK) ON A.CompanySeq = B.CompanySeq

AND A.ItemSeq = B.ItemSeq

WHERE A.Status = 2

AND A.InOutERR = N'1'

EXEC dbo.\_SWCOMMessage @MessageType OUTPUT,

@Status OUTPUT,

@Results OUTPUT,

1053 , -- @1 처리 작업중 오류가 발생하였습니다. (SELECT \* FROM \_TCAMessageLanguage WHERE Message like '%오류%')

@LanguageSeq ,

2637,'수불' -- SELECT \* FROM \_TCADictionary WHERE Word like '%수불%'

UPDATE \#TMESPUDelvInterface

SET Status = 2,

Result = @Results + N' \[' + @ItemNoTXT + N' : ' + @ItemNo + N'\]'

FROM \#TMESPUDelvInterface

WHERE Status = 0

 

END

 

-- 오류 건 존재 시 종료

IF EXISTS(SELECT TOP 1 1 FROM \#TMESPUDelvInterface WHERE Status \<\> 0)

BEGIN

SELECT TOP 1 @Status = 'ERR', @Results = Result

FROM \#TMESPUDelvInterface

WHERE Status \<\> 0

 

GOTO ERR_PROC

RETURN

END

 

 

-------------------------------------------------------------------------------

-- 업무체크 오류가 발생되지 않은 건에 대해서만 처리

-------------------------------------------------------------------------------

IF EXISTS ( SELECT 1 FROM \#ImpDelvINS WHERE WorkingTag IN (N'A', N'U') )

BEGIN

INSERT INTO \#TUIImpDelv

(

WorkingTag

, BLSeq

, CompanySeq

, DelvSeq

, BizUnit

, DelvDate

, CustSeq

, DelvNo

, InvoiceSeq

, PaymentSeq

, POSeq

, EmpSeq

, DeptSeq

, CurrSeq

, ExRate

, Remark

, SMImpKind

, IsPJT

, UMPriceTerms

, PgmSeq

, Status

, LastUserSeq

)

SELECT DISTINCT

N'A' AS WorkingTag,

A.BLSeq AS BLSeq,

A.CompanySeq AS CompanySeq,

0,

A.BizUnit AS BizUnit,

A.ProcDate AS DelvDate,

A.CustSeq AS CustSeq,

'',

0,

0,

0,

A.EmpSeq AS EmpSeq,

A.DeptSeq AS DeptSeq,

CASE WHEN A.CurrSeq \> 0 THEN A.CurrSeq ELSE D.CurrSeq END AS CurrSeq,

CASE WHEN A.ExRate \> 0 THEN A.ExRate ELSE D.ExRate END AS ExRate,

>  

A.Remark AS Remark,

D.SMImpKind AS SMImpKind,

ISNULL(D.IsPJT,N'0') AS IsPJT,

D.UMPriceTerms AS UMPriceTerms,

@PgmSeq AS PgmSeq,

A.Status AS Status,

A.LastUserSeq AS LastUserSeq

FROM \#TMESPUDelvInterface AS A

JOIN \_TUIImpBL AS D WITH(NOLOCK) ON A.BLSeq = D.BLSeq

AND A.CompanySeq = D.CompanySeq

JOIN \#ImpDelvINS AS X ON A.IDX_NO = X.IDX_NO

WHERE A.Status = 0

 

IF EXISTS ( SELECT 1 FROM \#TUIImpDelv )

BEGIN

--------------------------------------------------

-- 수입입고 Key값 생성

--------------------------------------------------

IF EXISTS ( SELECT 1 FROM \#TUIImpDelv WHERE ISNULL(DelvSeq,0) = 0 )

BEGIN

SELECT @IDXSeq = 0

 

WHILE ( 1 = 1 )

BEGIN

SELECT TOP 1 @IDXSeq = IDXSeq, @DelvInDate = DelvDate

FROM \#TUIImpDelv

WHERE IDXSeq \> @IDXSeq

ORDER BY IDXSeq

IF @@ROWCOUNT = 0 BREAK

-- DelvNo 생성

EXEC \_SWCOMCreateNo 'SL', '\_TUIImpDelv', @CompanySeq, '', @DelvInDate, @DelvNo OUTPUT

-- DelvSeq 생성

EXEC @DelvSeq = \_SWCOMCreateSeq @CompanySeq, '\_TUIImpDelv', 'DelvSeq', 1

IF EXISTS (SELECT 1 FROM \_TUIImpDelv WITH(NOLOCK) WHERE CompanySeq = @CompanySeq AND DelvSeq \>= @DelvSeq)

BEGIN

SELECT @DelvSeq = (SELECT MAX(DelvSeq) + 1 FROM \_TUIImpDelv WITH(NOLOCK) WHERE CompanySeq = @CompanySeq)

UPDATE \_TCOMCreateSeqMax

SET MaxSeq = @DelvSeq + 1

WHERE CompanySeq = @CompanySeq AND TableName = '\_TUIImpDelv'

END

UPDATE \#TUIImpDelv

SET DelvSeq = @DelvSeq,

DelvNo = @DelvNo

WHERE IDXSeq = @IDXSeq

END

INSERT INTO \#TUIImpDelvItem

(

WorkingTag

, IDX_NO

, BLSeq

, BLSerl

, CompanySeq

, DelvSeq

, DelvSerl

, ItemSeq

, UnitSeq

, Qty

, Price

, CurAmt

, DomAmt

, WHSeq

, LotNo

, STDUnitSeq

, STDQty

, OKCurAmt

, OKDomAmt

, AccSeq

, VATAccSeq

, OppAccSeq

, SlipSeq

, PJTSeq

, WBSSeq

, MakerSeq

, Remark

, PgmSeq

, Dummy1

, Dummy2

, Dummy3

, Dummy4

, Dummy5

, Dummy6

, Dummy7

, Dummy8

, Dummy9

, Dummy10

, ValiDate

, LastUserSeq

, IsReCalc

)

SELECT A.WorkingTag,

A.IDX_NO,

A.BLSeq,

A.BLSerl,

A.CompanySeq,

Delv.DelvSeq,

ROW_NUMBER() OVER(PARTITION BY Delv.DelvSeq ORDER BY Delv.DelvSeq, A.BLSeq, A.BLSerl),

A.ItemSeq,

A.UnitSeq,

A.Qty,

POItem.Price,

CASE WHEN A.CurAmt \<\> 0 THEN A.CurAmt ELSE POItem.CurAmt END,

CASE WHEN A.DomAmt \<\> 0 THEN A.DomAmt ELSE POItem.DomAmt END,

A.InWHSeq,

A.LotNo,

ISNULL(POItem.STDUnitSeq, A.UnitSeq),

CASE WHEN ISNULL(C.ConvDen,0) = 0 THEN 0 ELSE A.Qty \* (C.ConvNum/C.ConvDen) END,

0,

0,

0,

0,

0,

0,

POItem.PJTSeq,

POItem.WBSSeq,

POItem.MakerSeq,

A.ItemRemark,

@PgmSeq,

A.Dummy1,

A.Dummy2,

A.Dummy3,

A.Dummy4,

A.Dummy5,

A.Dummy6,

A.Dummy7,

A.Dummy8,

A.Dummy9,

A.Dummy10,

'',

A.LastUserSeq,

CASE WHEN A.Qty \<\> POItem.Qty THEN'1' ELSE '0' END

FROM \#TMESPUDelvInterface AS A

JOIN \_TUIImpBL AS PO WITH(NOLOCK) ON A.BLSeq = PO.BLSeq

AND A.CompanySeq = PO.CompanySeq

JOIN \_TUIImpBLItem AS POItem WITH(NOLOCK) ON A.BLSeq = POItem.BLSeq

AND A.BLSerl = POItem.BLSerl

AND A.CompanySeq = POItem.CompanySeq

JOIN \#TUIImpDelv AS Delv ON 1=1

JOIN \_TDAItem AS B WITH(NOLOCK) ON A.ItemSeq = B.ItemSeq

AND A.CompanySeq = B.CompanySeq

LEFT OUTER JOIN \_TDAItemUnit AS C WITH(NOLOCK) ON A.CompanySeq = C.CompanySeq

AND A.ItemSeq = C.ItemSeq

AND A.UnitSeq = C.UnitSeq

 

UPDATE \#TUIImpDelvItem

SET StdQty = ROUND((CASE WHEN ISNULL(B.ConvDen,0) = 0 THEN 0 ELSE ISNULL(A.Qty,0) \* ISNULL(B.ConvNum,0) / ISNULL(B.ConvDen,0) END), @GoodQtyDecLength)

FROM \#TUIImpDelvItem AS A

JOIN \_TDAItemUnit AS B WITH(NOLOCK) ON B.CompanySeq = @CompanySeq

AND A.ItemSeq = B.ItemSeq

AND A.UnitSeq = B.UnitSeq

JOIN \_TDAItemStock AS C WITH(NOLOCK) ON C.CompanySeq = @CompanySeq

AND A.ItemSeq = C.ItemSeq

WHERE ISNULL(A.Qty,0) \<\> 0

AND A.IsReCalc = '1'

 

>  
>
> -- 금액 재계산

UPDATE Item

> SET CurAmt = (ISNULL(Item.Qty,0) \* ISNULL(Item.Price,0) )

-- CurAmt = (CASE @DomAmtType WHEN 1003001 THEN ROUND(Item.Price \* Item.Qty, CASE WHEN Mst.CurrSeq = @StdDomCurrSeq THEN @DomDecLength ELSE @AmtDecLength END)

> --WHEN 1003002 THEN ROUND(Item.Price \* Item.Qty, CASE WHEN Mst.CurrSeq = @StdDomCurrSeq THEN @DomDecLength ELSE @AmtDecLength END, 1)
>
> --WHEN 1003003 THEN CEILING(CASE CASE WHEN Mst.CurrSeq = @StdDomCurrSeq THEN @DomDecLength ELSE @AmtDecLength END WHEN 0 THEN Item.Price \* Item.Qty
>
>  
>
> --                                         ELSE Item.Price \* Item.Qty \* POWER(10, CASE WHEN Mst.CurrSeq = @StdDomCurrSeq THEN @DomDecLength ELSE @AmtDecLength END) END) END)
>
> FROM \#TUIImpDelvItem AS Item
>
> JOIN \#TUIImpDelv AS Mst ON Item.DelvSeq = Mst.DelvSeq

WHERE Item.IsReCalc = '1'

 

> UPDATE Item
>
> SET CurAmt = CASE WHEN Mst.CurrSeq = @StdDomCurrSeq

THEN dbo.\_FWPDGetDecPointQty(ISNULL(Item.CurAmt , 0 ), @DomDecLength , @DomAmtPoint)

ELSE dbo.\_FWPDGetDecPointQty(ISNULL(Item.CurAmt , 0 ), @AmtDecLength, 0)

END

-- CurAmt = (CASE @DomAmtType WHEN 1003001 THEN ROUND(Item.Price \* Item.Qty, CASE WHEN Mst.CurrSeq = @StdDomCurrSeq THEN @DomDecLength ELSE @AmtDecLength END)

> --WHEN 1003002 THEN ROUND(Item.Price \* Item.Qty, CASE WHEN Mst.CurrSeq = @StdDomCurrSeq THEN @DomDecLength ELSE @AmtDecLength END, 1)
>
> --WHEN 1003003 THEN CEILING(CASE CASE WHEN Mst.CurrSeq = @StdDomCurrSeq THEN @DomDecLength ELSE @AmtDecLength END WHEN 0 THEN Item.Price \* Item.Qty
>
> --                                         ELSE Item.Price \* Item.Qty \* POWER(10, CASE WHEN Mst.CurrSeq = @StdDomCurrSeq THEN @DomDecLength ELSE @AmtDecLength END) END) END)
>
> FROM \#TUIImpDelvItem AS Item
>
> JOIN \#TUIImpDelv AS Mst ON Item.DelvSeq = Mst.DelvSeq

WHERE Item.IsReCalc = '1'

 

> UPDATE Item
>
> SET DomAmt = CONVERT(DECIMAL(19,5), CASE @DomAmtType WHEN 1003001 THEN ROUND(Item.CurAmt \* Mst.ExRate / C.BasicAmt, @DomDecLength)

WHEN 1003002 THEN ROUND(Item.CurAmt \* Mst.ExRate / C.BasicAmt, @DomDecLength, 1)

WHEN 1003003 THEN CEILING(CASE @DomDecLength WHEN 0 THEN Item.CurAmt \* Mst.ExRate / C.BasicAmt ELSE Item.CurAmt \* Mst.ExRate / C.BasicAmt \* POWER(10, @DomDecLength) END) END)        

> FROM \#TUIImpDelvItem AS Item
>
> JOIN \#TUIImpDelv AS Mst ON Item.DelvSeq = Mst.DelvSeq

CROSS APPLY (SELECT CASE WHEN BasicAmt = 0 THEN 1 ELSE BasicAmt END AS BasicAmt

FROM \_TDACurr WITH(NOLOCK)

WHERE CompanySeq = @CompanySeq

AND CurrSeq = Mst.CurrSeq) AS C

WHERE Item.IsReCalc = '1'

 

> UPDATE Item
>
> SET DomAmt = ISNULL(DomAmt,0),
>
> CurAmt = ISNULL(CurAmt,0)
>
> FROM \#TUIImpDelvItem AS Item
>
> JOIN \#TUIImpDelv AS Mst ON Item.DelvSeq = Mst.DelvSeq

WHERE Item.IsReCalc = '1'

 

 

------------------------------------------

-- 처리된 입고Seq, 입고Serl UPDATE

------------------------------------------

UPDATE \#TMESPUDelvInterface

SET DelvSeq = B.DelvSeq,

DelvSerl = B.DelvSerl

FROM \#TMESPUDelvInterface AS A

--JOIN \#TUIImpDelvItem AS B ON A.BLSeq = B.BLSeq

-- AND A.BLSerl = B.BLSerl

-- AND A.ItemSeq = B.ItemSeq

-- AND A.LotNo = B.LotNo

JOIN \#TUIImpDelvItem AS B ON A.IDX_NO = B.IDX_NO

JOIN \#TUIImpDelv AS C ON B.DelvSeq = C.DelvSeq

 

END

-----------------------------------------------------------------------------------------

-- 'A' / 'U' 대상 담기 END

-----------------------------------------------------------------------------------------

END

END

 

--===================================================================

-- 트랜잭션 Start 구간

--===================================================================

BEGIN TRY

BEGIN TRAN

-----------------------------------------------------------------------

-- 'D' / 'U' 인 경우 삭제

-- 수입BL발주-\>입고 진행 - 입고수불(240) - 입고TR

-----------------------------------------------------------------------

IF EXISTS ( SELECT 1 FROM \#ImpDelvDEL WHERE WorkingTag IN (N'D', N'U') )

BEGIN

TRUNCATE TABLE \#SComSourceDailyBatch

TRUNCATE TABLE \#TLGInOutDailyBatch

 

 

------------------------------------------

-- 2-1) BL--\>수입입고 진행삭제

------------------------------------------

TRUNCATE TABLE \#SComSourceDailyBatch

TRUNCATE TABLE \#TLGInOutDailyBatch

 

INSERT INTO \#SCOMSourceDailyBatch

SELECT '\_TUIImpDelvItem',

A.DelvSeq,

A.DelvSerl,

0,

'\_TUIImpBLBLItem',

A.BLSeq,

A.BLSerl,

0,

D.Qty,

D.STDQty,

D.CurAmt,

0,

D.DomAmt,

0,

C.Qty,

C.STDQty,

C.CurAmt,

0,

C.DomAmt,

0T

FROM \#ImpDelvDEL AS A

JOIN \_TUIImpBLItem AS C ON A.BLSeq = C.BLSeq

AND A.BLSerl = C.BLSerl

JOIN \_TUIImpDelvItem AS D ON A.DelvSeq = D.DelvSeq

AND A.DelvSerl = D.DelvSerl

AND C.CompanySeq = D.CompanySeq

WHERE C.CompanySeq = @CompanySeq

AND C.Qty \<\> 0

AND D.Qty \<\> 0

IF EXISTS ( SELECT 1 FROM \#SComSourceDailyBatch )

BEGIN

EXEC dbo.\_SWComSourceDailyBatch N'D', @CompanySeq, @UserSeq

 

IF @@ERROR \<\> 0 RETURN

END

------------------------------------------

-- 2-2) 수불삭제 (입고)

------------------------------------------

INSERT INTO \#TLGInOutDailyBatch

( WorkingTag , InOutType , InOutSeq , InOutSerl , InOutSubSerl ,

DataKind , MessageType , Result , Status

)

SELECT DISTINCT

N'D'

, 240

, D.DelvSeq

, D.DelvSerl

, 0

, 0, 0, '', 0

FROM \#ImpDelvDEL AS D

WHERE D.DelvSeq \> 0

 

-- 수불 반영 (DELETE)

IF EXISTS ( SELECT 1 FROM \#TLGInOutDailyBatch WHERE WorkingTag IN (N'U', N'D') )

BEGIN

EXEC dbo.\_SWLGInOutDailyDELETE @CompanySeq = @CompanySeq

, @Level = 2

, @LanguageSeq = @LanguageSeq

, @UserSeq = @UserSeq -- @UserSeq 추가 : 2023.07.24 정민찬

 

IF @@ERROR \<\> 0 RETURN

 

IF NOT EXISTS ( SELECT 1 FROM \#TLGInOutDailyBatch WHERE Status \<\> 0 )

BEGIN

-- 창고재고 집계

EXEC dbo.\_SWLGWHStockUPDATE @CompanySeq = @CompanySeq

 

IF @@ERROR \<\> 0 RETURN

 

-- (-)재고 체크

EXEC dbo.\_SWLGInOutMinusCheck @CompanySeq = @CompanySeq

, @TableName = N'#TLGInOutDailyBatch'

, @LanguageSeq = @LanguageSeq

 

-- 구지 다음 단계까지 탈 이유가 없음, 속도 위하여

IF EXISTS ( SELECT TOP 1 1 FROM \#TLGInOutDailyBatch WHERE Status \<\> 0 )

BEGIN

----------------------------------------------------------------------------

-- 수불 오류가 발생하면, 전체 Rollback 후 Message처리를 하기 위해 GOTO문으로 이동

----------------------------------------------------------------------------

SELECT @ErrorMsg = RTRIM(@Word) + N' : ' + Result

FROM \#TLGInOutDailyBatch

WHERE Status \<\> 0

 

GOTO StockERROR_PROC

END

 

EXEC dbo.\_SWLGInOutLotMinusCheck @CompanySeq = @CompanySeq

, @TableName = N'#TLGInOutDailyBatch'

, @LanguageSeq = @LanguageSeq

 

IF EXISTS ( SELECT TOP 1 1 FROM \#TLGInOutDailyBatch WHERE Status \<\> 0 )

BEGIN

----------------------------------------------------------------------------

-- 수불 오류가 발생하면, 전체 Rollback 후 Message처리를 하기 위해 GOTO문으로 이동

----------------------------------------------------------------------------

SELECT @ErrorMsg = RTRIM(@Word) + N' : ' + Result

FROM \#TLGInOutDailyBatch

WHERE Status \<\> 0

 

GOTO StockERROR_PROC

END

END

END

 

------------------------------------------

-- 2-3) 수입입고 데이터 삭제

------------------------------------------

-- 수입입고 품목 삭제

DELETE \_TUIImpDelvItem

FROM \_TUIImpDelvItem AS A

JOIN \#ImpDelvDEL AS D ON A.DelvSeq = D.DelvSeq

AND A.DelvSerl = D.DelvSerl

WHERE A.CompanySeq = @CompanySeq

 

IF @@ERROR \<\> 0 RETURN

 

 

-- 품목전체 삭제된 경우 마스터 삭제

DELETE \_TUIImpDelv

FROM \_TUIImpDelv AS A

JOIN \#ImpDelvDEL AS D ON A.DelvSeq = D.DelvSeq

LEFT OUTER JOIN \_TUIImpDelvItem AS B ON A.CompanySeq = B.CompanySeq

AND A.DelvSeq = B.DelvSeq

WHERE A.CompanySeq = @CompanySeq

AND ISNULL(B.DelvSeq,0) = 0

 

IF @@ERROR \<\> 0 RETURN

 

END

-----------------------------------------------------------------------

-- 'D' / 'U' 인 경우 삭제 END

-----------------------------------------------------------------------

 

-----------------------------------------------------------------------

-- 'A' / 'U' 인 경우 생성

-----------------------------------------------------------------------

IF EXISTS ( SELECT 1 FROM \#ImpDelvINS WHERE WorkingTag IN (N'A', N'U') )

BEGIN

--#========================================================================================

-- ④ TR 데이터 생성 (입고/입고/진행/수불)

-- 입고TR - BL-\>입고 진행 - 입고수불(240)

--=========================================================================================

--BEGIN TRAN

-------------------------------------

-- \_TUIImpDelv (구매입고 마스터)

-------------------------------------

INSERT INTO \_TUIImpDelv(CompanySeq ,DelvSeq ,BizUnit ,DelvDate ,CustSeq ,

DelvNo ,PermitSeq ,BLSeq ,InvoiceSeq ,PaymentSeq ,

POSeq ,EmpSeq ,DeptSeq ,CurrSeq ,ExRate ,

                                                                                                                                                                                                                        

Remark ,LastUserSeq ,LastDateTime ,SMImpKind ,IsPJT ,

UMPriceTerms ,PgmSeq)

SELECT DISTINCT CompanySeq ,ISNULL(DelvSeq,0) ,ISNULL(BizUnit,0) ,ISNULL(DelvDate,'') ,ISNULL(CustSeq,0) ,

ISNULL(DelvNo,'') ,0 AS PermitSeq ,0 AS BLSeq ,ISNULL(InvoiceSeq,0) ,ISNULL(PaymentSeq,0) ,

ISNULL(POSeq,0) ,ISNULL(EmpSeq,0) ,ISNULL(DeptSeq,0) ,ISNULL(CurrSeq,0) ,ISNULL(ExRate,0) ,

ISNULL(Remark,'') ,ISNULL(LastUserSeq,0),GETDATE() ,ISNULL(SMImpKind,0) ,ISNULL(IsPJT,'') ,

ISNULL(UMPriceTerms,0) ,ISNULL(PgmSeq,0)

FROM \#TUIImpDelv

IF @@ERROR \<\> 0

BEGIN

--PRINT 'INSERT ERROR : \_TUIImpDelv'

ROLLBACK TRAN

RETURN

END

 

--------------------------------------

-- \_TUIImpDelvItem (수입입고 품목)

--------------------------------------

INSERT INTO \_TUIImpDelvItem(CompanySeq, DelvSeq, DelvSerl, ItemSeq, UnitSeq,

Qty, Price, CurAmt, DomAmt, WHSeq,

LotNo, FromSerl, ToSerl, ProdDate,

STDUnitSeq, STDQty, MakerSeq,

LastUserSeq, LastDateTime, Remark, PgmSeq,

>  

Dummy1, Dummy2, Dummy3, Dummy4, Dummy5,

Dummy6, Dummy7, Dummy8, Dummy9, Dummy10,

ValiDate)

SELECT CompanySeq, DelvSeq, DelvSerl, ItemSeq, UnitSeq,

Qty, Price, CurAmt, DomAmt, WHSeq,

LotNo, FromSerlNo, ToSerlNo, ProdDate,

STDUnitSeq, STDQty, MakerSeq,

>  

LastUserSeq, GETDATE(), Remark, PgmSeq,

Dummy1, Dummy2, Dummy3, Dummy4, Dummy5,

Dummy6, Dummy7, Dummy8, Dummy9, Dummy10,

ValiDate

FROM \#TUIImpDelvItem AS A

 

IF @@ERROR \<\> 0

BEGIN

--PRINT 'INSERT ERROR : \_TUIImpDelvItem'

ROLLBACK TRAN

RETURN

END

 

-----------------------------------------------

-- 진행연결(수입BL =\> 수입입고)

-----------------------------------------------

TRUNCATE TABLE \#SComSourceDailyBatch

 

INSERT INTO \#SComSourceDailyBatch

SELECT '\_TUIImpDelvItem', A.DelvSeq, A.DelvSerl, 0,

'\_TUIImpBLItem', A.BLSeq, A.BLSerl, 0,

A.Qty, A.STDQty, A.CurAmt, 0, A.DOMAmt, 0,

B.Qty, B.STDQty, B.CurAmt, 0, B.DOMAmt, 0

FROM \#TUIImpDelvItem AS A

JOIN \_TUIImpBLItem AS B ON B.CompanySeq = @CompanySeq

AND A.BLSeq = B.BLSeq

AND A.BLSerl = B.BLSerl

 

 

-- 진행연결

EXEC \_SWComSourceDailyBatch 'A', @CompanySeq, @UserSeq

IF @@ERROR \<\> 0

BEGIN

--PRINT 'INSERT ERROR : SourceDaily'

ROLLBACK TRAN

RETURN

END

-----------------------------------------------

-- 재고반영 (구매입고)

-----------------------------------------------

TRUNCATE TABLE \#TLGInOutDailyBatch

 

INSERT INTO \#TLGInOutDailyBatch

(

WorkingTag , InOutType , InOutSeq , InOutSerl , InOutSubSerl ,

DataKind , MessageType , Result , Status

)

SELECT DISTINCT

N'A'

, 240 -- 구매입고

, DelvSeq

, 0

, 0

, 0, 0, '', 0

FROM \#TUIImpDelvItem

 

-- 구매입고

EXEC \_SWLGInOutDailyINSERT @CompanySeq = @CompanySeq

, @Level = 2

, @LanguageSeq = @LanguageSeq

, @UserSeq = @UserSeq -- @UserSeq 추가 : 2023.07.24 정민찬

 

IF EXISTS (SELECT TOP 1 1 FROM \#TLGInOutDailyBatch WHERE Status \<\> 0 )

BEGIN

----------------------------------------------------------------------------

-- 수불 오류가 발생하면, 전체 Rollback 후 Message처리를 하기 위해 GOTO문으로 이동

----------------------------------------------------------------------------

SELECT @ErrorMsg = RTRIM(@Word) + N' : ' + Result

FROM \#TLGInOutDailyBatch

WHERE Status \<\> 0

GOTO StockERROR_PROC

 

END

-- 창고재고반영

EXEC \_SWLGWHStockUPDATE @CompanySeq

-- (-)재고 체크

EXEC dbo.\_SWLGInOutMinusCheck @CompanySeq = @CompanySeq

, @TableName = N'#TLGInOutDailyBatch'

, @LanguageSeq = @LanguageSeq

-- 구지 다음 단계까지 탈 이유가 없음, 속도 위하여

IF EXISTS ( SELECT TOP 1 1 FROM \#TLGInOutDailyBatch WHERE Status \<\> 0 )

BEGIN

----------------------------------------------------------------------------

-- 수불 오류가 발생하면, 전체 Rollback 후 Message처리를 하기 위해 GOTO문으로 이동

----------------------------------------------------------------------------

SELECT @ErrorMsg = RTRIM(@Word) + N' : ' + Result

FROM \#TLGInOutDailyBatch

WHERE Status \<\> 0

 

GOTO StockERROR_PROC

END

 

EXEC dbo.\_SWLGInOutLotMinusCheck @CompanySeq = @CompanySeq

, @TableName = N'#TLGInOutDailyBatch'

, @LanguageSeq = @LanguageSeq

 

IF EXISTS ( SELECT TOP 1 1 FROM \#TLGInOutDailyBatch WHERE Status \<\> 0 )

BEGIN

----------------------------------------------------------------------------

-- 수불 오류가 발생하면, 전체 Rollback 후 Message처리를 하기 위해 GOTO문으로 이동

----------------------------------------------------------------------------

SELECT @ErrorMsg = RTRIM(@Word) + N' : ' + Result

FROM \#TLGInOutDailyBatch

WHERE Status \<\> 0

 

GOTO StockERROR_PROC

END

END

 

SELECT @Status = 'OK', @Results = '정상처리되었습니다.'

 

-- Log Insert

UPDATE SMC_TMESImpDelvProclog

SET Status = @Status,

Results = @Results,

DelvSeq = DelvSeq

WHERE LogDateTime = @CurrDateTime

 

COMMIT

PRINT 'Success!'

END TRY

--===================================================================

-- 트랜잭션 END 구간

--===================================================================

BEGIN CATCH

ROLLBACK

PRINT 'Error!'

-- \[3\] 오류로그 남기기

DECLARE @ErrorMessage NVARCHAR(4000),

@ErrorSeverity INT,

@ErrorState INT

SELECT @ErrorMessage = ERROR_MESSAGE(),

@ErrorSeverity = ERROR_SEVERITY(),

@ErrorState = ERROR_STATE();

RAISERROR ( @ErrorMessage, @ErrorSeverity, @ErrorState )

END CATCH -- end try

IF OBJECT_ID ('tempdb..#TMESPUDelvInterface') IS NOT NULL DROP TABLE \#TMESPUDelvInterface

IF OBJECT_ID ('tempdb..#TLGInOutMonth') IS NOT NULL DROP TABLE \#TLGInOutMonth

IF OBJECT_ID ('tempdb..#TLGInOutMonthLot') IS NOT NULL DROP TABLE \#TLGInOutMonthLot

IF OBJECT_ID ('tempdb..#TLGInOutDailyBatch') IS NOT NULL DROP TABLE \#TLGInOutDailyBatch

IF OBJECT_ID ('tempdb..#SComSourceDailyBatch') IS NOT NULL DROP TABLE \#SComSourceDailyBatch

IF OBJECT_ID ('tempdb..#TUIImpDelv') IS NOT NULL DROP TABLE \#TUIImpDelv

IF OBJECT_ID ('tempdb..#TUIImpDelvItem') IS NOT NULL DROP TABLE \#TUIImpDelvItem

IF OBJECT_ID ('tempdb..#QCItem') IS NOT NULL DROP TABLE \#QCItem

IF OBJECT_ID ('tempdb..#Temp_InOutReqItemProg') IS NOT NULL DROP TABLE \#Temp_InOutReqItemProg

IF OBJECT_ID ('tempdb..#TMP_PROGRESSTABLE') IS NOT NULL DROP TABLE \#TMP_PROGRESSTABLE

IF OBJECT_ID ('tempdb..#TCOMProgressTracking') IS NOT NULL DROP TABLE \#TCOMProgressTracking

IF OBJECT_ID ('tempdb..#ImpDelvDEL') IS NOT NULL DROP TABLE \#ImpDelvDEL

IF OBJECT_ID ('tempdb..#ImpDelvINS') IS NOT NULL DROP TABLE \#ImpDelvINS

IF OBJECT_ID ('tempdb..#ImpDelvProg') IS NOT NULL DROP TABLE \#ImpDelvProg

 

RETURN

 

ERR_PROC:

 

-- Log Insert

UPDATE SMC_TMESImpDelvProclog

SET Status = @Status,

Results = @Results,

DelvSeq = DelvSeq

WHERE LogDateTime = @CurrDateTime

 

 

--SELECT @Status AS Status, @Results AS Results

 

RETURN

--------------------------------------------------------------------------

--------------------------------------------------------------------------

 

StockERROR_PROC:

 

ROLLBACK TRAN

PRINT 'StockERROR_PROC!'

 

SELECT @Status = 'ERR', @Results = @ErrorMsg

 

-- Log Insert

UPDATE SMC_TMESImpDelvProclog

SET Status = @Status,

Results = @Results,

DelvSeq = DelvSeq

WHERE LogDateTime = @CurrDateTime

 

 

 

IF OBJECT_ID ('tempdb..#TMESPUDelvInterface') IS NOT NULL DROP TABLE \#TMESPUDelvInterface

IF OBJECT_ID ('tempdb..#TLGInOutMonth') IS NOT NULL DROP TABLE \#TLGInOutMonth

IF OBJECT_ID ('tempdb..#TLGInOutMonthLot') IS NOT NULL DROP TABLE \#TLGInOutMonthLot

IF OBJECT_ID ('tempdb..#TLGInOutDailyBatch') IS NOT NULL DROP TABLE \#TLGInOutDailyBatch

IF OBJECT_ID ('tempdb..#SComSourceDailyBatch') IS NOT NULL DROP TABLE \#SComSourceDailyBatch

IF OBJECT_ID ('tempdb..#TUIImpDelv') IS NOT NULL DROP TABLE \#TUIImpDelv

IF OBJECT_ID ('tempdb..#TUIImpDelvItem') IS NOT NULL DROP TABLE \#TUIImpDelvItem

IF OBJECT_ID ('tempdb..#QCItem') IS NOT NULL DROP TABLE \#QCItem

IF OBJECT_ID ('tempdb..#Temp_InOutReqItemProg') IS NOT NULL DROP TABLE \#Temp_InOutReqItemProg

IF OBJECT_ID ('tempdb..#TMP_PROGRESSTABLE') IS NOT NULL DROP TABLE \#TMP_PROGRESSTABLE

IF OBJECT_ID ('tempdb..#TCOMProgressTracking') IS NOT NULL DROP TABLE \#TCOMProgressTracking

IF OBJECT_ID ('tempdb..#ImpDelvDEL') IS NOT NULL DROP TABLE \#ImpDelvDEL

IF OBJECT_ID ('tempdb..#ImpDelvINS') IS NOT NULL DROP TABLE \#ImpDelvINS

IF OBJECT_ID ('tempdb..#ImpDelvProg') IS NOT NULL DROP TABLE \#ImpDelvProg

 

RETURN

--go

--DECLARE @DelvSeq INT,

-- @Status NVARCHAR(10),

-- @Results NVARCHAR(250)

 

--SELECT @DelvSeq = 260

 

--EXEC smc_SUIDelvInProc

-- @WorkingTag = 'A'        

--,@BLSeq         = 260

--,@BLSerl         = '1\_/2\_/3\_/4\_/'

--,@DelvInDate = '20241126'

--,@UserSeq         = 1

--,@WHSeq         = '1\_/9\_/9\_/9\_/'

--,@Qty         = '100\_/200\_/300\_/400\_/'

--,@DelvSeq = @DelvSeq OUTPUT

--,@Status = @Status OUTPUT

--,@Results = @Results OUTPUT

 

----SELECT top 1 \* FROM \_TUIImpDelvIn order by DelvInSeq desc

----SELECT top 4 \* FROM \_TUIImpDelvInItem order by DelvInSeq desc

 

--select @Status,@Results

------==============================================================

------==============================================================

 

--DECLARE @DelvSeq INT,

-- @Status NVARCHAR(10),

-- @Results NVARCHAR(250)

 

--SELECT @DelvSeq = 296

 

 

--EXEC smc_SUIDelvInProc

-- @WorkingTag = 'D'        

--,@BLSeq         = 260

--,@BLSerl         = '1\_/2\_/3\_/4\_/'

--,@DelvInDate = '20241124'

--,@UserSeq         = 1

--,@WHSeq         = '1\_/9\_/9\_/9\_/'

--,@Qty         = '100\_/200\_/300\_/400\_/'

--,@DelvSeq = @DelvSeq OUTPUT

--,@Status = @Status OUTPUT

--,@Results = @Results OUTPUT

 

--select @Status,@Results