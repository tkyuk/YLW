---
title: 메일 양식 \_TCASendMessage
date: 2024-10-31
tags: [erp, 개발, SQL]
---

# 메일 양식 \_TCASendMessage

DROP PROC mcm_SWDAItemSendMail

GO

CREATE PROC mcm_SWDAItemSendMail

@ServiceSeq INT = 0,

@WorkingTag NVARCHAR(10)= '',

@CompanySeq INT = 1,

@LanguageSeq INT = 1,

@UserSeq INT = 0,

@PgmSeq INT = 0,

@IsTransaction BIT = 0

AS

-- 품목등록에서 값 변경된 경우

UPDATE A

SET SendMail = '1'

FROM \#BIZ_OUT_DataBlock1 AS A

JOIN \_TDAItem AS B WITH(NOLOCK) ON B.CompanySeq = @CompanySeq

AND B.ItemSeq = A.ItemSeq

JOIN \_TDAUMinorValue AS C WITH(NOLOCK) ON C.CompanySeq = @CompanySeq -- mcm_품목상태별이메일정보.품목세부상태

AND C.MajorSeq = 1110142

AND C.Serl = 15000001

AND C.ValueSeq = A.UMStatusDetail

WHERE A.WorkingTag = 'U'

AND A.UMStatusDetail \<\> A.UMStatusDetailOld

AND ISNULL(A.UMStatusDetailOld,0) \<\> 0

AND A.Status = 0

 

DECLARE @SendEmail NVARCHAR(200)

 

SELECT @SendEmail = ISNULL((SELECT A.PwdMailAdder

FROM \_TCAUser AS A WITH(NOLOCK)

WHERE A.CompanySeq = @CompanySeq

AND A.UserSeq = @UserSeq),'')

 

CREATE TABLE \#Tmp_Email(

IDX_NO INT IDENTITY ,

ItemSeq INT ,

Subject1 NVARCHAR(MAX),

SendMessage NVARCHAR(MAX),

Email NVARCHAR(100)

)

INSERT INTO \#Tmp_Email(ItemSeq,Subject1,SendMessage,Email)

SELECT A.ItemSeq

,REPLACE(REPLACE(REPLACE(E.ValueText,'#ItemName',B.ItemName),'#ItemNo',B.ItemNo),'#UMStatusDetailName',G.MinorName) AS Subject1

,REPLACE(REPLACE(REPLACE(F.ValueText,'#ItemName',B.ItemName),'#ItemNo',B.ItemNo),'#UMStatusDetailName',G.MinorName) AS SendMessage

,D.ValueText

FROM \#BIZ_OUT_DataBlock1 AS A

JOIN \_TDAItem AS B WITH(NOLOCK) ON B.CompanySeq = @CompanySeq

AND B.ItemSeq = A.ItemSeq

JOIN \_TDAUMinorValue AS C WITH(NOLOCK) ON C.CompanySeq = @CompanySeq -- mcm_품목상태별이메일정보.품목세부상태

AND C.MajorSeq = 1110142

AND C.Serl = 15000001

AND C.ValueSeq = A.UMStatusDetail

JOIN \_TDAUMinorValue AS D WITH(NOLOCK) ON C.CompanySeq = D.CompanySeq -- mcm_품목상태별이메일정보.받는사람이메일

AND C.MinorSeq = D.MinorSeq

AND D.Serl = 15000002

AND D.MajorSeq = 1110142

JOIN \_TDAUMinorValue AS E WITH(NOLOCK) ON C.CompanySeq = E.CompanySeq -- mcm_품목상태별이메일정보.메일제목

AND C.MinorSeq = E.MinorSeq

AND E.Serl = 15000003

AND E.MajorSeq = 1110142

JOIN \_TDAUMinorValue AS F WITH(NOLOCK) ON C.CompanySeq = F.CompanySeq -- mcm_품목상태별이메일정보.메일내용

AND C.MinorSeq = F.MinorSeq

AND F.Serl = 15000004

AND F.MajorSeq = 1110142

JOIN \_TDAUMinor AS G WITH(NOLOCK) ON G.CompanySeq = @CompanySeq -- mcm_품목세부상태

AND G.MinorSeq = A.UMStatusDetail

WHERE ISNULL(A.SendMail,'') = '1'

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

