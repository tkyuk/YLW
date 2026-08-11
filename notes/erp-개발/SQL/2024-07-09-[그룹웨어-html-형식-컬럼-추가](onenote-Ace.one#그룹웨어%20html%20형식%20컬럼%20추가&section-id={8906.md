---
title: [그룹웨어 html 형식 컬럼 추가](onenote:Ace.one#그룹웨어%20html%20형식%20컬럼%20추가&section-id={890692CD-9BCC-451A-BCF5-AA1910C5517E}&page-id={6C3B774F-B953-4F0C-A490-DFCF5D828A8C}&end&base-path=https://d.docs.live.net/4b1f2458d28ea117/문서/220523)
date: 2024-07-09
tags: [erp, 개발, SQL]
---

# [그룹웨어 html 형식 컬럼 추가](onenote:Ace.one#그룹웨어%20html%20형식%20컬럼%20추가&section-id={890692CD-9BCC-451A-BCF5-AA1910C5517E}&page-id={6C3B774F-B953-4F0C-A490-DFCF5D828A8C}&end&base-path=https://d.docs.live.net/4b1f2458d28ea117/문서/220523)

BEGIN TRAN

 

CREATE TABLE \#HTML

(

HTML NVARCHAR(MAX)

,Title NVARCHAR(200)

)

 

EXEC kl_SXPRWkOverTimeAppQueryHTML

1,

1,

1,

'WkOver',

20

 

SELECT \* FROM \#HTML

ROLLBACK TRAN

BEGIN TRAN

CREATE TABLE \#HTML

(

HTML NVARCHAR(MAX), Title NVARCHAR(200)

)

EXEC kl_SWSLEstimateGWPrintQueryHTML

@CompanySeq = 1

,@LanguageSeq = 1

,@UserSeq = 1

,@GWWorkKind = 'Estimate2'

,@GWValue1 = '124,1,'

SELECT \* FROM \#HTML

--SELECT \* FROM \_TSLEstimate WHERE EstimateNo = '202412310001'

--SELECT \* FROM \_TSLEstimate WHERE EstimateNo = '202401030004'

--SELECT \* FROM kl_TSLEstimate where EstimateSeq = 181

--SELECT \* FROM kl_TSLEstimate where EstimateSeq = 21

ROLLBACK TRAN

 

IF EXISTS (SELECT \* FROM sysobjects WHERE id = OBJECT_ID('kl_SXPRWkOverTimeAppQueryHTML') AND sysstat & 0xf = 4)

DROP PROCEDURE dbo.kl_SXPRWkOverTimeAppQueryHTML

GO

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*

화면명 - OT실적

작성일 - 2024-01-03

작성자 -

\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

CREATE PROC dbo.kl_SXPRWkOverTimeAppQueryHTML

@CompanySeq INT ,

@LanguageSeq INT ,

@UserSeq INT ,

@GWWorkKind NVARCHAR(40),

@GWValue1 INT

AS

 

 

DECLARE @OTAppSeq INT

 

SELECT @OTAppSeq = @GWValue1

 

 

--==========================

-- 환경설정

--==========================

DECLARE @LinkSeq INT

 

 

EXEC dbo.\_SWCOMEnv @CompanySeq, 9001, @UserSeq, @@PROCID, @LinkSeq OUTPUT -- 그룹웨어 업체

 

 

CREATE TABLE \#Result (

IDX_NO INT IDENTITY(1, 1)

,Title NVARCHAR(100)

,ReqEmpName NVARCHAR(100)

,ReqEmpId NVARCHAR(100)

,ReqDeptName NVARCHAR(100)

,AppDate NCHAR(8)

,AppReason NVARCHAR(200)

,EmpName NVARCHAR(100)

,EmpId NVARCHAR(100)

,WkDate NCHAR(8)

,WkName NVARCHAR(100)

,BegTime NCHAR(4)

,EndTime NCHAR(4)

,Hours DECIMAL(19,5)

)

 

 

INSERT INTO \#Result

(

Title

,ReqEmpName

,ReqEmpId

,ReqDeptName

,AppDate

,AppReason

,EmpName

,EmpId

,WkDate

,WkName

,BegTime

,EndTime

,Hours

)

SELECT '시간외 근무신청서_실적'

,Req.EmpName

,Req.EmpID

,Req.DeptName

,A.AppDate

,A.AppReason

,D.EmpName

,D.EmpID

,B.WkDate

,DATENAME(WEEKDAY, B.WkDate)

,B.BegTime

,B.EndTime

,B.DTCnt

FROM \_TXPRWkOverTimeApp AS A

JOIN \_TXPRWkOverTimeAppDtl AS B ON A.OTAppSeq = B.OTAppSeq

AND A.CompanySeq = B.CompanySeq

JOIN \_VWHREmpInfoLast AS Req ON A.EmpSeq = Req.EmpSeq

AND A.CompanySeq = Req.CompanySeq

JOIN \_VWHREmpInfoLast AS D ON B.EmpSeq = D.EmpSeq

AND B.CompanySeq = D.CompanySeq

WHERE A.CompanySeq = @CompanySeq

AND A.OTAppSeq = @OTAppSeq

--\_TXPRWkWorkAppDtl

 

--=======================

-- 그룹웨어 HTML 설정

--=======================

DECLARE @Header NVARCHAR(MAX),

@Body NVARCHAR(MAX),

@ReplaceBody NVARCHAR(MAX),

@Footer NVARCHAR(MAX),

@TitleName NVARCHAR(200),

@strStyle NVARCHAR(MAX),

@strTitle NVARCHAR(MAX),

@strRepeatBody NVARCHAR(MAX),

@strContentsBody NVARCHAR(MAX),

@strRepeatBodyPRT NVARCHAR(MAX),

@index INT,

@index_Max INT,

@strRB NVARCHAR(MAX)

 

 

SELECT @Header = ISNULL(Header , N'') ,

@Body = ISNULL(Body , N'') ,

@Footer = ISNULL(Footer , N'')

FROM \_TCOMEnvGroupWare WITH(NOLOCK)

WHERE CompanySeq = @CompanySeq

AND WorkKind = @GWWorkKind

 

--// style 내용만 분리

SELECT @strStyle = SUBSTRING(@Body,0,CHARINDEX(N'\</style\>',@Body) + LEN(N'\</style\>'))

--// title 만 분리 설정에 따라 빈문자열로 치환

SELECT @strTitle = SUBSTRING(@Body,CHARINDEX(N'\<h1\>',@Body),CHARINDEX(N'\</h1\>',@Body) - CHARINDEX(N'\<h1\>',@Body) + LEN(N'\</h1\>'))

--// 이하 컨텐츠 내용

SELECT @strContentsBody = SUBSTRING(@Body,CHARINDEX(N'\</h1\>',@Body) + LEN(N'\</h1\>'),LEN(@Body))

--// 반복 영역 가져오기

SELECT @strRepeatBody = SUBSTRING(@Body,CHARINDEX(N'\<!-- 반복영역 시작--\>',@Body),CHARINDEX(N'\<!-- 반복영역 끝--\>',@Body) - CHARINDEX(N'\<!-- 반복영역 시작--\>',@Body) + LEN(N'\<!-- 반복영역 끝--\>'))

--// 미 반복 구문 Replace

 

-- HTML 양식에 REPLACE 처리

SELECT @strTitle = REPLACE(@strTitle, '근무신청서_실적' ,(SELECT TOP 1 Title FROM \#Result))

SELECT @strContentsBody = REPLACE(@strContentsBody, '#ReqEmpName' , (SELECT TOP 1 ReqEmpName FROM \#Result))

SELECT @strContentsBody = REPLACE(@strContentsBody, '#ReqEmpId' , (SELECT TOP 1 ReqEmpId FROM \#Result))

SELECT @strContentsBody = REPLACE(@strContentsBody, '#ReqDeptName' , (SELECT TOP 1 ReqDeptName FROM \#Result))

SELECT @strContentsBody = REPLACE(@strContentsBody, '#AppDate' , (SELECT TOP 1 LEFT(AppDate,4) + '년' + SUBSTRING(AppDate,5,2) + '월' + RIGHT(AppDate,2) + '일' FROM \#Result))

SELECT @strContentsBody = REPLACE(@strContentsBody, '#AppReason' , (SELECT TOP 1 AppReason FROM \#Result))

 

--Body 만들기 2017.09.21 박수영 수정

CREATE TABLE \#Body

(

IDX_NO INT,

BodyHTML NVARCHAR(MAX),

ReplaceHTML NVARCHAR(MAX)

)

 

INSERT INTO \#Body

SELECT IDX_NO, @strRepeatBody, ''

FROM \#Result

 

UPDATE A

SET ReplaceHTML = REPLACE(A.BodyHTML, '#Serl', B.IDX_NO)

FROM \#Body AS A

JOIN \#Result AS B ON A.IDX_NO = B.IDX_NO

 

UPDATE A

SET ReplaceHTML = REPLACE(A.ReplaceHTML, '#EmpName', EmpName)

FROM \#Body AS A

JOIN \#Result AS B ON A.IDX_NO = B.IDX_NO

 

UPDATE A

SET ReplaceHTML = REPLACE(A.ReplaceHTML, '#EmpId', EmpId)

FROM \#Body AS A

JOIN \#Result AS B ON A.IDX_NO = B.IDX_NO

 

 

UPDATE A

SET ReplaceHTML = REPLACE(A.ReplaceHTML, '#WkDate', LEFT(B.WkDate,4) + '년' + SUBSTRING(B.WkDate,5,2) + '월' + RIGHT(B.WkDate,2) + '일')

FROM \#Body AS A

JOIN \#Result AS B ON A.IDX_NO = B.IDX_NO

 

UPDATE A

SET ReplaceHTML = REPLACE(A.ReplaceHTML, '#WkName', WkName)

FROM \#Body AS A

JOIN \#Result AS B ON A.IDX_NO = B.IDX_NO

 

UPDATE A

SET ReplaceHTML = REPLACE(A.ReplaceHTML, '#BegTime', LEFT(B.BegTime,2) + ':' + RIGHT(B.BegTime,2))

FROM \#Body AS A

JOIN \#Result AS B ON A.IDX_NO = B.IDX_NO

 

UPDATE A

SET ReplaceHTML = REPLACE(A.ReplaceHTML, '#EndTime', LEFT(B.EndTime,2) + ':' + RIGHT(B.EndTime,2))

FROM \#Body AS A

JOIN \#Result AS B ON A.IDX_NO = B.IDX_NO

 

UPDATE A

SET ReplaceHTML = REPLACE(A.ReplaceHTML, '#Hours', FORMAT(B.Hours, '##0.######') )

FROM \#Body AS A

JOIN \#Result AS B ON A.IDX_NO = B.IDX_NO

 

SELECT @index = 1

SELECT @Body = ''

SELECT @strRB = ''

 

WHILE 1=1

BEGIN

IF NOT EXISTS (SELECT 1 FROM \#Body WHERE IDX_NO = @index) BREAK

 

SELECT @ReplaceBody = ReplaceHTML FROM \#Body WHERE IDX_NO = @index

SELECT @strRB = @strRB + @ReplaceBody

SELECT @index = @index + 1

 

END

 

SELECT @strContentsBody = REPLACE(@strContentsBody, @strRepeatBody, @strRB)

--SELECT @strContentsBody

IF @LinkSeq IN (90010013 , 90010024, 90010045) -- 그룹웨어종류(이든비즈텍) 조건 추가

BEGIN

-- 다우 제목

 

SELECT @TitleName = (SELECT TOP 1 Title FROM \#Result)

 

--//다우 방식 출력

INSERT INTO \#HTML (HTML, Title)

SELECT @strStyle + @strContentsBody, @TitleName

 

/\*

PRINT @strStyle

PRINT @strContentsBody

\*/

 

END

ELSE

BEGIN

--//기존 새움 방식 출력

INSERT INTO \#HTML (HTML)

SELECT @Header + @strStyle + @strTitle + @strContentsBody + @Footer

/\*

PRINT @Header

PRINT @strStyle

PRINT @strTitle

PRINT @strContentsBody

PRINT @Footer

\*/

END

 

RETURN

GO

BEGIN TRAN

 

CREATE TABLE \#HTML

(

HTML NVARCHAR(MAX)

,Title NVARCHAR(200)

)

 

EXEC kl_SXPRWkOverTimeAppQueryHTML

1,

1,

1,

'WkOver',

20

 

SELECT \* FROM \#HTML

ROLLBACK TRAN