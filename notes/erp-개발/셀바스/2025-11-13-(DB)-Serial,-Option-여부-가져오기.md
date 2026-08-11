---
title: (DB) Serial, Option 여부 가져오기
date: 2025-11-13
tags: [erp, 개발, 셀바스]
---

# (DB) Serial, Option 여부 가져오기

LEFT OUTER JOIN \_TDAItemClass AS C1 WITH(NOLOCK) ON C1.CompanySeq = B.CompanySeq

AND C1.ItemSeq = B.ItemSeq

AND C1.UMajorItemClass IN (2001, 2004)

LEFT OUTER JOIN svs_TPDSerialBase AS D1 WITH(NOLOCK) ON D1.CompanySeq = C1.CompanySeq

AND D1.UMItemClass = C1.UMItemClass

AND ISNULL(D1.IsNotUse, '') \<\> '1'

LEFT OUTER JOIN svs_TPDSerialExcp AS E1 WITH(NOLOCK) ON E1.CompanySeq = B.CompanySeq

AND E1.ItemSeq = B.ItemSeq

AND ISNULL(E1.IsNotUse, '') \<\> '1'