DECLARE @Seq INT ,

@SendMessageID INT ,

@XmlDocument XML ,

@ColumnInfo NVARCHAR(MAX) ,

@SQL NVARCHAR(MAX) ,

@Cnt INT ,

@SeqValue INT ,

@SerlValue INT ,

@SubSerlValue INT ,

@Subject NVARCHAR(500) ,

@MailContent NVARCHAR(MAX) ,

@Email NVARCHAR(200) ,

@GETDATE DATETIME ,

@MailRecvName NVARCHAR(200) ,

@ViewerId NVARCHAR(200)

SELECT @GETDATE = GETDATE(),

@ViewerId = 'ItemMail'

CREATE TABLE \#TCOMOnlineViewerData (IDOrder INT IDENTITY(1,1), STDSeq INT, STDSerl INT, STDSubSerl INT)

 

-- 컬럼 정보 수집

SELECT @ColumnInfo = ''

 

--syscolumns의 Xtype 231인 경우, max_length가 -1 이면 MAX로 치환하도록 수정 2024.03.04 정민찬

SELECT @ColumnInfo = @ColumnInfo + name + ' ' + CASE system_type_id WHEN 34 THEN 'IMAGE, '

WHEN 56 THEN 'INT, '

WHEN 61 THEN 'DATETIME, '

WHEN 104 THEN 'BIT, '

WHEN 165 THEN 'VARBINARY, '

WHEN 106 THEN 'DECIMAL(' + CONVERT(NVARCHAR(10), Precision ) + ', ' + CONVERT(NVARCHAR(10), scale) + '), '

WHEN 108 THEN 'NUMERIC(' + CONVERT(NVARCHAR(10), Precision ) + ', ' + CONVERT(NVARCHAR(10), scale) + '), '

WHEN 175 THEN 'CHAR(' + CONVERT(NVARCHAR(10), max_length) + '), '

WHEN 167 THEN 'VARCHAR(' + CONVERT(NVARCHAR(10), max_length) + '), '

WHEN 239 THEN 'NCHAR(' + CONVERT(NVARCHAR(100), CONVERT(INT, max_length) / 2) + '), '

WHEN 231 THEN (CASE WHEN max_length = -1 THEN 'NVARCHAR(MAX), '

ELSE 'NVARCHAR(' + CONVERT(NVARCHAR(100), CONVERT(INT, max_length) / 2) + '), ' END)

ELSE '' END

FROM tempdb.sys.columns WITH(NOLOCK)

WHERE object_id = OBJECT_ID('tempdb..#Tmp_Email')

 

SELECT @ColumnInfo = LEFT(@ColumnInfo, LEN(@ColumnInfo) - 1)

 

-- XML 변환

INSERT INTO \#TCOMOnlineViewerData (STDSeq)

SELECT ItemSeq

FROM \#Tmp_Email

 

SELECT @Cnt = 1

 

WHILE 1=1

BEGIN

 

SELECT @Email = A.Email,

@Subject = A.Subject1,

@MailContent = A.SendMessage,

@MailRecvName = A.Email,

@SeqValue = A.ItemSeq

FROM \#Tmp_Email AS A

JOIN \#TCOMOnlineViewerData AS B ON B.STDSeq = A.ItemSeq

WHERE B.IDOrder = @Cnt

 

-- MessageType = 4 로 하드코딩 되어있어 변수로 받을 수 있도록 수정 2021.05.21 mjjang

DECLARE @MessageType INT

SELECT @MessageType = 1

 

--SELECT @MessageType = ISNULL(MessageType, 4)

-- FROM OTCAOnlineViewer WITH(NOLOCK)

-- WHERE CompanySeq = @CompanySeq

-- AND ViewerId = @ViewerID

 

SELECT @MailContent = REPLACE(@MailContent, CHAR(13) + CHAR(10), '\<br/\>')

SELECT @XmlDocument = '\<ROOT\>' + (SELECT A.\*

FROM \#Tmp_Email AS A

JOIN \#TCOMOnlineViewerData AS B ON B.STDSeq = A.ItemSeq

WHERE B.IDOrder = @Cnt

FOR XML AUTO) + '\</ROOT\>'

IF @XmlDocument IS NULL BREAK

