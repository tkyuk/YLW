---
title: rollback tran
date: 2022-11-16
tags: [erp, 개발, SQL]
---

# rollback tran

--insert 2개

 

 

IF NOT EXISTS(SELECT TOP 1 1 FROM \_TCOMEnv WHERE 1=1 AND CompanySeq = '1' AND EnvSeq = '2000159' )

BEGIN

INSERT INTO \_TCOMEnv(CompanySeq,EnvSeq,EnvName,Description,EnvValue,ModuleSeq,SMControlType,CodeHelpSeq,MinorSeq,SMUseType,QuerySort,LastUserSeq,LastDateTime,DecLength,AddCheckScript,AddSaveScript,IsUse)

SELECT 1,2000159,'반품단가기준_hsg','반품단가기준','2140216001',0,84003,19999,2140216,7,2000141,1,GETDATE(),0,'','','1'

END

 

 

IF NOT EXISTS(SELECT TOP 1 1 FROM \_TCOMEnvConfigItem WHERE 1=1 AND ConfigSeq = '991012' AND EnvSeq = '2000159' )

BEGIN

INSERT INTO \_TCOMEnvConfigItem(ConfigSeq,EnvSeq,LastUserSeq,LastDateTime)

SELECT 991012,2000159,1,GETDATE()

END

 

-- 그냥 추가

IF NOT EXISTS(SELECT TOP 1 1 FROM \_TCOMEnv WHERE 1=1 AND CompanySeq = '1' AND EnvSeq = '2000180' )

BEGIN

INSERT INTO \_TCOMEnv

VALUES('1','2000180','\[공정품매출\] 디폴트 공정','신선생산입고조회_evc 화면에서 디폴트로 입력되는 공정','0','0','84003','660012','0','7','2000180','27292',getdate(),'0','','','1')

END

 

 

IF NOT EXISTS(SELECT TOP 1 1 FROM \_TCOMEnvConfigItem WHERE 1=1 AND ConfigSeq = '991018' AND EnvSeq = '2000180' )

BEGIN

INSERT INTO \_TCOMEnvConfigItem(ConfigSeq,EnvSeq,LastUserSeq,LastDateTime)

SELECT 991018,2000180,1,GETDATE()

END

 

 

IF NOT EXISTS(SELECT TOP 1 1 FROM \_TCOMEnv WHERE 1=1 AND CompanySeq = '1' AND EnvSeq = '2000181' )

BEGIN

INSERT INTO \_TCOMEnv

VALUES('1','2000181','\[공정품매출\] 디폴트 품목소분류','신선생산입고조회_evc 화면에서 디폴트로 입력되는 품목소분류','0','0','84003','610014','0','7','2000181','27292',getdate(),'0','','','1')

END

 

 

IF NOT EXISTS(SELECT TOP 1 1 FROM \_TCOMEnvConfigItem WHERE 1=1 AND ConfigSeq = '991018' AND EnvSeq = '2000181' )

BEGIN

INSERT INTO \_TCOMEnvConfigItem(ConfigSeq,EnvSeq,LastUserSeq,LastDateTime)

SELECT 991018,2000181,1,GETDATE()

END

 

 

 

 

 

IF NOT EXISTS(SELECT TOP 1 1 FROM \_TCOMEnv WHERE 1=1 AND CompanySeq = '1' AND EnvSeq = '2000182' )

BEGIN

INSERT INTO \_TCOMEnv

VALUES('1','2000182','\[공정품매출\] 디폴트 입고창고','신선생산입고조회_evc 화면에서 디폴트로 입력되는 입고창고','0','0','84003','610006','0','7','2000182','27292',getdate(),'0','','','1')

END

 

 

IF NOT EXISTS(SELECT TOP 1 1 FROM \_TCOMEnvConfigItem WHERE 1=1 AND ConfigSeq = '991018' AND EnvSeq = '2000182' )

BEGIN

INSERT INTO \_TCOMEnvConfigItem(ConfigSeq,EnvSeq,LastUserSeq,LastDateTime)

SELECT 991018,2000182,1,GETDATE()

END

 

 

IF NOT EXISTS(SELECT TOP 1 1 FROM \_TCOMEnv WHERE 1=1 AND CompanySeq = '1' AND EnvSeq = '2000183' )

BEGIN

INSERT INTO \_TCOMEnv

VALUES('1','2000183','\[공정품매출\] 디폴트 부서','신선생산입고조회_evc 화면에서 거래명세서로 점프시 디폴트로 입력되는 부서','0','0','84003','610010','0','7','2000183','27292',getdate(),'0','','','1')

END

 

 

IF NOT EXISTS(SELECT TOP 1 1 FROM \_TCOMEnvConfigItem WHERE 1=1 AND ConfigSeq = '991018' AND EnvSeq = '2000183' )

BEGIN

INSERT INTO \_TCOMEnvConfigItem(ConfigSeq,EnvSeq,LastUserSeq,LastDateTime)

SELECT 991018,2000183,1,GETDATE()

END

 

IF NOT EXISTS(SELECT TOP 1 1 FROM \_TCOMEnv WHERE 1=1 AND CompanySeq = '1' AND EnvSeq = '2000184' )

BEGIN

INSERT INTO \_TCOMEnv

VALUES('1','2000184','\[공정품매출\] 디폴트 거래처','신선생산입고조회_evc 화면에서 거래명세서로 점프시 디폴트로 입력되는 거래처','0','0','84003','617001','0','7','2000184','27292',getdate(),'0','','','1')

END

 

 

IF NOT EXISTS(SELECT TOP 1 1 FROM \_TCOMEnvConfigItem WHERE 1=1 AND ConfigSeq = '991018' AND EnvSeq = '2000184' )

BEGIN

INSERT INTO \_TCOMEnvConfigItem(ConfigSeq,EnvSeq,LastUserSeq,LastDateTime)

SELECT 991018,2000184,1,GETDATE()

END