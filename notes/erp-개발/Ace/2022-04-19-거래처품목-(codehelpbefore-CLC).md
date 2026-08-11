---
title: 거래처품목 (codehelpbefore / CLC)
date: 2022-04-19
tags: [erp, 개발, Ace]
---

# 거래처품목 (codehelpbefore / CLC)

> CodeHelpBefore 참고화면 – 수주입력, 거래처별판매단가등록_mcnk
>
> ItemChg (CLC 해주기) - 거래처별판매단가등록_mcnk
>
>  

1.  코드도움 등록(2014) - 코드도움 SP명 확인

> ![](assets/거래처품목-(codehelpbefore-CLC)/image94.png)
>
>  
>
> 2\. SP실행 – 키 값의 파리미터 순서 확인
>
> ex.
>
> 키 – CustSeq
>
> 순서 - 1
>
> ![](assets/거래처품목-(codehelpbefore-CLC)/image95.png)
>
>  
>
> 3\. 개발툴 – Event - ‘CodeHelpBefore' - 메소드 추가 (ex. CustItemBefore)
>
> 표준-수주입력에도 나와있음
>
>  
>
> SS1.ColumnCodeHelpParams = toString(txtCustName.Value)..'\|\|\|'
>
> txtActColName.Text = 'ItemName'
>
> ![](assets/거래처품목-(codehelpbefore-CLC)/image96.png)
>
>  
>
> 거래처품목명, 거래처품목번호 둘다 추가 해야함
>
> ![](assets/거래처품목-(codehelpbefore-CLC)/image97.png)
>
>  
>
>  
>
> ![](assets/거래처품목-(codehelpbefore-CLC)/image98.png)
>
>  
>
>  
>
>  
>
>  
>
>  
>
>  
>
>  
>
>  
>
>  
>
>  
>
>  
>
>  
>
>  
>
>  
>
> 4\. (거래처품목, 거래처품목번호) 삭제하면 (품명,품번,규격) 같이 지워지지만
>
> (품명,품번,규격) 지울 시 (거래처품목, 거래처품목번호) 는 유지됨
>
> =\> 메소드 추가 (ItemChg)
>
> SetText(SS2, SS2.ActiveRow, 'CustItemName','')
>
> SetText(SS2, SS2.ActiveRow, 'CustItemNo','’)
>
>  
>
> 품목, 품번, 규격 Event – Changed에 추가
>
> ![](assets/거래처품목-(codehelpbefore-CLC)/image99.png)
>
>  
>
>  
>
>  
>
> +. 거래처품목명칭관리 화면
>
> ex.
>
> erp에 있는 품목 ‘알박머터리얼즈-생산제품_umk-본딩’를
>
> 거래처에서는 ‘TEST’ 라고 부른다
>
> ![](assets/거래처품목-(codehelpbefore-CLC)/image100.png)
>
>  
>
>  
>
>  
>
>  
>
>  
>
>  
>
>  
>
>  
>
>  
>
>  
>
>  
>
>  
>
> 조회 sp 수정
>
> \_SWSLOrderItemQuery 참고