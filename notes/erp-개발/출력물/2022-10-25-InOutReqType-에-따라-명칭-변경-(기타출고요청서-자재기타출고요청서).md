---
title: InOutReqType 에 따라 명칭 변경 (기타출고요청서 / 자재기타출고요청서)
date: 2022-10-25
tags: [erp, 개발, 출력물]
---

# InOutReqType 에 따라 명칭 변경 (기타출고요청서 / 자재기타출고요청서)

// OnBlind

var InOutReqType = This.GetDataSetValue("DataBlock1.InOutReqType");

if(InOutReqType == 31)

This.SetText("자재기타출고요청서")

else

This.SetText("기타출고요청서")