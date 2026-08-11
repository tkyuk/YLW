---
title: string -\> yy-mm-dd 자바스크립트
date: 2022-10-04
tags: [erp, 개발, 출력물]
---

# string -\> yy-mm-dd 자바스크립트

// OnBind

var currData = This.GetDataSetValue("DataBlock1.DelvDate");

var newText = \_FormatDate( \_ParseDate(currData, "yyyyMMdd"), "yyyy-MM-dd");

This.SetText(newText);

 

 

 

 

var currData = This.GetDataSetValue("DataBlock1.DelvDate");

var newText = \_FormatDate( \_ParseDate(currData, "yyyyMMdd"), "yyyy년 MM월 dd일");

This.SetText(newText);

 

 

 

This.SetText(This.GetDataSetValue("DataBlock1.DVDate").substring(0,4) + "-"

\+ This.GetDataSetValue("DataBlock1.DVDate").substring(6,4) + "-"

\+ This.GetDataSetValue("DataBlock1.DVDate").substring(8,6));