EXEC @Seq = dbo.\_SWCOMCreateSeq @CompanySeq, '\_TCOMOnlineViewerData', 'ViewerValue', 1

INSERT INTO \_TCOMOnlineViewerData (CompanySeq , SendDateKey , ViewerID , ViewerValue , Email ,

Seq , Serl , SubSerl , ClickCount , IsConfirm ,

IsCancel , IsRead , IsRequest , RequestMemo , KeyWord ,

Content , ColumnInfo , PgmSeq , SendUserSeq , SendEmail ,

LastUserSeq , LastDateTime)

SELECT @CompanySeq , @GETDATE , @ViewerID , @Seq + 1 , @Email ,

@SeqValue , @SerlValue , @SubSerlValue , 0 , '0' ,

'0' , '0' , '0' , '' , '' AS KeyWord,

@XmlDocument, @ColumnInfo , @PgmSeq , @UserSeq , @SendEmail ,

@UserSeq , @GETDATE

 

SELECT @SendMessageID = ISNULL(MAX(SendMessageID), 0)

FROM \_TCASendMessage WITH(NOLOCK)

WHERE CompanySeq = @CompanySeq

 

INSERT INTO \_TCASendMessage (CompanySeq , SendMessageID , SendUserSeq , SendMessageType, Subject ,

SendMessage , RecvUserSeq , IsMemo , IsMail , IsSMS ,

SendMemo , SendMail , MemoDateTime , MailDateTime , SMSDateTime ,

SendSMS , TblKey , CrDateTime , RecvEmail , RecvTelNo ,

LoginPwd , States , Result , EmailPass , AttachMessage ,

AttachFileName , SendEmail , CCEmail , charset , AttachFiles ,

AttachType , AttachConfig , IsProcessing , PgmSeq , ToPgmSeq ,

JumpMode , JumpData , IsFast , MessageGroupSeq, SendTelNo ,

BCCEmail , SendDateKey , ViewerId , ViewerValue , BisDivCode ,

SecuBody )

SELECT @CompanySeq , @SendMessageID + 1, @UserSeq , 4 , @Subject ,

@MailContent , @UserSeq , '0' , '1' , '0' ,

'' , 0 , '' , @GETDATE , '' ,

'' , '' , @GETDATE , @Email , '' ,

'' , '' , '' , '' , '' ,

'' , @SendEmail , '' , 'utf-8' , '' ,

4 , '' , NULL , @PgmSeq , 0 ,

0 , '' , 0 , 0 , '' ,

'' , @GETDATE , @ViewerId , @Seq + 1 , 0 ,

CASE @MailContent WHEN '' THEN NULL ELSE @MailContent END

SELECT @Cnt = @Cnt + 1

 

END

 

UPDATE A

SET UMStatusDetailOld = UMStatusDetail

FROM \#BIZ_OUT_DataBlock1 AS A

WHERE A.Status = 0

 

RETURN

CREATE PROCEDURE shilla_SWCOMOnlineViewerSendPUDelv

@CompanySeq INT , -- 법인내부코드

@LanguageSeq INT , -- 다국어내부코드

@MailTitle NVARCHAR(200), -- 메일타이틀

@TempTableName NVARCHAR(100), -- 전송 데이터가 수집된 임시테이블

@SeqCol NVARCHAR(100), -- 메일을 보낼 기준 데이터 내부코드 (ex.거래처원장 : 거래처내부코드, 거래명세서 : 거래명세서내부코드..)

@SerlCol NVARCHAR(100), -- 메일을 보낼 기준 데이터 순번

@SubSerlCol NVARCHAR(100), -- 메일을 보낼 기준 데이터 하부순번

@EmailCol NVARCHAR(100), -- 받는사람 메일주소 컬럼

@SendEMailCol NVARCHAR(100), -- 보내는사람 메일주소 컬럼

@SubjectCol NVARCHAR(100), -- 메일제목 컬럼

@MailContentCol NVARCHAR(100), -- 메일내용 컬럼

@SendTitle NVARCHAR(200), -- 메일 내용에 표기될 발신자

@RecvTitle NVARCHAR(200), -- 메일 내용에 표기될 수신자 컬럼

@PgmSeq INT , -- 프로그램내부코드

@UserSeq INT , -- 전송담당자내부코드

@ViewerID NVARCHAR(100), -- 전송업무

