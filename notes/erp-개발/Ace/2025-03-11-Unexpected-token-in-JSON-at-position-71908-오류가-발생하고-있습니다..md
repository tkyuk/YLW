---
title: Unexpected token in JSON at position 71908 오류가 발생하고 있습니다.
date: 2025-03-11
tags: [erp, 개발, Ace]
---

# Unexpected token in JSON at position 71908 오류가 발생하고 있습니다.

**Unexpected token 오류**

**문제 상황**

"Unexpected token in JSON at position 71908 오류가 발생하고 있습니다." 메시지가 발생합니다.

 

 

**원인**

해당 오류는 조회하는 데이터에 JSON에서 허용하지 않는 특수 문자를 포함하고 있어 JSON으로 변환 시 발생하는 오류입니다.

 

 

**해결 방안**

조회 시 프로파일러로 실행문을 잡아 테이블 데이터에 문제가 되는 특수 문자가 있다면 해당 문자를 제거합니다.

위 방법으로 원인을 파악하기 어려운 경우, 다음 실행문을 활용하여 문제가 되는 문자를 찾을 수 있습니다.

 

 

--실행문 예시

select CfmItem, SUBSTRING(CfmItem, 14, 1), CONVERT(VARBINARY, SUBSTRING(CfmItem, 14, 1))

, SUBSTRING(CfmItem, 5, 1), CONVERT(VARBINARY, SUBSTRING(CfmItem, 5, 1))

FROM \_TFPSLShoppingMallOrder WITH(NOLOCK)

WHERE MallOrderNo = '736278'select CfmItem, SUBSTRING(CfmItem, 14, 1), CONVERT(VARBINARY, SUBSTRING(CfmItem, 14, 1))

, SUBSTRING(CfmItem, 5, 1), CONVERT(VARBINARY, SUBSTRING(CfmItem, 5, 1))

FROM \_TFPSLShoppingMallOrder WITH(NOLOCK)

WHERE MallOrderNo = '736279'

 

 

예시

![](assets/Unexpected-token-in-JSON-at-position-71908-오류가-발생하고-있습니다/image183.png)

위 데이터의 경우 공백 문자에 다른 값이 들어가 있습니다.

정상적인 공백의 경우 0x2000 값으로 출력되어야 합니다. -\> 문제가 되는 문자: 0x1D00

 

출처: \<<https://kdc.ksystem.co.kr/developments/erpops/M1736731785188>\>