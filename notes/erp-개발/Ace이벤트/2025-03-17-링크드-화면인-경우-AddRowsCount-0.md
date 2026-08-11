---
title: 링크드 화면인 경우 AddRowsCount 0
date: 2025-03-17
tags: [erp, 개발, Ace이벤트]
---

# 링크드 화면인 경우 AddRowsCount 0

LinkPgm = \_base.LinkCreateID

>  

 

if LinkPgm ~= '' then

> SS1.IsmenuRowInsertVisible = false
>
> SS1.AddRowsCount = 0                                        
>
> ClearForm('SS1', '')

end