@KeyWord NVARCHAR(100) -- 문서암호

AS

 

DECLARE @Seq INT ,

@SendMessageID INT ,

@XmlDocument XML ,

@ColumnInfo NVARCHAR(MAX) ,

@SQL NVARCHAR(MAX) ,

@Cnt INT ,

@SeqValue INT ,

@SerlValue INT ,

@SubSerlValue INT ,

@Subject NVARCHAR(500) ,

@MailContent NVARCHAR(MAX) ,

@SendEmail NVARCHAR(200) ,

@Email NVARCHAR(200) ,

@GETDATE DATETIME ,

@MailRecvName NVARCHAR(200)

SELECT @GETDATE = GETDATE()

 

CREATE TABLE \#TCOMOnlineViewerData (IDOrder INT, STDSeq INT, STDSerl INT, STDSubSerl INT)

 

 

-- 컬럼 정보 수집

SELECT @ColumnInfo = ''

 

--syscolumns의 Xtype 231인 경우, max_length가 -1 이면 MAX로 치환하도록 수정 2024.03.04 정민찬

SELECT @ColumnInfo = @ColumnInfo + name + ' ' + CASE system_type_id WHEN 34 THEN 'IMAGE, '

WHEN 56 THEN 'INT, '

WHEN 61 THEN 'DATETIME, '

WHEN 104 THEN 'BIT, '

WHEN 165 THEN 'VARBINARY, '

WHEN 106 THEN 'DECIMAL(' + CONVERT(NVARCHAR(10), Precision ) + ', ' + CONVERT(NVARCHAR(10), scale) + '), '

WHEN 108 THEN 'NUMERIC(' + CONVERT(NVARCHAR(10), Precision ) + ', ' + CONVERT(NVARCHAR(10), scale) + '), '

WHEN 175 THEN 'CHAR(' + CONVERT(NVARCHAR(10), max_length) + '), '

WHEN 167 THEN 'VARCHAR(' + CONVERT(NVARCHAR(10), max_length) + '), '

WHEN 239 THEN 'NCHAR(' + CONVERT(NVARCHAR(100), CONVERT(INT, max_length) / 2) + '), '

WHEN 231 THEN (CASE WHEN max_length = -1 THEN 'NVARCHAR(MAX), '

ELSE 'NVARCHAR(' + CONVERT(NVARCHAR(100), CONVERT(INT, max_length) / 2) + '), ' END)

ELSE '' END

FROM tempdb.sys.columns WITH(NOLOCK)

WHERE object_id = OBJECT_ID('tempdb..' + @TempTableName)

 

SELECT @ColumnInfo = LEFT(@ColumnInfo, LEN(@ColumnInfo) - 1)

 

-- XML 변환

SELECT @SQL = 'INSERT INTO \#TCOMOnlineViewerData (IDOrder, STDSeq'

IF @SerlCol \<\> ''

SELECT @SQL = @SQL + ', STDSerl'

IF @SubSerlCol \<\> ''

SELECT @SQL = @SQL + ', STDSubSerl'

SELECT @SQL = @SQL + ')' + CHAR(13)

SELECT @SQL = @SQL + 'SELECT DISTINCT DENSE_RANK() OVER(ORDER BY ' + @SeqCol

IF @SerlCol \<\> ''

SELECT @SQL = @SQL + ', ' + @SerlCol

IF @SubSerlCol \<\> ''

SELECT @SQL = @SQL + ', ' + @SubSerlCol

SELECT @SQL = @SQL + '), '

SELECT @SQL = @SQL + @SeqCol

IF @SerlCol \<\> ''

SELECT @SQL = @SQL + ', ' + @SerlCol

IF @SubSerlCol \<\> ''

SELECT @SQL = @SQL + ', ' + @SubSerlCol

SELECT @SQL = @SQL + CHAR(13) + ' FROM ' + @TempTableName

--PRINT @SQL

EXEC SP_EXECUTESQL @SQL

 

SELECT @Cnt = 1

 

WHILE 1=1

BEGIN

 

SELECT @SQL = 'SELECT @Email = A.' + @EmailCol + ', @Subject = A.' + @SubjectCol + ', @MailContent = A.' + @MailContentCol + ', @SendEmail = A.' + @SendEmailCol + ', @MailRecvName = A.' + @RecvTitle + ', @SeqValue = A.' + @SeqCol

