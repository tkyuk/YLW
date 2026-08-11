---
title: There is no position 0 (점프 시 오류)
date: 2023-10-13
tags: [erp, 개발, GNI]
---

# There is no position 0 (점프 시 오류)

내역 : 수입BL품목현황 또는 수입BL등록에서 수입비용입력으로 BLNo SWS-20231003-001를 점프 시 There is no position 0 이라는 오류가 발생합니다.

 

결과 :

확인해보니 수입비용입력 마스터테이블 : TUGImpCost 에만 데이터가 존재하고, 시트의 데이터는 없는 상태였습니다.

예상해보면 시트 컷으로 시트만 삭제하다 보니, 등록된 건 기준으로 조회를 할 때 시트에 뿌릴 데이터 대상이 없어서

"There is no position 0 " 문구가 발생 되었습니다.

 

가비지데이터인 TUGImpCost  데이터 지우고 점프하면 초기 입력 가능한 형태로 조회 됩니다.

수입비용처리 다시 할 수 있도록 사용자에게 설명 부탁드립니다.