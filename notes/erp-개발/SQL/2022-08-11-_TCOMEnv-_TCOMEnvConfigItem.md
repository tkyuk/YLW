---
title: \_TCOMEnv / \_TCOMEnvConfigItem
date: 2022-08-11
tags: [erp, 개발, SQL]
---

# \_TCOMEnv / \_TCOMEnvConfigItem

INSERT INTO \_TCOMEnv VALUES(

'1','2000243','품목수량단위','품목수량단위','2','0','84003','10007','0','3','0','1',GETDATE(),'0','','','0','NULL'

)

INSERT INTO \_TCOMEnv VALUES(

'1','2000244','품목길이단위','품목길이단위','2','0','84003','10007','0','3','0','1',GETDATE(),'0','','','0','NULL'

)

select \* from \_TCOMEnv WHERE EnvSeq IN

(

2000243,2000244,2000101,2000102,2000096,2000097,2000099,2000098,2000100,2000092,2000087,2000093,2000084,2000105,2000089,2000088

)

 

 

 

BEGIN TRAN

INSERT INTO \_TCOMEnvConfigItem VALUES('991015','2000243','1',GETDATE())

INSERT INTO \_TCOMEnvConfigItem VALUES('991015','2000244','1',GETDATE())

 

 

select \* from \_TCOMEnvConfigItem where ConfigSeq = 991015

ROLLBACK TRAN