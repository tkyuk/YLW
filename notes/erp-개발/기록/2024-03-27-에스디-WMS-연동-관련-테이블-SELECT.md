---
title: 에스디 WMS 연동 관련 테이블 SELECT
date: 2024-03-27
tags: [erp, 개발, 기록]
---

# 에스디 WMS 연동 관련 테이블 SELECT

SELECT \* FROM \_TLGInOutReq WHERE ReqSeq = 25537

 

 

SELECT Qty,\* FROM \_TLGInOutReqItem WHERE ReqSeq = 25537 AND ReqSerl = 1

SELECT Qty,\* FROM \_TLGInOutReqItem WHERE ReqSeq = 25418 AND ReqSerl = 1

 

 

 

SELECT Qty,IsWorkingTag,\* FROM SD_TLGInItemReqWH_IF WHERE ReqSeq = 25537 AND ReqSerl = 1 -- 입고예정

SELECT Qty,IsWorkingTag,\* FROM SD_TLGOutItemReqWH_IF WHERE ReqSeq = 25537 AND ReqSerl = 1 -- 출고예정

SELECT Qty,IsWorkingTag,\* FROM SD_TLGInItemReqWH_IF WHERE ReqSeq = 25418 AND ReqSerl = 1 -- 입고예정

SELECT Qty,IsWorkingTag,\* FROM SD_TLGOutItemReqWH_IF WHERE ReqSeq = 25418 AND ReqSerl = 1 -- 출고예정

 

SELECT TOP 500 RegDateTime,IsWorkingTag,Qty,\* FROM SD_TLGInItemReqWH_IF WHERE InReqTypeName = '창고이동(제상품)' ORDER BY 1 DESC

SELECT TOP 500 RegDateTime,IsWorkingTag,Qty,\* FROM SD_TLGOutItemReqWH_IF WHERE OutReqTypeName = '창고이동(제상품)' ORDER BY 1 DESC

 

 

 

SELECT RegDateTime,Qty,\* FROM SD_TLGInItemReqWH_IF WHERE IsWorkingTag ='U' AND InReqTypeName = '창고이동(제상품)' ORDER BY 1 DESC

 

SELECT RegDateTime,Qty,\* FROM SD_TLGOutItemReqWH_IF WHERE IsWorkingTag ='U' AND OutReqTypeName = '창고이동(제상품)' ORDER BY 1 DESC

 

 

 

SELECT Qty,IsWorkingTag,\* FROM SD_TLGInItemReqWH_IF WHERE ReqSeq = 25537 AND ReqSerl = 1 -- 입고예정

SELECT Qty,IsWorkingTag,\* FROM SD_TLGOutItemReqWH_IF WHERE ReqSeq = 25537 AND ReqSerl = 1 -- 출고예정

SELECT Qty,InSeq ,\* FROM SD_TLGInItemWH_IF WHERE ReqSeq = 25537 AND ReqSerl = 1 -- 입고예정 16644

SELECT Qty,OutSeq,\* FROM SD_TLGOutItemWH_IF WHERE ReqSeq = 25537 AND ReqSerl = 1 -- 출고예정 16651

SELECT Qty,InSeq ,\* FROM SD_TLGInItemWH_IF WHERE ReqSeq = 25418 AND ReqSerl = 1 -- 입고예정 16466

SELECT Qty,OutSeq,\* FROM SD_TLGOutItemWH_IF WHERE ReqSeq = 25418 AND ReqSerl = 1 -- 출고예정 16461

 

 

SELECT \* FROM \_TLGInOutDailyItem WHERE InOutType = 80 AND InOutSeq = 16644

SELECT \* FROM \_TLGInOutDailyItem WHERE InOutType = 80 AND InOutSeq = 16651

SELECT \* FROM \_TLGInOutDailyItem WHERE InOutType = 80 AND InOutSeq = 16813

SELECT \* FROM \_TLGInOutDailyItem WHERE InOutType = 80 AND InOutSeq = 16811

 

EXEC \_SWCOMGetTableLog '\_TLGInOutDailyItem', 1, 'InOutSeq', 16644

EXEC \_SWCOMGetTableLog '\_TLGInOutDailyItem', 1, 'InOutSeq', 16461

 

 

 

SELECT TOP 100 A.\*

FROM SD_TLGOutItemWH_IF AS A

