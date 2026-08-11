---
title: 입력행 기준 밑에 행 WorkingTag 변경
date: 2024-05-22
tags: [erp, 개발, Ace이벤트]
---

# 입력행 기준 밑에 행 WorkingTag 변경

local i, YM, PreRemainQty,RemainQty

 

YM = tonumber(string.sub(CellText(SS1, SS1.ActiveRow, 'YM'), 5, 6))

PreRemainQty = fltPreRemainQty.Value

RemainQty = 0

 

for row = 0, SS1.DataRowCnt -1 do

> SS1.ActiveColumnName = 'RemainQty'
>
> SS1.ActiveRow = row
>
> if row == 0 then
>
> RemainQty = tonumber(PreRemainQty) - tonumber(CellText(SS1, SS1.ActiveRow, 'PUQty'))
>
> else
>
> RemainQty = tonumber(CellText(SS1, SS1.ActiveRow-1, 'RemainQty')) - tonumber(CellText(SS1, SS1.ActiveRow, 'PUQty'))
>
> end                
>
> SetText(SS1, SS1.ActiveRow, 'RemainQty', RemainQty)
>
> if row +1 \> YM then
>
> if SS1.WorkingTag ~= 'A' then -- A가 아닌 경우 U로 변경 (A는 바뀌어도 A이기 때문)
>
> SS1.WorkingTag = 'U'
>
> end
>
> end

end