IF @SerlCol \<\> ''

SELECT @SQL = @SQL + ', @SerlValue = A.' + @SerlCol

IF @SubSerlCol \<\> ''

SELECT @SQL = @SQL + ', @SubSerlValue = A.' + @SubSerlCol

SELECT @SQL = @SQL + CHAR(13) + ' FROM ' + @TempTableName + ' AS A' + CHAR(13)

SELECT @SQL = @SQL + ' JOIN \#TCOMOnlineViewerData AS B ON B.STDSeq = A.' + @SeqCol + CHAR(13)

IF @SerlCol \<\> ''

SELECT @SQL = @SQL + 'AND B.STDSerl = A.' + @SerlCol + CHAR(13)

IF @SubSerlCol \<\> ''

SELECT @SQL = @SQL + 'AND B.STDSubSerl = A.' + @SubSerlCol + CHAR(13)

SELECT @SQL = @SQL + ' WHERE B.IDOrder = ' + CONVERT(NVARCHAR(10), @Cnt)

 

--PRINT @SQL

IF @SerlCol = ''

EXEC SP_EXECUTESQL @SQL, N'@Email NVARCHAR(200) OUTPUT, @Subject NVARCHAR(500) OUTPUT, @MailContent NVARCHAR(1000) OUTPUT, @SendEmail NVARCHAR(200) OUTPUT, @MailRecvName NVARCHAR(200) OUTPUT, @SeqValue INT OUTPUT',

@Email = @Email OUTPUT, @Subject = @Subject OUTPUT, @MailContent = @MailContent OUTPUT, @SendEmail= @SendEmail OUTPUT, @MailRecvName = @MailRecvName OUTPUT, @SeqValue = @SeqValue OUTPUT

IF @SerlCol \<\> ''

EXEC SP_EXECUTESQL @SQL, N'@Email NVARCHAR(200) OUTPUT, @Subject NVARCHAR(500) OUTPUT, @MailContent NVARCHAR(1000) OUTPUT, @SendEmail NVARCHAR(200) OUTPUT, @MailRecvName NVARCHAR(200) OUTPUT, @SeqValue INT OUTPUT, @SerlValue INT OUTPUT',

@Email = @Email OUTPUT, @Subject = @Subject OUTPUT, @MailContent = @MailContent OUTPUT, @SendEmail= @SendEmail OUTPUT, @MailRecvName = @MailRecvName OUTPUT, @SeqValue = @SeqValue OUTPUT, @SerlValue = @SerlValue OUTPUT

IF @SubSerlCol \<\> ''

EXEC SP_EXECUTESQL @SQL, N'@Email NVARCHAR(200) OUTPUT, @Subject NVARCHAR(500) OUTPUT, @MailContent NVARCHAR(1000) OUTPUT, @SendEmail NVARCHAR(200) OUTPUT, @MailRecvName NVARCHAR(200) OUTPUT, @SeqValue INT OUTPUT, @SerlValue INT OUTPUT, @SubSerlValue INT OUTPUT',

@Email = @Email OUTPUT, @Subject = @Subject OUTPUT, @MailContent = @MailContent OUTPUT, @SendEmail= @SendEmail OUTPUT, @MailRecvName = @MailRecvName OUTPUT, @SeqValue = @SeqValue OUTPUT, @SerlValue = @SerlValue OUTPUT, @SubSerlValue = @SubSerlValue OUTPUT

 

-- MessageType = 4 로 하드코딩 되어있어 변수로 받을 수 있도록 수정 2021.05.21 mjjang

DECLARE @MessageType INT

 

SELECT @MessageType = ISNULL(MessageType, 4)

FROM OTCAOnlineViewer WITH(NOLOCK)

WHERE CompanySeq = @CompanySeq

AND ViewerId = @ViewerID

 

SELECT @MailContent = REPLACE(@MailContent, CHAR(13) + CHAR(10), '\<br/\>')

> SELECT @MailContent = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(SecuMessage, '##MailContent##', @MailContent), '##Subject##', @Subject), '##MailName##', @MailTitle), '##MailSendCompanyName##', @SendTitle), '##MailRecvCompanyName##', @MailRecvName)

