---
title: (BIGINT) int 열이 오버플로되었습니다.
date: 2023-05-11
tags: [erp, 개발, SQL]
---

# (BIGINT) int 열이 오버플로되었습니다.

varchar 값 '202304300001'을(를) 변환하는 중 int 열이 오버플로되었습니다.

 

\- 2147483648 ~ 2147483647 (int형의 범위)

=\> BIGINT 사용

 

@start + 1 =\>  convert(bigint, @start) + 1

 

BIGINT 최대값 9223372036854775807

 

 

출처: \<<https://nejooso.com/1491>\>