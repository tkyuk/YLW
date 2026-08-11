---
title: merge (같은 제품이어도 구분값에 따라 나뉘어서 merge)
date: 2023-01-18
tags: [erp, 개발, Ace이벤트]
---

# merge (같은 제품이어도 구분값에 따라 나뉘어서 merge)

![](assets/merge-(같은-제품이어도-구분값에-따라-나뉘어서-merge)/image64.png)

![](assets/merge-(같은-제품이어도-구분값에-따라-나뉘어서-merge)/image65.png)

 

- 키값을 앞에 두면 자동으로 뒤에부터 나뉘어짐

![](assets/merge-(같은-제품이어도-구분값에-따라-나뉘어서-merge)/image66.png)

 

멀티헤더 및 머지설정으로 해도 안되면

Queyr 메소드 맨 밑에 루아 추가

SS1.MergeColumns = '{GoodItemSeq,1},{UMCompositionType,1},{GoodItemName,1},{GoodItemNo,1},{UMCompositionTypeName,1}'