LEFT OUTER JOIN \_TLGInOutDailyItem AS B ON B.InOutSeq = A.OutSeq

AND B.InOutType = 80

WHERE A.OutSeq \<\> 0

AND B.CompanySeq IS NULL

AND A.OutReqTypeName = '창고이동(제상품)'

ORDER BY A.ProcDateTime DESC

 

 

 

SELECT SUM(Qty) FROM \_TLGInOutReqItem WHERE ReqSeq = 25537

 

SELECT Qty,IsWorkingTag,\* FROM SD_TLGInItemReqWH_IF WHERE ReqSeq = 25537 AND ReqSerl = 1 -- 입고예정

SELECT Qty,IsWorkingTag,\* FROM SD_TLGOutItemReqWH_IF WHERE ReqSeq = 25537 AND ReqSerl = 1 -- 출고예정

SELECT SUM(Qty),InSeq FROM SD_TLGInItemWH_IF WHERE ReqSeq = 25537 GROUP BY InSeq-- 입고처리

SELECT SUM(Qty),OutSeq FROM SD_TLGOutItemWH_IF WHERE ReqSeq = 25537 GROUP BY OutSeq-- 출고처리

 

 

SELECT SUM(Qty),InOutSeq FROM \_TLGInOutDailyItem WHERE InOutType = 80 AND InOutSeq = 16813 GROUP BY InOutSeq

SELECT SUM(Qty),InOutSeq FROM \_TLGInOutDailyItem WHERE InOutType = 80 AND InOutSeq = 16811 GROUP BY InOutSeq

 

 

--=================================================

SELECT \* FROM \_TLGInOutReq WHERE ReqSeq = 24955

SELECT \* FROM \_TLGInOutReqItem WHERE ReqSeq = 24955

SELECT SUM(Qty) FROM \_TLGInOutReqItem WHERE ReqSeq = 24955

 

SELECT Qty,IsWorkingTag,\* FROM SD_TLGInItemReqWH_IF WHERE ReqSeq = 24955 AND ReqSerl = 1 -- 입고예정

SELECT Qty,IsWorkingTag,\* FROM SD_TLGOutItemReqWH_IF WHERE ReqSeq = 24955 AND ReqSerl = 1 -- 출고예정

SELECT \* FROM SD_TLGInItemWH_IF WHERE ReqSeq = 24955 --GROUP BY InSeq-- 입고처리

SELECT \* FROM SD_TLGOutItemWH_IF WHERE ReqSeq = 24955 --GROUP BY OutSeq-- 출고처리

 

/\*

입고, 출고 예정 둘다 있는건 SD_SSI_WMS_InDailyRecv

입고, 출고 처리 둘다 있는건 SD_SSI_WMS_InDailyRecv

=\> (입고)창고 -\> (출고)물류센터 ==\> 입고를 생성안함 / 출고만 있다

 

 

 

입고, 예정만 있는건

입고, 처리만 있는건

 

입고 =\> 입고창고가 물류센터인 건만 담기 SD_WMS_WCS_BATCH

출고 =\> 출고창고가 물류센터인 건만 담기 SD_WMS_WCS_BATCH

 

 

예상 - 입고창고가 물류센터인 건 (41,42)

\*/

 

SELECT \*

FROM SD_TLGInItemReqWH_IF AS A

JOIN \_TLGInOutReq AS B ON B.ReqSeq = A.ReqSeq

JOIN SD_TLGInItemWH_IF AS C ON C.ReqSeq = A.ReqSeq

WHERE B.OutWHSeq NOT IN (41,42)

AND A.InReqType = 700002008

AND C.InType = 80

AND C.InSeq \<\> 0

 

 

 

SELECT Qty,IsWorkingTag,\* FROM SD_TLGInItemReqWH_IF WHERE ReqSeq = 24986 -- 입고예정

SELECT Qty,IsWorkingTag,\* FROM SD_TLGOutItemReqWH_IF WHERE ReqSeq = 24986 -- 출고예정

 

SELECT \* FROM SD_TLGInItemWH_IF WHERE ReqSeq = 24986 --GROUP BY InSeq-- 입고처리

SELECT \* FROM SD_TLGOutItemWH_IF WHERE ReqSeq = 24986 --GROUP BY OutSeq-- 출고처리