FROM \_TCASecuMessageTemplate WITH(NOLOCK)

WHERE CompanySeq = @CompanySeq

AND LanguageSeq = @LanguageSeq

AND MessageType = @MessageType

--AND MessageType = 4

SELECT @SQL = 'SELECT @XmlDocument = ''\<ROOT\>'' + (SELECT A.\*' + CHAR(13)

SELECT @SQL = @SQL + ' FROM ' + @TempTableName + ' AS A' + CHAR(13)

SELECT @SQL = @SQL + ' JOIN \#TCOMOnlineViewerData AS B ON B.STDSeq = A.' + @SeqCol + CHAR(13)

IF @SerlCol \<\> ''

SELECT @SQL = @SQL + ' AND B.STDSerl = A.' + @SerlCol + CHAR(13)

IF @SubSerlCol \<\> ''

SELECT @SQL = @SQL + ' AND B.STDSubSerl = A.' + @SubSerlCol + CHAR(13)

SELECT @SQL = @SQL + ' WHERE B.IDOrder = ' + CONVERT(NVARCHAR(10), @Cnt) + CHAR(13)

SELECT @SQL = @SQL + ' ORDER BY A.IDX_NO ' + CHAR(13) -- 240415 hcwoo

SELECT @SQL = @SQL + ' FOR XML AUTO) + ''\</ROOT\>'''

--PRINT @SQL

EXEC SP_EXECUTESQL @SQL, N'@XmlDocument XML OUTPUT', @XmlDocument = @XmlDocument OUTPUT

 

IF @XmlDocument IS NULL BREAK

EXEC @Seq = dbo.\_SWCOMCreateSeq @CompanySeq, '\_TCOMOnlineViewerData', 'ViewerValue', 1

INSERT INTO \_TCOMOnlineViewerData (CompanySeq , SendDateKey , ViewerID , ViewerValue , Email ,

Seq , Serl , SubSerl , ClickCount , IsConfirm ,

IsCancel , IsRead , IsRequest , RequestMemo , KeyWord ,

Content , ColumnInfo , PgmSeq , SendUserSeq , SendEmail ,

LastUserSeq , LastDateTime)

SELECT @CompanySeq , @GETDATE , @ViewerID , @Seq + 1 , @Email ,

@SeqValue , @SerlValue , @SubSerlValue , 0 , '0' ,

'0' , '0' , '0' , '' , @KeyWord ,

@XmlDocument, @ColumnInfo , @PgmSeq , @UserSeq , @SendEmail ,

@UserSeq , @GETDATE

 

SELECT @SendMessageID = ISNULL(MAX(SendMessageID), 0)

FROM \_TCASendMessage WITH(NOLOCK)

WHERE CompanySeq = @CompanySeq

 

INSERT INTO \_TCASendMessage (CompanySeq , SendMessageID , SendUserSeq , SendMessageType, Subject ,

SendMessage , RecvUserSeq , IsMemo , IsMail , IsSMS ,

SendMemo , SendMail , MemoDateTime , MailDateTime , SMSDateTime ,

SendSMS , TblKey , CrDateTime , RecvEmail , RecvTelNo ,

LoginPwd , States , Result , EmailPass , AttachMessage ,

AttachFileName , SendEmail , CCEmail , charset , AttachFiles ,

AttachType , AttachConfig , IsProcessing , PgmSeq , ToPgmSeq ,

JumpMode , JumpData , IsFast , MessageGroupSeq, SendTelNo ,

BCCEmail , SendDateKey , ViewerId , ViewerValue , BisDivCode ,

SecuBody )

SELECT @CompanySeq , @SendMessageID + 1, @UserSeq , 4 , @Subject ,

@MailContent , @UserSeq , '0' , '1' , '0' ,

'' , 0 , '' , @GETDATE , '' ,

'' , '' , @GETDATE , @Email , '' ,

'' , '' , '' , '' , '' ,

'' , @SendEmail , '' , 'utf-8' , '' ,

4 , '' , NULL , @PgmSeq , 0 ,

0 , '' , 0 , 0 , '' ,

'' , @GETDATE , @ViewerId , @Seq + 1 , 0 ,

CASE @MailContent WHEN '' THEN NULL ELSE @MailContent END

SELECT @Cnt = @Cnt + 1

 

END

 

RETURN