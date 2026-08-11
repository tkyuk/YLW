---
title: DATABLOCK 컬럼 복사 / SQL 실행 후 데이터 신규 컬럼 복사 생성
date: 2024-03-20
tags: [erp, 개발, Ace이벤트]
---

# DATABLOCK 컬럼 복사 / SQL 실행 후 데이터 신규 컬럼 복사 생성

-- <span class="mark">DataBlock 복사</span> 1 -\> 2

CopyDataBlock(m_SendXml.Data, 'DataBlock1', 'DataBlock2')

-- LotNo -\> OriLotNo <span class="mark">명칭 변경</span>

 

ChangeDataFieldName(m_SendXml.Data, 'DataBlock2', 'StkQty', 'Qty')

ChangeDataFieldName(m_SendXml.Data, 'DataBlock2', 'LotNo', 'OriLotNo')

 

SetDataColFill(m_SendXml, 'DataBlock1', 'PJTSeq', txtPJTSeq.TextCd)

SetDataColFill(m_SendXml, 'DataBlock1', 'PJTName', txtPJTSeq.Text)

SetDataColFill(m_SendXml, 'DataBlock1', 'PJTNo', txtPJTNo.Text)

 

<span class="mark">-- 점프인 화면에 추가</span>

 

\_base.IsOpen = false

 

for row = 0, SS1.DataRowCnt - 1 do

> SetText(SS1, row, 'STDUnitName', CellText(SS1, row, 'UnitName'))
>
> SetText(SS1, row, 'STDUnitSeq', tonumber(CellText(SS1, row, 'UnitSeq')))
>
> SetText(SS1, row, 'STDQty', tonumber(CellText(SS1, row, 'Qty')))        

end

 

SetDataColFill(m_RecvXml, 'DataBlock2', 'Remark2', '')

 

for row = 0, GetDataBlock(m_RecvXml.Data, 'DataBlock2').Rows.Count - 1 do

SetDataSetValue(m_RecvXml.Data, 'DataBlock2', 'Remark2', row, GetDataSetObject(m_RecvXml.Data, 'DataBlock2', 'Remark1', row).Value)

end