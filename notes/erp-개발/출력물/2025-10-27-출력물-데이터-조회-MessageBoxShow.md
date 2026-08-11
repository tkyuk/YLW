---
title: 출력물 - 데이터 조회 MessageBoxShow
date: 2025-10-27
tags: [erp, 개발, 출력물]
---

# 출력물 - 데이터 조회 MessageBoxShow

\_TraceLn("test1 : " + getMasterKey());

\_TraceLn("test2 : " + This.GetDataSetValue("DataBlock4.ProdReqSeq"));

\_TraceLn("test3 : " + (getMasterKey() != This.GetDataSetValue("DataBlock4.ProdReqSeq")));