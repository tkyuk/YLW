---
title: \<\<FrmSASalesOrder_02_sjpark - 복사본.aspx\>\>
date: 2022-03-03
tags: [erp, 개발, GNI]
---

# \<\<FrmSASalesOrder_02_sjpark - 복사본.aspx\>\>

\<%@ Register TagPrefix="cc1" Namespace="Ylw.Common" Assembly="Ylw.Common.Controls" %\>

\<%@ Page language="c#" Codebehind="FrmSASalesOrder_02_sjpark.aspx.cs" AutoEventWireup="false" Inherits="sjpark.Sales.FrmSASalesOrder_02_sjpark" %\>

\<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" \>

\<HTML\>

> \<HEAD\>
>
> \<title\>WebForm1\</title\>
>
> \<meta content="True" name="vs_snapToGrid"\>
>
> \<meta content="True" name="vs_showGrid"\>
>
> \<meta content="Microsoft Visual Studio 7.0" name="GENERATOR"\>
>
> \<meta content="C#" name="CODE_LANGUAGE"\>
>
> \<meta content="VBScript" name="vs_defaultClientScript"\>
>
> \<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema"\>
>
> \<LINK href="../../../Common/Css/base.css" type="text/css" rel="stylesheet"\>
>
> \</HEAD\>
>
> \<body MS_POSITIONING="GridLayout"\>
>
> \<form id="Form1" name="Form1" method="post" runat="server"\>
>
> \<DIV id="DIV_content" style="Z-INDEX: 100; POSITION: absolute; WIDTH: 1106px; HEIGHT: 584px; TOP: 8px; LEFT: 8px"
>
> MS_POSITIONING="GridLayout"\>\<cc1:kedittext id="txtRemark" style="Z-INDEX: 106; POSITION: absolute; TOP: 141px; LEFT: 416px"
>
> tabIndex="17" runat="server" DicCode="Remark" Caption="비고" TextMode="MultiLine" BackColor="Transparent" BorderColor="MediumBlue"
>
> BorderWidth="0px" maxlength="200" DefautValue="" CaptionWidth="70" name="txtRemark" ControlKey="" Width="370px" Height="51px"\>\</cc1:kedittext\>\<cc1:khtmlbutton id="cmdWhNm" style="Z-INDEX: 135; POSITION: absolute; TOP: 233px; LEFT: 816px" tabIndex="26"
>
> runat="server" DicCode="Command1_1964" name="cmdWhNm" Width="169px" Height="23px" Text="창고일괄" Visible="False"\>\</cc1:khtmlbutton\>\<cc1:khtmlbutton id="cmdRev" style="Z-INDEX: 136; POSITION: absolute; TOP: 21px; LEFT: 859px" tabIndex="5"
>
> runat="server" DicCode="AmdReg" name="cmdRev" Width="60" Height="23px" Text="Amd등록"\>\</cc1:khtmlbutton\>\<cc1:khtmlbutton id="cmdAmdQ" style="Z-INDEX: 142; POSITION: absolute; TOP: 21px; LEFT: 921px" tabIndex="6"
>
> runat="server" DicCode="AmdInq..." name="cmdAmdQ" Width="60px" Height="23px" Text="Amd조회..."\>\</cc1:khtmlbutton\>\<cc1:keditoption id="optExpClss" style="Z-INDEX: 108; POSITION: absolute; TOP: 216px; LEFT: 416px"
>
> tabIndex="24" runat="server" DicCode="" Caption="" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="10" DefautValue="" CaptionWidth="0" name="optExpClss" ControlKey="" Width="368px"
>
> Height="32px" DesignItemCnt="3" RepeatColumns="3" DefaultValue="0" RepeatLayout="Flow" RepeatDirection="Horizontal"\>\</cc1:keditoption\>\<cc1:khtmlbutton id="cmdPay" style="Z-INDEX: 141; POSITION: absolute; TOP: 130px; LEFT: 16px" tabIndex="15"
>
> runat="server" DicCode="PayCond..." name="cmdPay" Width="168px" Height="23px" Text="지불조건..."\>\</cc1:khtmlbutton\>\<cc1:khtmlbutton id="cmdStockList" style="Z-INDEX: 140; POSITION: absolute; TOP: 155px; LEFT: 816px"
>
> tabIndex="20" runat="server" DicCode="ItemClassifyStkStat..." name="cmdStockList" Width="169px" Height="23px" Text="품목별재고현황..."\>\</cc1:khtmlbutton\>\<cc1:khtmlbutton id="cmdEstProfit" style="Z-INDEX: 139; POSITION: absolute; TOP: 179px; LEFT: 816px"
>
> tabIndex="21" runat="server" DicCode="ExpProfit..." name="cmdEstProfit" Width="169px" Height="23px" Text="예상이익..."\>\</cc1:khtmlbutton\>\<cc1:khtmlbutton id="cmdChkAvailStock" style="Z-INDEX: 138; POSITION: absolute; TOP: 131px; LEFT: 816px"
>
> tabIndex="18" runat="server" DicCode="AvailStk" name="cmdChkAvailStock" Width="81" Height="23px" Text="가용재고"\>\</cc1:khtmlbutton\>\<cc1:khtmlbutton id="cmdPriceChange" style="Z-INDEX: 137; POSITION: absolute; TOP: 131px; LEFT: 904px"
>
> tabIndex="19" runat="server" DicCode="PriceApply" name="cmdPriceChange" Width="81px" Height="23px" Text="단가적용"\>\</cc1:khtmlbutton\>\<cc1:ksheet id="ylwsh" style="Z-INDEX: 112; POSITION: absolute; TOP: 349px; LEFT: 0px" tabIndex="30"
>
> runat="server" DicCode="" Width="1001px" Height="235px" IsSaveToFileDataOnly="False"\>\</cc1:ksheet\>\<cc1:kedittext id="txtRev" style="Z-INDEX: 123; POSITION: absolute; TOP: 8px; LEFT: 816px" runat="server"
>
> DicCode="" Caption="Amd" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="2" DefautValue="" CaptionWidth="29" name="txtRev" ControlKey="DIS" Width="40px" Height="21px"
>
> TabKeyIndex="0"\>\</cc1:kedittext\>\<cc1:keditcheck id="ChkFixYn" style="Z-INDEX: 113; POSITION: absolute; TOP: 104px; LEFT: 712px"
>
> tabIndex="14" runat="server" DicCode="Conf" Caption="확정" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="10"
>
> DefautValue="" CaptionWidth="57" name="ChkFixYn" ControlKey="QRY;" Width="74px" Height="18px"\>\</cc1:keditcheck\>\<cc1:keditcheck id="chkShortAmtYn" style="Z-INDEX: 129; POSITION: absolute; TOP: 136px; LEFT: 616px"
>
> runat="server" DicCode="AmtShort" Caption="금액미달" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="10" DefautValue="" CaptionWidth="57" name="chkShortAmtYn" Width="192px" Height="18px"\>\</cc1:keditcheck\>\<cc1:keditcombo id="cmbProgressType" style="Z-INDEX: 115; POSITION: absolute; TOP: 48px; LEFT: 816px"
>
> tabIndex="11" runat="server" DicCode="ProgStat" Caption="진행현황" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="1" DefautValue="" CaptionWidth="57" name="cmbProgressType" ControlKey="DIS;" Width="168px" Height="21px" TabKeyIndex="0"\>\</cc1:keditcombo\>\<cc1:keditfloat id="fltTotTaxAmt" style="Z-INDEX: 125; POSITION: absolute; TOP: 264px; LEFT: 216px"
>
> runat="server" DicCode="AddTaxTot" Caption="부가세계" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="25" DefautValue="" CaptionWidth="57" name="fltTotTaxAmt" ControlKey="DIS;" Width="169px" Height="21px" TabKeyIndex="0" declength="0"\>\</cc1:keditfloat\>\<cc1:keditcheck id="chkCredit" style="Z-INDEX: 117; POSITION: absolute; TOP: 136px; LEFT: 528px"
>
> runat="server" DicCode="CreditExcess" Caption="여신초과" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="10" DefautValue="" CaptionWidth="86" name="chkCredit" Width="73px" Height="16px"\>\</cc1:keditcheck\>\<cc1:kedittext id="txtCurrNm" style="Z-INDEX: 130; POSITION: absolute; TOP: 264px; LEFT: 816px"
>
> tabIndex="28" runat="server" DicCode="CurrName" Caption="화폐" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="20" DefautValue="" CaptionWidth="34" name="txtCurrNm" ControlKey="DIC;NON;" Width="65px" Height="21px"\>\</cc1:kedittext\>\<cc1:keditfloat id="fltTotSupplyAmt" style="Z-INDEX: 119; POSITION: absolute; TOP: 264px; LEFT: 16px"
>
> runat="server" DicCode="SellPriceAmtTot" Caption="판매가액계" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="25" DefautValue="" CaptionWidth="100" name="fltTotSupplyAmt" ControlKey="DIS;" Width="171" Height="21px" TabKeyIndex="0" declength="0"\>\</cc1:keditfloat\>\<cc1:keditfloat id="fltTotalAmt" style="Z-INDEX: 127; POSITION: absolute; TOP: 264px; LEFT: 416px"
>
> runat="server" DicCode="OutActTot" Caption="총액" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="25" DefautValue="" CaptionWidth="34" name="fltTotalAmt" ControlKey="DIS;" Width="172" Height="21px" TabKeyIndex="0" declength="0"\>\</cc1:keditfloat\>\<cc1:keditcombo id="cmbOrderType" style="Z-INDEX: 100; POSITION: absolute; TOP: 48px; LEFT: 617px"
>
> tabIndex="10" runat="server" DicCode="OrdDiv" Caption="주문구분" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="8" DefautValue="" CaptionWidth="57" name="cmbOrderType" ControlKey="" Width="169" Height="21px"\>\</cc1:keditcombo\>\<cc1:kedittext id="txtFixEmpNo" style="Z-INDEX: 102; POSITION: absolute; TOP: 88px; LEFT: 617px"
>
> tabIndex="16" runat="server" DicCode="FixEmpNo" Caption="확정자" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="30" DefautValue="" CaptionWidth="70" name="txtFixEmpNo" ControlKey="DIS;" Width="80px" Height="20px" TabKeyIndex="0"\>\</cc1:kedittext\>\<cc1:keditfloat id="fltExRate" style="Z-INDEX: 103; POSITION: absolute; TOP: 264px; LEFT: 888px"
>
> tabIndex="29" runat="server" DicCode="ExcRate" Caption="환율" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="25" DefautValue="" CaptionWidth="34" name="fltExRate" ControlKey="DIC;NON;" Width="96px" Height="21px" declength="0"\>\</cc1:keditfloat\>\<cc1:kedittext id="txtGiveCond" style="Z-INDEX: 105; POSITION: absolute; TOP: 219px; LEFT: 16px"
>
> tabIndex="23" runat="server" DicCode="GiveCond" Caption="인도조건" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="100" DefautValue="" CaptionWidth="70" name="txtGiveCond" ControlKey="" Width="368px" Height="24px"\>\</cc1:kedittext\>\<cc1:keditfloat id="fltDCRate" style="Z-INDEX: 111; POSITION: absolute; TOP: 264px; LEFT: 616px"
>
> tabIndex="27" runat="server" DicCode="DCRate" Caption="할인율" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="11" DefautValue="" CaptionWidth="46" name="fltDCRate" ControlKey="" Width="147" Height="21px" declength="1"\>\</cc1:keditfloat\>\<cc1:keditcombo id="cmbStkCenter" style="Z-INDEX: 114; POSITION: absolute; TOP: 304px; LEFT: 616px"
>
> tabIndex="32" runat="server" DicCode="StkCenter" Caption="물류센터" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="2" DefautValue="" CaptionWidth="57" name="cmbWhNm" ControlKey="QRY;" Width="176px" Height="21px"\>\</cc1:keditcombo\>\<cc1:keditdate id="datOrderDt" style="Z-INDEX: 116; POSITION: absolute; TOP: 8px; LEFT: 216px"
>
> tabIndex="2" runat="server" DicCode="ReceiveOrdDate" Caption="주문일" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="10" DefautValue="YiMiDi" CaptionWidth="80" name="datOrderDt" ControlKey="NON;" Width="72" Height="21px" DefaultValue="YiMiDi" DateType="YMD"\>\</cc1:keditdate\>\<cc1:keditcombo id="cmbAccUnit" style="Z-INDEX: 118; POSITION: absolute; TOP: 8px; LEFT: 16px" tabIndex="1"
>
> runat="server" DicCode="AccUnit_01" Caption="사업장" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="2" DefautValue="" CaptionWidth="70" name="cmbAccUnit" ControlKey="NON;" Width="168px" Height="21px"\>\</cc1:keditcombo\>\<cc1:kedittext id="txtOrderNo" style="Z-INDEX: 120; POSITION: absolute; TOP: 8px; LEFT: 296px"
>
> runat="server" DicCode="ReceiveOrdNo" Caption="주문번호" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="12" DefautValue="" CaptionWidth="57" name="txtOrderNo" ControlKey="DIS;" Width="88" Height="21px" TabKeyIndex="0"\>\</cc1:kedittext\>\<cc1:kedittext id="txtDeptNm" style="Z-INDEX: 121; POSITION: absolute; TOP: 88px; LEFT: 16px" tabIndex="11"
>
> runat="server" DicCode="DeptNm" Caption="부서명" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="40" DefautValue="C_Dept" CaptionWidth="70" name="txtDeptNm" ControlKey="DIC;" Width="168px" Height="23px"\>\</cc1:kedittext\>\<cc1:kedittext id="txtEmpNm" style="Z-INDEX: 122; POSITION: absolute; TOP: 88px; LEFT: 216px" tabIndex="12"
>
> runat="server" DicCode="Pers" Caption="담당자" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="30" DefautValue="C_Emp" CaptionWidth="80" name="txtEmpNm" ControlKey="DIC;" Width="168px" Height="23px"\>\</cc1:kedittext\>\<cc1:kedittext id="txtCustNm" style="Z-INDEX: 124; POSITION: absolute; TOP: 48px; LEFT: 16px" tabIndex="7"
>
> runat="server" DicCode="CustPlace" Caption="거래처" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="40" DefautValue="" CaptionWidth="70" name="txtCustNm" ControlKey="DIC;KEY;NON" Width="168px" Height="23px"\>\</cc1:kedittext\>\<cc1:keditdate id="datFixDate" style="Z-INDEX: 126; POSITION: absolute; TOP: 88px; LEFT: 527px"
>
> tabIndex="15" runat="server" DicCode="FixDate" Caption="확정일" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="10" DefautValue="" CaptionWidth="57" name="datFixDate" ControlKey="DIS;" Width="80px" Height="23px" TabKeyIndex="0" DateType="ymd"\>\</cc1:keditdate\>\<cc1:kedittext id="txtCust2Nm" style="Z-INDEX: 132; POSITION: absolute; TOP: 48px; LEFT: 416px"
>
> tabIndex="9" runat="server" DicCode="Cust2Nm" Caption="중개인" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="40" DefautValue="" CaptionWidth="57" name="txtCust2Nm" ControlKey="DIC;" Width="168px" Height="23px"\>\</cc1:kedittext\>\<cc1:keditdate id="datContractDate" style="Z-INDEX: 133; POSITION: absolute; TOP: 8px; LEFT: 616px"
>
> tabIndex="4" runat="server" DicCode="ContDate" Caption="계약일" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="10" DefautValue="" CaptionWidth="57" name="datContractDate" ControlKey="" Width="72px" Height="22px" DateType="ymd"\>\</cc1:keditdate\>\<cc1:kedittext id="txtPONo" style="Z-INDEX: 134; POSITION: absolute; TOP: 8px; LEFT: 416px" tabIndex="3"
>
> runat="server" DicCode="P/ONo" Caption="P/ONo" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="20" DefautValue="" CaptionWidth="80" name="txtPONo" ControlKey="" Width="168px" Height="21px"\>\</cc1:kedittext\>\<cc1:kedittext id="txtQuotNo" style="Z-INDEX: 104; POSITION: absolute; TOP: 8px; LEFT: 696px" runat="server"
>
> DicCode="QuotNo" Caption="견적번호" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="30" DefautValue="" CaptionWidth="70" name="txtQuotNo" ControlKey="DIS;" Width="88px" Height="21px" TabKeyIndex="0"\>\</cc1:kedittext\>\<cc1:keditdate id="datDelvDate" style="Z-INDEX: 109; POSITION: absolute; TOP: 88px; LEFT: 416px"
>
> tabIndex="13" runat="server" DicCode="LimitDate" Caption="납기일" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="10" DefautValue="" CaptionWidth="57" name="datDelvDate" Width="169" Height="22px" DateType="ymd"\>\</cc1:keditdate\>\<cc1:kedittext id="txtCustomerNo" style="Z-INDEX: 128; POSITION: absolute; TOP: 48px; LEFT: 216px"
>
> tabIndex="8" runat="server" DicCode="Cust_No" Caption="거래처번호" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="40" DefautValue="" CaptionWidth="80" name="txtCustomerNo" ControlKey="DIC;" Width="168px" Height="23px"\>\</cc1:kedittext\>\<cc1:kedittext id="txtPayment" style="Z-INDEX: 110; POSITION: absolute; TOP: 141px; LEFT: 16px"
>
> tabIndex="16" runat="server" DicCode="" Caption="" TextMode="MultiLine" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="200" DefautValue="" CaptionWidth="0" name="txtPayment" ControlKey="" Width="370px" Height="51px"\>\</cc1:kedittext\>\<cc1:keditlabel id="Label3" style="Z-INDEX: 131; POSITION: absolute; TOP: 280px; LEFT: 771px" runat="server"
>
> DicCode="" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" name="Label3" ControlKey="" Width="16px" Height="13px" Text="%"\>%\</cc1:keditlabel\>\<cc1:khtmlbutton id="btnItemGrpSel" style="Z-INDEX: 101; POSITION: absolute; TOP: 203px; LEFT: 816px"
>
> tabIndex="22" runat="server" DicCode="ItemGroupSel2" Width="169px" Height="23px" Text="품목그룹선택..."\>\</cc1:khtmlbutton\>\<cc1:kedittext id="txtCustDelvWay" style="Z-INDEX: 143; POSITION: absolute; TOP: 304px; LEFT: 16px"
>
> tabIndex="30" runat="server" DicCode="CustDelvWay" Caption="고객지정운송편" Width="168px"\>\</cc1:kedittext\>\<cc1:keditcheck id="chkEarlyShipYn" style="Z-INDEX: 144; POSITION: absolute; TOP: 320px; LEFT: 216px"
>
> runat="server" DicCode="EarlyShipYn" Caption="납기전출하여부" CaptionWidth="200" ControlKey="HID" Width="128px" Enabled="False"\>\</cc1:keditcheck\>\<cc1:keditcheck id="chkDirectShipYn" style="Z-INDEX: 145; POSITION: absolute; TOP: 320px; LEFT: 360px"
>
> runat="server" DicCode="DirectShipYn" Caption="즉시출하여부" CaptionWidth="200" ControlKey="HID" Width="104px" Enabled="False"\>\</cc1:keditcheck\>\<cc1:keditcheck id="chkDirectDelvYn" style="Z-INDEX: 146; POSITION: absolute; TOP: 320px; LEFT: 480px"
>
> tabIndex="31" runat="server" DicCode="DirectDelvY" Caption="직송여부" CaptionWidth="200" Width="80px"\>\</cc1:keditcheck\>\<cc1:khtmlbutton id="btnSaleOrder02Cfm" style="Z-INDEX: 147; POSITION: absolute; TOP: 232px; LEFT: 816px"
>
> tabIndex="25" runat="server" DicCode="AppReport" name="CmdRePrice" Width="80px" Height="23px" Text="결재상신" TabKeyIndex="25"\>\</cc1:khtmlbutton\>\<cc1:khtmlbutton id="btnSaleOrder02Cancel" style="Z-INDEX: 148; POSITION: absolute; TOP: 232px; LEFT: 904px"
>
> tabIndex="26" runat="server" DicCode="AppCancel" name="CmdRePrice" Width="80px" Height="23px" Text="결재취소" TabKeyIndex="26"\>\</cc1:khtmlbutton\>\<cc1:khtmlbutton id="CmdStkCenter" style="Z-INDEX: 149; POSITION: absolute; TOP: 312px; LEFT: 816px"
>
> tabIndex="33" runat="server" DicCode="BatchChange" name="Command1" Width="168px" Height="26px" Text="일괄변경"\>\</cc1:khtmlbutton\>\<cc1:khtmlbutton id="btnSaleOrder02Status" style="Z-INDEX: 150; POSITION: absolute; TOP: 232px; LEFT: 904px"
>
> tabIndex="26" runat="server" DicCode="AppReport" name="CmdRePrice" Width="80px" Height="23px" Text="결재진행상태" TabKeyIndex="26"\>\</cc1:khtmlbutton\>
>
> \<cc1:keditfloat style="Z-INDEX: 151; POSITION: absolute; TOP: 304px; LEFT: 216px" id="fltSjparkFrom"
>
> tabIndex="27" runat="server" Height="21px" Width="80px" ControlKey="" name="fltDCRate" CaptionWidth="46"
>
> DefautValue="" maxlength="11" BorderWidth="0px" BorderColor="MediumBlue" BackColor="Transparent"
>
> Caption="sjpark_최소값" DicCode="DCRate" declength="0"\>\</cc1:keditfloat\>
>
> \<cc1:keditfloat style="Z-INDEX: 106; POSITION: absolute; TOP: 304px; LEFT: 304px" id="fltSjparkTo"
>
> tabIndex="27" runat="server" Height="21px" Width="80px" ControlKey="" name="fltDCRate" CaptionWidth="46"
>
> DefautValue="" maxlength="11" BorderWidth="0px" BorderColor="MediumBlue" BackColor="Transparent"
>
> Caption="sjpark_최대값" DicCode="DCRate" declength="0"\>\</cc1:keditfloat\>\</DIV\>
>
> \<cc1:kedittext id="txtSourceType" style="Z-INDEX: 105; POSITION: absolute; TOP: 616px; LEFT: 152px"
>
> tabIndex="0" runat="server" DicCode="" Caption="" BackColor="Transparent" BorderColor="MediumBlue"
>
> BorderWidth="0px" maxlength="8000" DefautValue="" CaptionWidth="0" name="txtOtherSerl" ControlKey="HID;"
>
> Width="24px" Height="15px"\>\</cc1:kedittext\>\<cc1:keditcombo id="cmbProType" style="Z-INDEX: 103; POSITION: absolute; TOP: 96px; LEFT: 824px"
>
> tabIndex="11" runat="server" DicCode="ProType" Caption="재고관리구분" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="1"
>
> DefautValue="" CaptionWidth="57" name="cmbProgressType" Width="168px" Height="21px" TabKeyIndex="0"\>\</cc1:keditcombo\>
>
> \<DIV dataFld="divHid" id="divHid" style="Z-INDEX: 101; POSITION: absolute; WIDTH: 160px; HEIGHT: 44px; VISIBILITY: hidden; TOP: 601px; LEFT: 11px"
>
> ms_positioning="GridLayout"\>\<cc1:keditlabel id="lblNoOption" style="Z-INDEX: 126; POSITION: absolute; TOP: 25px; LEFT: 8px"
>
> runat="server" DicCode="OptNotExist" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" name="lblNoOption"
>
> ControlKey="" Width="51px" Height="14px" Text="옵션없음"\>옵션없음\</cc1:keditlabel\>\<cc1:keditlabel id="lblOption" style="Z-INDEX: 151; POSITION: absolute; TOP: 7px; LEFT: 7px" runat="server"
>
> DicCode="OptExist" Caption="옵션있음" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" name="lblNoOption" ControlKey="" Width="51px" Height="14px" Text="옵션없음"\>옵션있음\</cc1:keditlabel\>\<cc1:kedittext id="txtOtherNo" style="Z-INDEX: 152; POSITION: absolute; TOP: 15px; LEFT: 107px"
>
> tabIndex="0" runat="server" DicCode="" Caption="" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="8000" DefautValue="" CaptionWidth="0" name="txtOtherNo" ControlKey="HID;" Width="24px" Height="8px"\>\</cc1:kedittext\>\<cc1:kedittext id="txtPlanNm" style="Z-INDEX: 153; POSITION: absolute; TOP: 15px; LEFT: 88px" runat="server"
>
> DicCode="SalesAct" Caption="영업활동" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="10" DefautValue="" CaptionWidth="57" name="txtPlanNm" ControlKey="DIS;HID;" Width="40px" Height="12px"\>\</cc1:kedittext\>\<cc1:kedittext id="txtOtherRev" style="Z-INDEX: 154; POSITION: absolute; TOP: 15px; LEFT: 65px"
>
> tabIndex="0" runat="server" DicCode="" Caption="" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="8000" DefautValue="" CaptionWidth="0" name="txtOtherRev" ControlKey="HID;" Width="24px" Height="8px"\>\</cc1:kedittext\>\<INPUT id="hidSalesCommon" style="Z-INDEX: 155; POSITION: absolute; WIDTH: 1px; HEIGHT: 5px; TOP: 12px; LEFT: 121px"
>
> type="hidden" size="1" name="Hidden1" runat="server"\>
>
> \<cc1:kedittext id="txtPay" style="Z-INDEX: 156; POSITION: absolute; TOP: 15px; LEFT: 79px" runat="server"
>
> DicCode="" Caption="Pay" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px"
>
> maxlength="10" DefautValue="" CaptionWidth="29" name="txtPay" ControlKey="HID;" Width="1px"
>
> Height="11px"\>\</cc1:kedittext\>\<cc1:kedittext id="txtOtherSerl" style="Z-INDEX: 157; POSITION: absolute; TOP: 15px; LEFT: 99px"
>
> tabIndex="0" runat="server" DicCode="" Caption="" BackColor="Transparent" BorderColor="MediumBlue" BorderWidth="0px" maxlength="8000"
>
> DefautValue="" CaptionWidth="0" name="txtOtherSerl" ControlKey="HID;" Width="24px" Height="15px"\>\</cc1:kedittext\>\</DIV\>
>
> \</form\>
>
> \<!--#include file="../../../Common/Script/Common.bas"--\>
>
> \<!--#include file="../../../Common/Script/Page.bas"--\>
>
> \<!--#include file="../../../Common/Script/GroupWare.bas"--\>
>
> \<!--Dialog폼관련 Script--\>
>
> \<SCRIPT language="vbscript" src="../../../Common/Script/CommonDlg.vbs"\>\</SCRIPT\>
>
> \<SCRIPT language="vbscript"\>

\<!--

> Option Explicit

' == 주문등록 ==

' ============================================

Private gstrOpen

Private gstrCustNm

Private gstrCustNo

Private gstrDeptNm

Private gstrDeptNo

Private gstrEmpNm

Private gstrEmpNo

Private msItemCd

Private msUnitCd

Private mlngActiveRow ' Sheet현재행

 

> Private IsfltExRateChg

Private mstrDelvCust()

Private msNo ' No

Private msItemNo ' 품번

Private msItemNm ' 품목

Private msSize ' 규격

Private msUnitNm ' 단위

Private msOption ' 옵션

Private msOriginPrice ' 공급단가

Private msDCRate ' 할인율

 

Private msPrice ' 할인단가

Private msVatClss ' 부가세포함

 

Private msQty ' 수량

Private msVat ' 부가세

 

Private msAmt ' 공급가액

 

Private msDelvDate ' 납품기일

Private msDelvQty ' 생산(납품)수량

Private msProgClss ' 진행구분

Private msKorAmt ' 원화공급가액

 

Private msSOSerl ' 주문순번

Private msDeliveryCust ' 납품처

 

Private msstkUnitNm ' 단위(재고단위)

Private msStkQty ' 재고단위수량

Private msControlNo ' 관리번호

 

Private msDeliveryCustCd ' 납품처코드

 

Private msCustItemNo ' 거래처품번

 

Private msCustItemSpec ' 거래처품번

 

Private msCustItemUnit ' 거래처품번

 

Private msFixYn ' 확정

Private msStdCost ' 표준원가

Private msTotCost ' 총비용

 

Private msBasicPrice ' 기본단가

Private msOptionPrice ' 옵션추가단가

Private msKorPrice ' 원화단가

Private msRemark ' 비고

Private msButton ' 버튼

Private msStkUnitCd ' 단위(재고단위)

Private msVatRate ' 부가세율

Private msAvailStock ' 가용재고

 

Private msNextQty ' 진행수량

Private msSumAmt ' 금액(공급가액+부가세

 

Private msQutoNo ' 견적번호

Private msQutoRev ' 견적차수

Private msQutoSerl ' 견적순번

Private msOldCustCd

Private msOldDeptCd

Private msOldEmpId

Private msOldCurrCd

Private msStkOriQty

Private msCustomPrice

Private msStdSalesPrice

Private msMinPrice

Private msStkCenter

Private msPriceUnitNm ' 단가단위

Private msUnitPrice ' 단위단가

Private msPriceUnitCd ' 단가단위코드

Private msPriceUnitQty ' 단가단위수량

Private msDeliveryCustBtn

Private nExpClss

Private msCustItemNm ' 거래처품목(by keko '2002/01/29)

Private msDelvHour ' 납품시

 

> Private msOverShipPermit                ' 과출하허용여부
>
> Private msPriceDiv                                ' 단가구분
>
> Private msPriceUnitRate                        ' 단가기준단위환산율

 

Private bRev

Private vntOtherNo

Private mvntRevKey

Private mvntSerlKey

Private cnt, cntQutoRev, cntQutoSerl

Private QutoNo, QutoRev, QutoSerl

Private objSalesCommFn

Private bDoYeoShin

Private msRemark2

Private mstest_sjpark

Private mstest_hcwoo

IsfltExRateChg = false

>  
>
> '@@ Function = 툴바
>
> Function NewPage(strParam)
>
> Form1.ylwsh_Data.value = ""
>
> Form1.pageMode.value = "NewPage"
>
> Form1.pageParam.value = strParam

 

> Call GoSubmit()        
>
> End Function

 

> Function Query(strParam)
>
> If IsDataChanged() = True Then ' 데이터 변경여부 확인

                Dim bulbtn

                

        

> bulBtn = MessageBox("\<%=\_page.GetMessageString(ConstMessage.CHANGESAVEYESNO,"내용이 변경되었습니다. 저장하시겠습니까?")%\>", vbYesNo) ' 데이터가 변경되었습니다. + VbLf + 저장하시겠습니까?

 

> If bulBtn = vbYes then
>
> Call Save("")
>
> Exit Function
>
> End If
>
> End If

 

        Form1.pageMode.value = "Query"

> Form1.pageParam.value = strParam
>
> Call SetLocalInfoToServer("")

 

> Call GoSubmit()
>
> End Function

 

> Function Save(strParam)
>
> Dim lngRow
>
> Dim strTemp
>
> Dim StrOriginPrice
>
> Dim strEtcPrice1
>
> Dim strItemNo
>
> Dim msgResult
>
>  
>
> If Form1.ylwsh.DataRowCnt = 0 Then
>
> MessageBoxShow("\<%=\_page.GetMessageString(ConstMessage.SheetDataNotFound,"쉬트에 자료가 없습니다. 자료를 입력하세요.")%\>") ' 쉬트에 자료가 없습니다. + VbLf + 자료를 입력하세요.
>
> Exit Function
>
> End If

 

> If Form1.ylwsh.fnCheckNotNull() = False then
>
> Exit Function
>
> End If

 

> if strParam = "A" then ' Save As
>
> txtOrderNo.all(1).Value = ""
>
> txtRev.all(1).Value = ""
>
> Form1.chkFixYN.Checked = false
>
> datFixDate.all(1).Value = ""
>
> Form1.ylwsh.SetText Form1.ylwsh.ColX(msControlNo), SS_ALLROWS, ""
>
> Form1.ylwsh.SetText Form1.ylwsh.ColX(msQutoNo), SS_ALLROWS, ""
>
> Form1.ylwsh.SetText Form1.ylwsh.ColX(msQutoRev), SS_ALLROWS, ""
>
> Form1.ylwsh.SetText Form1.ylwsh.ColX(msQutoSerl), SS_ALLROWS, ""
>
> Form1.ylwsh.SetText Form1.ylwsh.ColX(msDelvQty), SS_ALLROWS, ""
>
> Form1.ylwsh.SetText Form1.ylwsh.ColX(msProgClss), SS_ALLROWS, ""
>
> cmbProgressType.all(1).Value = "0"
>
> else
>
> if strParam \<\> "RV" then                
>
> If Form1.ChkFixYn.checked = true Then
>
> MessageBoxShow("\<%=\_page.GetMessageString(ConstMessage.NOTCONFIRMUPDATE)%\>")
>
> Exit Function
>
> End If
>
> end if
>
> end if

 

> if fnCustCreditCheck() = false then
>
> exit function
>
> end if
>
>  
>
>  

If "\<%=\_vari.S_MINPRICEMSG%\>" = "0" or "\<%=\_vari.S_MINPRICEMSG%\>" = "2" Then ' 경고:SubSeq = '002' and Seq = '304', 메세지(0), 불가(2)

For lngRow = 1 To Form1.ylwsh.DataRowCnt Step 1 ' 표준대리점가 보다 판매단가가 작을 경우에는 경고메세지

Form1.ylwsh.GetText SS_HEADER, lngRow, strTemp

If strTemp = SSHD_ADD Or strTemp = SSHD_UPDATE Then

StrOriginPrice = Form1.ylwsh.cellText(msPrice , lngRow)

strEtcPrice1 = Form1.ylwsh.cellText(msMinPrice, lngRow)

strItemNo = Form1.ylwsh.cellText(msItemNo, lngRow)

> If "\<%=\_vari.S_MINPRICEMSG%\>" = "0" Then '메세지
>
> If CDBL(strEtcPrice1) \<\> 0 And CDBL(strEtcPrice1) \> CDBL(StrOriginPrice) Then
>
> msgResult = MessageBox("\<%=\_page.GetMessageString(ConstMessage.MINPRICEOVER,"최소판매가보다 판매단가가 작습니다. 저장하시겠습니까?")%\>", vbYesNo) ' 삭제하시겠습니까?
>
> If msgResult = vbNo Then
>
> Exit Function
>
> End If
>
> End If
>
> Else '불가
>
> If CDBL(strEtcPrice1) \<\> 0 And CDBL(strEtcPrice1) \> CDBL(StrOriginPrice) Then
>
> MessageBoxShow("\<%=\_page.GetMessageString(ConstMessage.MINPRICEOVERERR,"최소판매가보다 판매단가가 작습니다. 저장할 수 없습니다.")%\>")
>
>  
>
> Exit Function
>
> End If
>
> End IF

End If

Next

End If

 

> Form1.ylwsh_Data.value = Form1.ylwsh.GetData() ' 문자열을 '', ''형태로 생성한다. ControlKey가 NPA가 아닌것을..

 

> Form1.pageMode.value = "Save"
>
> Form1.pageParam.value = strParam
>
> Call SetLocalInfoToServer("")
>
> Call GoSubmit()
>
> End Function

 

> Function Delete(strParam)
>
> If "\<%=\_vari.S_CONFIRMSAORDER%\>" = "1" And Form1.chkFixYN.Checked = True Then '통제에서 확정사용시 0; 미사용 1; 사용
>
> MessageBoxShow("\<%=\_page.GetMessageString(ConstMessage.NOTCONFIRMUPDATE,"확정된 자료는 변경할 수 없습니다.")%\>") ' 쉬트에 자료가 없습니다. + VbLf + 자료를 입력하세요.
>
> Exit Function
>
> End If

 

> Dim bulbtn

 

> if txtOrderNo.all(1).Value = "" then exit function

 

> bulBtn = MessageBox("\<%=\_page.GetMessageString(ConstMessage.DELYESNO,"삭제하시겠습니까?")%\>", vbYesNo) ' 삭제하시겠습니까?

 

> If bulBtn = vbYes then
>
> Form1.ylwsh_Data.value = ""
>
> Form1.pageMode.value = "Delete"
>
> Form1.pageParam.value = strParam
>
> Call SetLocalInfoToServer("")
>
> Call GoSubmit()
>
> End If
>
> End Function

 

> Function Cut(strParam)
>
> If "\<%=\_vari.S_CONFIRMSAORDER%\>" = "1" And Form1.chkFixYN.Checked = True Then '통제에서 확정사용시 0; 미사용 1; 사용
>
> MessageBoxShow("\<%=\_page.GetMessageString(ConstMessage.NOTCONFIRMUPDATE,"확정된 자료는 변경할 수 없습니다.")%\>") ' 쉬트에 자료가 없습니다. + VbLf + 자료를 입력하세요.
>
> Exit Function
>
> End If

 

> Dim Row
>
> Row = Form1.ylwsh.CutHeaderSetting()
>
> If Row \<\> 0 Then
>
> if Row = Form1.ylwsh.DataRowCnt then
>
> call Delete("")
>
> else
>
> Form1.ylwsh_Data.value = Form1.ylwsh.GetData
>
> Form1.pageMode.value = "Cut"
>
> Form1.pageParam.value = strParam
>
> Call SetLocalInfoToServer("")
>
> Call GoSubmit()
>
> end if
>
> End If
>
>  
>
> Call fnAfterProcCut
>
>  
>
> End Function

 

> Sub ReportPrint()
>
> Dim strAccUnit, strExpClss, strOrderNo, strPgm, strMrdFileNm

 

> strAccUnit = cmbAccUnit.all(1).Value
>
> strExpClss = GetOptionData(Form1, "optExpClss")
>
> strOrderNo = txtOrderNo.all(1).Value

 

> If strOrderNo = "" Then Exit Sub

 

> strMrdFileNm = "SSPOrderPrt.mrd"
>
> strPgm = "/rv WorkType\[PRINT\] @pAccUnit\[" + strAccUnit + "\]" + " @pExpClss\[" + strExpClss + "\] " + " @pOrderNo\[" + strOrderNo + "\] "

 

> Call fnShowReport(CNST_RD_NORMAL, strMrdFileNm, "", strPgm)
>
> End Sub

 

> ' ActionPostBack되기 전 처리작업을 코딩한다.
>
> '@@ Action의 ex : 툴바 누르기
>
> Sub ActionPostBackBefore(strMode)
>
> If "\<%=\_vari.S_CONFIRMSAORDER%\>" = "1" Then '통제에서 확정사용시 0; 미사용 1; 사용
>
> Form1.ChkFixYn.ParentElement.style.display = ""
>
> datFixDate.style.display = ""
>
> txtFixEmpNo.style.display = ""
>
> Else
>
> Form1.ChkFixYn.ParentElement.style.display = "NONE"
>
> datFixDate.style.display = "NONE"
>
> txtFixEmpNo.style.display = "NONE"
>
> End If                

 

> If "\<%=\_vari.S_SOYEOSHIN%\>" = "1" Then                                        '통제에서 여신상용시

 

 

 

 

> Form1.chkCredit.ParentElement.style.display = ""
>
> Form1.chkShortAmtYn.ParentElement.style.display = ""
>
> Else
>
> Form1.chkCredit.ParentElement.style.display = "NONE"
>
> Form1.chkShortAmtYn.ParentElement.style.display = "NONE"
>
> End If                
>
>  

 

>  
>
> End Sub

 

> ' ActionPostBack된 후 처리작업을 코딩한다.
>
> Sub ActionPostBackAfter(strMode)
>
> '전자결재 사용여부(구매발주서)를 체크하여 사용하지 않는 경우에는 버튼을 숨긴다. (20060110.SHMIN)
>
> If "\<%=\_vari.A_GROUPWARESASalesOrder%\>" \<\> "1" then
>
> Call SetControlKey("btnSaleOrder02Cfm", "HID")
>
> Call SetControlKey("btnSaleOrder02Cancel", "HID")
>
> Else
>
> If "\<%=\_vari.S_CONFIRMSAORDER%\>" = "1" Then '통제에서 확정사용시 0; 미사용 1; 사용
>
> Call SetControlKey("ChkFixYn", "DIS")
>
> End If
>
> End If
>
>  
>
> If strMode = "Cut" Then
>
> Call fnAfterProcCut
>
> End If
>
>  
>
> End Sub

 

> ' Jump하여 In되는 경우
>
> Function JumpIn(strParam)
>
> End Function

 

> ' Jump하여 Out되는 경우
>
> Function JumpOut(strParam)
>
> Dim i
>
> Dim strArray
>
> Dim strJumpMsg

Dim vntTmp1

Dim vntSONo

> Dim vntSOSerl
>
>  
>
> ' 쉬트의 조건의 경우 설정한다.
>
> Call JumpStringToSplit(strParam, strArray)
>
>  
>
> Dim strJumpPgmID
>
> Dim strURL
>
> strJumpPgmID        = strArray(2, 2)        ' Jump하는 프로그램 ID
>
> strURL                        = strArray(3, 2)        ' Jump하는 프로그램의 URL
>
> strJumpMsg                = strParam                        ' strJumpMsg에 Jump 기본 정보를 입력한다.        
>
>  
>
> Dim strJumpPgmIdTruc
>
>  
>
> if instr(strJumpPgmID,"\_") \<\> 0 then
>
> strJumpPgmIdTruc = left(strJumpPgmID, instr(strJumpPgmID,"\_") - 1)
>
> else
>
> strJumpPgmIdTruc = strJumpPgmID
>
> end if

 

> ' AddJumpString strJumpMsg, Tag, value
>
> Select Case ucase(strJumpPgmIdTruc) 'Jump하는 프로그램 ID

Case UCASE("dlgPMItemSearch")        '사양품목조회 - 20050927.WGKIM

> Dim strRtnValue
>
> Dim strParameter
>
> Dim arrRtnValue
>
> Dim RowCnt
>
>  
>
> RowCnt = Form1.ylwsh.DataRowCnt + 1
>
>  
>
>  
>
> strParameter = ""
>
> arrRtnValue = ""
>
>  
>
> strParameter = "ACCUNIT=" + cmbAccUnit.All(1).Value
>
>  
>
> strRtnValue = LoadDlgForm(true,"dlgPMItemSearch",strParameter ,GetDlgData())
>
>  
>
> arrRtnValue = Split(strRtnValue, CNST_SP)

 

> If UCase(arrRtnValue(0)) = "FALSE" Then
>
>  
>
> ElseIf UCase(arrRtnValue(0)) = "CANCEL" Then
>
>  
>
> Else        
>
> arrRtnValue = ""
>
> arrRtnValue = SplitArray(strRtnValue, CNST_SP_NT, CNST_SP_LF, CNST_SP)
>
> If arrRtnValue(0,0) \<\> "" Then
>
> Form1.ylwsh.CellText(msItemNm, RowCnt)                = arrRtnValue(0,0)
>
> Form1.ylwsh.CellText(msItemNo, RowCnt)                = arrRtnValue(0,1)
>
> Form1.ylwsh.CellText(msItemCd, RowCnt)                = arrRtnValue(0,2)
>
> Form1.ylwsh.CellText(msSize, RowCnt)         = arrRtnValue(0,3)
>
> Form1.ylwsh.CellText(msUnitNm, RowCnt)                = arrRtnValue(0,4)
>
> Form1.ylwsh.CellText(msUnitCd, RowCnt)                = arrRtnValue(0,5)
>
> Form1.ylwsh.CellText(msStkUnitNm, RowCnt)         = arrRtnValue(0,4)
>
> Form1.ylwsh.CellText(msStkUnitCd, RowCnt)         = arrRtnValue(0,5)        
>
> End If
>
> End If                        
>
>  
>
> Call fnPriceChange(RowCnt, RowCnt + UBound(arrRtnValue))
>
>  
>
> Exit Function                
>
> 'AddJumpString strJumpMsg, "AccUnit", cmbAccUnit.All(1).Value
>
>  

Case UCASE("frmSADelvReq"), UCASE("frmSADelvReqMti") '출하의뢰

If GetOptionData(Form1, "optExpClss") = 3 Then

MessageBoxShow("\<%=\_page.GetMessageString(ConstMessage.NOJUMPORDERINV, "내수/Local구분이 Local\[선LC\]인 건은 LC로 먼저 진행해야 합니다.")%\>")

Exit Function

End If

If "\<%=\_vari.S_CONFIRMSAORDER%\>" = "1" and Form1.ChkFixYn.checked = false Then

> MessageBoxShow("\<%=\_page.GetMessageString(ConstMessage.NOTCONFIRM, "확정작업이 선행되어야 합니다...")%\>")

Exit Function

End If

> AddJumpString strJumpMsg, "SONo", txtOrderNo.all(1).Value
>
> AddJumpString strJumpMsg, "ProType"                , cmbProType.all(1).Value

 

Case UCASE("frmSASalesInvoice") '거래명세서 Jump

''''''' 추가 4월27일 선LC는 출하의뢰및 거래명세서로 점프 못함

If GetOptionData(Form1, "optExpClss") = 3 Then

> MessageBoxShow("\<%=\_page.GetMessageString(ConstMessage.NOJUMPORDERINV, "내수/Local구분이 Local\[선LC\]인 건은 LC로 먼저 진행해야 합니다.")%\>")

Exit Function

End If

If "\<%=\_vari.S_CONFIRMSAORDER%\>" = "1" and Form1.ChkFixYn.checked = false Then

> MessageBoxShow("\<%=\_page.GetMessageString(ConstMessage.NOTCONFIRM, "확정작업이 선행되어야 합니다...")%\>")

Exit Function

End If

>  
>
> AddJumpString strJumpMsg, "SONo", txtOrderNo.all(1).Value
>
> AddJumpString strJumpMsg, "ProType"        , cmbProType.all(1).Value

 

Case UCASE("frmSABill") '계산서

 

 

' 내수만 점프

If GetOptionData(Form1, "optExpClss") \<\> 1 Then

> MessageBoxShow("\<%=\_page.GetMessageString(ConstMessage.ORDERBILLJUMP,"내수만 세금계산서로 진행할 수 있습니다.")%\>")

Exit Function

End If

 

If "\<%=\_vari.S_CONFIRMSAORDER%\>" = "1" and Form1.ChkFixYn.checked = false Then

> MessageBoxShow("\<%=\_page.GetMessageString(ConstMessage.NOTCONFIRM, "확정작업이 선행되어야 합니다...")%\>")

Exit Function

End If

> AddJumpString strJumpMsg, "SONo", txtOrderNo.all(1).Value

 

Case UCASE("frmSELCAdd") '수출LC 등록

If GetOptionData(Form1, "optExpClss") \<\> 3 Then

> MessageBoxShow("\<%=\_page.GetMessageString(ConstMessage.NOJUMPORDERLC,"내자 및 Local(후LC)는 LC등록으로 진행할 수 없습니다.")%\>")

Exit Function

End If

If "\<%=\_vari.S_CONFIRMSAORDER%\>" = "1" and Form1.ChkFixYn.checked = false Then

> MessageBoxShow("\<%=\_page.GetMessageString(ConstMessage.NOTCONFIRM, "확정작업이 선행되어야 합니다...")%\>")

Exit Function

End If

> AddJumpString strJumpMsg, "SONo", txtOrderNo.all(1).Value
>
> AddJumpString strJumpMsg, "cmbBizCombo", cmbAccUnit.All(1).value

Case UCASE("frmPPReq") '생산의뢰

For i = 1 To Form1.ylwsh.DataRowCnt Step 1

Form1.ylwsh.GetText Form1.ylwsh.ColX(msSOSerl), i, vntTmp1

If i = 1 Then

vntSONo = txtOrderNo.all(1).Value

vntSOSerl = vntTmp1

Else

vntSONo = vntSONo & "\_/" & txtOrderNo.all(1).Value

vntSOSerl = vntSOSerl & "\_/" & vntTmp1

End If

Next

 

If "\<%=\_vari.S_CONFIRMSAORDER%\>" = "1" and Form1.ChkFixYn.checked = false Then

> MessageBoxShow("\<%=\_page.GetMessageString(ConstMessage.NOTCONFIRM, "확정작업이 선행되어야 합니다...")%\>")

Exit Function

End If

AddJumpString strJumpMsg, "SONo", vntSONo

AddJumpString strJumpMsg, "SOSerl", vntSOSerl

 

Case UCASE("frmUGPOReq") '구매요청

vntSONo = ""

vntSONo = txtOrderNo.all(1).Value

If "\<%=\_vari.S_CONFIRMSAORDER%\>" = "1" and Form1.ChkFixYn.checked = false Then

> MessageBoxShow("\<%=\_page.GetMessageString(ConstMessage.NOTCONFIRM, "확정작업이 선행되어야 합니다...")%\>")

Exit Function

End If

AddJumpString strJumpMsg, "SONo", vntSONo

>  
>
> Case UCASE("frmUGPumi") '구매품의

vntSONo = ""

vntSONo = txtOrderNo.all(1).Value

If "\<%=\_vari.S_CONFIRMSAORDER%\>" = "1" and Form1.ChkFixYn.checked = false Then

> MessageBoxShow("\<%=\_page.GetMessageString(ConstMessage.NOTCONFIRM, "확정작업이 선행되어야 합니다...")%\>")

Exit Function

End If

AddJumpString strJumpMsg, "SONo", vntSONo

 

> Case UCASE("ylwa09006")
>
> AddJumpString strJumpMsg, "cmbBizCombo", cmbAccUnit.All(1).value
>
> AddJumpString strJumpMsg, "RowCount", CStr(Form1.ylwsh.DataRowCnt)
>
> AddJumpString strJumpMsg, "RowNo", ""
>
> AddJumpString strJumpMsg, "szCombo1", "NON" + Form1.ylwsh.CellText(msStkCenter, Form1.ylwsh.ActiveRow)
>
> AddJumpString strJumpMsg, "szCodeHelp1", "NON" + Form1.ylwsh.CellText(msItemCd, Form1.ylwsh.ActiveRow) + space(20) + \_
>
> Form1.ylwsh.CellText(msItemNm, Form1.ylwsh.ActiveRow)
>
> AddJumpString strJumpMsg, "szCodeHelp2", "NON" + Form1.ylwsh.CellText(msItemCd, Form1.ylwsh.ActiveRow) + space(20) + \_
>
> Form1.ylwsh.CellText(msItemNo, Form1.ylwsh.ActiveRow)                                                                                                
>
> 'Doan add
>
> Case UCASE("dlgSASalesOrder") 'SITE_SNSV
>
> AddJumpString strJumpMsg, "SONo", txtOrderNo.all(1).Value

'Doan And

                                                                                                

> Case Else
>
>  
>
> Dim vntRow
>
> Dim vntItemNm1
>
> Dim vntItemNo1
>
> Dim vntSpec1
>
> Dim vntItemCd1
>
> Dim vntUnit1
>
> Dim vntUnitCd1
>
> Dim vntStkQty1
>
> Dim vntItemNmTmp1
>
> Dim vntItemNoTmp1
>
> Dim vntSpecTmp1
>
> Dim vntItemCdTmp1
>
> Dim vntUnitTmp1
>
> Dim vntUnitCdTmp1
>
> Dim vntStkQtyTmp1
>
> For i = 1 To Form1.ylwsh.DataRowCnt Step 1
>
> If i = i Then
>
> Form1.ylwsh.GetText Form1.ylwsh.ColX(msItemNm)                , i, vntItemNmTmp1
>
> Form1.ylwsh.GetText Form1.ylwsh.ColX(msItemNo)                , i, vntItemNoTmp1
>
> Form1.ylwsh.GetText Form1.ylwsh.ColX(msSize)                , i, vntSpecTmp1
>
> Form1.ylwsh.GetText Form1.ylwsh.ColX(msItemCd)                , i, vntItemCdTmp1
>
> Form1.ylwsh.GetText Form1.ylwsh.ColX(msstkUnitNm)        , i, vntUnitTmp1
>
> Form1.ylwsh.GetText Form1.ylwsh.ColX(msStkUnitCd)        , i, vntUnitCdTmp1
>
> vntStkQtyTmp1 = Form1.ylwsh.Celltext(msStkQty, i)
>
> 'vntRow = CVar(Form1.ylwsh.DataRowCnt)
>
> vntRow = CStr(Form1.ylwsh.DataRowCnt)
>
> If i = 1 Then
>
> vntItemNm1        = vntItemNmTmp1
>
> vntItemNo1        = vntItemNoTmp1
>
> vntSpec1        = vntSpecTmp1
>
> vntItemCd1        = vntItemCdTmp1
>
> vntUnit1        = vntUnitTmp1
>
> vntUnitCd1        = vntUnitCdTmp1
>
> vntStkQty1        = vntStkQtyTmp1
>
> Else
>
> vntItemNm1        = vntItemNm1        & "\_/" & vntItemNmTmp1
>
> vntItemNo1        = vntItemNo1        & "\_/" & vntItemNoTmp1
>
> vntSpec1        = vntSpec1                & "\_/" & vntSpecTmp1
>
> vntItemCd1        = vntItemCd1        & "\_/" & vntItemCdTmp1
>
> vntUnit1        = vntUnit1                & "\_/" & vntUnitTmp1
>
> vntUnitCd1        = vntUnitCd1        & "\_/" & vntUnitCdTmp1
>
> vntStkQty1        = vntStkQty1        & "\_/" & vntStkQtyTmp1
>
> End If
>
> End If
>
> Next
>
> AddJumpString strJumpMsg, "SONo"                , txtOrderNo.all(1).Value
>
> AddJumpString strJumpMsg, "AccUnit"                , cmbAccUnit.all(1).Value
>
> AddJumpString strJumpMsg, "No"                        , txtOrderNo.all(1).Value
>
> AddJumpString strJumpMsg, "OtrAccUnit"        , cmbAccUnit.all(1).Value
>
> AddJumpString strJumpMsg, "OtrNo"                , txtOrderNo.all(1).Value
>
>  
>
> '품목, 수량을 다른 폼으로 Jump길 수 있도록 수정(적송요청, 이동요청)
>
> AddJumpString strJumpMsg, "vntRow"                , vntRow
>
> AddJumpString strJumpMsg, "vntItemNm"        , vntItemNm1
>
> AddJumpString strJumpMsg, "vntItemNo"        , vntItemNo1
>
> AddJumpString strJumpMsg, "vntSpec"                , vntSpec1
>
> AddJumpString strJumpMsg, "vntItemCd"        , vntItemCd1
>
> AddJumpString strJumpMsg, "vntUnit"                , vntUnit1
>
> AddJumpString strJumpMsg, "vntUnitCd"        , vntUnitCd1
>
> AddJumpString strJumpMsg, "vntStkQty"        , vntStkQty1
>
>  
>
> End Select
>
>  
>
> Call SetLocalInfoToServer(strJumpMsg + CNST_SP_LF + strURL+"?PgmID=" + strJumpPgmID)
>
> Erase strArray
>
>  
>
> Form1.pageMode.value = "JumpOut"
>
> Form1.pageParam.value = strParam
>
>  
>
> Call GoJumpOut(strJumpPgmID, strJumpMsg, "")        
>
> End Function
>
>  
>
> '@@ Resize 시트가 여러개 일 때 만들어줘야함 (1개일 때는 필요없음)
>
> '@@ 전체를 비율로 분배하기 때문에 화면 보면서 만들어야함
>
> Sub Page_Resize()
>
> Form1.ylwsh.style.width = abs(Parent.document.body.clientWidth - cint(replace(Form1.ylwsh.style.left,"px","")) - 16 - cint(replace(DIV_content.style.left,"px","")))
>
> Form1.ylwsh.style.height = abs(Parent.document.body.clientheight - cint(replace(Form1.ylwsh.style.top,"px","")) - 8 - cint(replace(DIV_content.style.top,"px","")))
>
> End Sub
>
>  
>
> ' Page 초기화 작업을 코딩한다.
>
> Sub Page_Load()

Form1.ylwsh.ReDraw = False

If Form1.ylwsh.SheetInit(61) = False then

Form1.ylwsh.MaxCols = 61

End If

Form1.ylwsh.AddItem "No"                                , "No"                                , EnText        , msNo                        , 3         , 0, ""

Form1.ylwsh.AddItem "PNum"                                , "품번"                        , EnText        , msItemNo                , 40 , 0, "DIC;"

Form1.ylwsh.AddItem "ItemNm"                        , "품명"                        , EnText        , msItemNm                , 100, 0, "DIC;NON;"

Form1.ylwsh.AddItem "CustItemNm"                , "거래처품명"                , EnText        , msCustItemNm        , 100, 0, "DIC;"

Form1.ylwsh.AddItem "AdSpec"                        , "규격"                        , EnText        , msSize                , 60 , 0, "DIC;"

'5

If "\<%=\_vari.S_SALESBASEPRICE%\>" = "0" then

> Form1.ylwsh.AddItem "PriceBasisUnit"        , "단가기준단위"        , EnText        , msPriceUnitNm        , 20 , 0, "DIS;SHID;"
>
> Form1.ylwsh.AddItem "UnitCost"                        , "기준단위단가"        , EnFloat        , msUnitPrice        , 19 , \<%=this.Session\["GoodsForCost"\]%\>, "DIS;SHID;"
>
> Else
>
> Form1.ylwsh.AddItem "PriceBasisUnit"        , "단가기준단위"        , EnText        , msPriceUnitNm        , 20 , 0, "DIS;"
>
> Form1.ylwsh.AddItem "UnitCost"                        , "기준단위단가"        , EnFloat        , msUnitPrice        , 19 , \<%=this.Session\["GoodsForCost"\]%\>, ""
>
> End If
>
>  

Form1.ylwsh.AddItem "SalUnitNm"                        , "판매단위"                , EnText        , msUnitNm                , 40 , 0, "DIC;NON;"

If "\<%=\_vari.S_SALESBASEPRICE%\>" = "0" then

> Form1.ylwsh.AddItem "PriceBasisUnitQty"        , "단가기준단위환산율", EnFloat        , msPriceUnitQty, 25 , 13, "DIS;SHID;"
>
> Else
>
> Form1.ylwsh.AddItem "PriceBasisUnitQty"        , "단가기준단위환산율", EnFloat        , msPriceUnitQty, 25 , 13, "DIS;"
>
> End If

 

'10

If "\<%=\_vari.S_SALESOPTION%\>" = "0" then

> Form1.ylwsh.AddItem "UPrice"                        , "기본단가"                , EnFloat        , msBasicPrice        , 19 , \<%=this.Session\["GoodsForCost"\]%\>, "DIS;SHID;"
>
> Form1.ylwsh.AddItem "Opt"                                , "옵션"                        , EnButton        , msOption                , 20 , 0, "DIS;SHID;"
>
> Form1.ylwsh.AddItem "Option_Price"                , "옵션단가"                , EnFloat        , msOptionPrice        , 19 , \<%=this.Session\["GoodsForCost"\]%\>, "DIS;SHID;"
>
> Else
>
> Form1.ylwsh.AddItem "UPrice"                        , "기본단가"                , EnFloat        , msBasicPrice        , 19 , \<%=this.Session\["GoodsForCost"\]%\>, ""                
>
> Form1.ylwsh.AddItem "Opt"                                , "옵션"                        , EnButton        , msOption                , 20 , 0, "DIS;"
>
> Form1.ylwsh.AddItem "Option_Price"                , "옵션단가"                , EnFloat        , msOptionPrice        , 19 , \<%=this.Session\["GoodsForCost"\]%\>, "DIS;"
>
> End If

 

> Form1.ylwsh.AddItem "SalPrice"                        , "판매단가"                , EnFloat        , msOriginPrice        , 19 , \<%=this.Session\["GoodsForCost"\]%\>, ""
>
>  
>
> If "\<%=\_vari.S_SALESRATE%\>" = "0" then
>
> Form1.ylwsh.AddItem "DCRate"                        , "할인율"                        , EnFloat        , msDCRate                , 19 , 2, "DIS;SHID;"
>
> Form1.ylwsh.AddItem "DiscSellPrice"                , "할인판매단가"        , EnFloat        , msPrice                , 19 , \<%=this.Session\["GoodsForCost"\]%\>, "DIS;HID;"
>
> Else
>
> Form1.ylwsh.AddItem "DCRate"                        , "할인율"                        , EnFloat        , msDCRate                , 19 , 2, ""
>
> Form1.ylwsh.AddItem "DiscSellPrice"                , "할인판매단가"        , EnFloat        , msPrice                , 19 , \<%=this.Session\["GoodsForCost"\]%\>, ""
>
> End If

'15

 

Form1.ylwsh.AddItem "PriceDiv"                        , "단가구분"                , EnCombo        , msPriceDiv        , 1 , 0, "NON;"

Form1.ylwsh.AddItem "Qty"                                , "수량"                        , EnFloat        , msQty                        , 19 , \<%=this.Session\["GoodsQry"\]%\>, ""

If "\<%=\_vari.D_VATINCLUDE%\>" = "2" then

> Form1.ylwsh.AddItem "BTax"                                , "부가세포함"                , EnCheck        , msVatClss                , 1 , 0, ""
>
> Else
>
> Form1.ylwsh.AddItem "BTax"                                , "부가세포함"                , EnCheck        , msVatClss                , 1 , 0, "DIS;SHID"
>
> End If
>
>  
>
> Form1.ylwsh.AddItem "SellPriceAmt"                , "판매가액"                , EnFloat        , msAmt                        , 19 , \<%=this.Session\["GoodsForAmt"\]%\>, ""

Form1.ylwsh.AddItem "AddedTax"                        , "부가세"                        , EnFloat        , msVat                        , 19 , \<%=this.Session\["GoodsForAmt"\]%\>, ""

> '20

Form1.ylwsh.AddItem "Tot_Amt"                        , "합계금액"                , EnFloat        , msSumAmt                , 19 , \<%=this.Session\["GoodsForAmt"\]%\>, ""

Form1.ylwsh.AddItem "WonAmtSell_Price"        , "원화판매단가"        , EnFloat        , msKorPrice        , 19 , \<%=this.Session\["GoodsWonCost"\]%\>, ""

Form1.ylwsh.AddItem "WonAmtSellPriceAmt", "원화판매가액"        , EnFloat        , msKorAmt                , 19 , \<%=this.Session\["GoodsWonAmt"\]%\>, ""

Form1.ylwsh.AddItem "Day_01"                        , "납품기일"                , EnDate        , msDelvDate        , 10 , 0, ""

Form1.ylwsh.AddItem "DeliveryPart"                , "납품시분"                , EnMask        , msDelvHour        , 5 , 0, ""                , , "##:##"

> '25

 

Form1.ylwsh.AddItem "ProgQty"                        , "진행된수량"                , EnFloat        , msDelvQty                , 19 , \<%=this.Session\["GoodsQry"\]%\>, "DIS;HID;"

Form1.ylwsh.AddItem "OrderOrd"                        , "주문순번"                , EnText        , msSOSerl                , 4 , 0, "DIS;HID;"

Form1.ylwsh.AddItem "UnitU"                                , "재고단위"                , EnText        , msstkUnitNm        , 40 , 0, "DIS;HID;"

Form1.ylwsh.AddItem "UnitA"                                , "재고단위수량"        , EnFloat        , msStkQty                , 19 , \<%=this.Session\["GoodsQry"\]%\>, "DIS;HID;"

Form1.ylwsh.AddItem "MNum"                                , "관리번호"                , EnText        , msControlNo        , 20 , 0, "DIS;HID;"

> '30

 

Form1.ylwsh.AddItem "DeliveryPlaceNew"        , "납품처신규"                , EnButton        , msDeliveryCustBtn, 40, 0, ""

Form1.ylwsh.AddItem "Deliver_01"                , "납품처"                        , EnText        , msDeliveryCust, 40 , 0, "DIC;"

Form1.ylwsh.AddItem "IUCode"                        , "재고단위코드"        , EnText        , msStkUnitCd        , 10 , 0, "DIS;HID;"

Form1.ylwsh.AddItem "ItemCode"                        , "품목코드"                , EnText        , msItemCd                , 10 , 0, "DIS;HID;"

Form1.ylwsh.AddItem "Remark"                        , "비고"                        , EnText        , msRemark                , 200, 0, ""

> '35

Form1.ylwsh.AddItem "UCode"                                , "단위코드"                , EnText        , msUnitCd                , 10 , 0, "DIS;HID;"

Form1.ylwsh.AddItem "BUPrice"                        , "표준원가"                , EnFloat        , msStdCost                , 19 , \<%=this.Session\["GoodsWonCost"\]%\>, ""

Form1.ylwsh.AddItem "TotSalCost"                , "총원가"                        , EnFloat        , msTotCost                , 19 , \<%=this.Session\["GoodsWonCost"\]%\>, ""

Form1.ylwsh.AddItem "ProgType"                        , "진행구분"                , EnCombo        , msProgClss        , 1 , 0, "DIS;HID;"

Form1.ylwsh.AddItem "VatRate"                        , "부가세율"                , EnFloat        , msVatRate                , 8 , \<%=this.Session\["CurrQty"\]%\>, "HID;"

> '40

Form1.ylwsh.AddItem "AvailStk"                        , "가용재고"                , EnFloat        , msAvailStock        , 19 , \<%=this.Session\["GoodsQry"\]%\>, "DIS;"

Form1.ylwsh.AddItem "QuotNo"                        , "견적번호"                , EnText        , msQutoNo                , 12 , 0, "DIS;HID;"

Form1.ylwsh.AddItem "EstA"                                , "견적차수"                , EnText        , msQutoRev                , 2 , 0, "DIS;HID;"

Form1.ylwsh.AddItem "EstNo"                                , "견적순번"                , EnText        , msQutoSerl        , 4 , 0, "DIS;"

Form1.ylwsh.AddItem "OldCustCd"                        , "OldCustCd"                , EnText        , msOldCustCd        , 6 , 0, "DIS;HID;"

> '45

Form1.ylwsh.AddItem "OldDeptCd"                        , "OldDeptCd"                , EnText        , msOldDeptCd        , 5 , 0, "DIS;HID;"

Form1.ylwsh.AddItem "OldEmpId"                        , "OldEmpId"                , EnText        , msOldEmpId        , 8 , 0, "DIS;HID;"

Form1.ylwsh.AddItem "OldCurrCd"                        , "OldCurrCd"                , EnText        , msOldCurrCd        , 3 , 0, "DIS;HID;"

Form1.ylwsh.AddItem "ConsuPrice"                , "소비자가"                , EnFloat        , msCustomPrice        , 19 , \<%=this.Session\["GoodsWonCost"\]%\>, "DIS;HID;"

Form1.ylwsh.AddItem "SalStdPrice"                , "판매기준가"                , EnFloat        , msStdSalesPrice,19 , \<%=this.Session\["GoodsWonCost"\]%\>, "DIS;HID;"

> '50

Form1.ylwsh.AddItem "SalMinPrice"                , "최저판매가"                , EnFloat        , msMinPrice        , 19 , \<%=this.Session\["GoodsWonCost"\]%\>, "DIS;HID;"

Form1.ylwsh.AddItem "StkCenter"                        , "물류센터"                , EnCombo        , msStkCenter                , 2 , 0, ""

Form1.ylwsh.AddItem "PriceBasisUnitCode", "단가기준단위코드", EnText        , msPriceUnitCd        , 3 , 0, "DIS;HID;"

Form1.ylwsh.AddItem "DeliveryPlaceCode"        , "납품처코드"                , EnText        , msDeliveryCustCd,9 , 0, "DIS;HID;"

'54

Form1.ylwsh.AddItem "VendItemNo"                , "업체품번"                , EnText        , msCustItemNo        , 40 , 0, "DIS;"

Form1.ylwsh.AddItem "VendStan"                        , "업체규격"                , EnText        , msCustItemSpec, 60 , 0, "DIS;"

Form1.ylwsh.AddItem "VendUnit"                        , "업체단위"                , EnText        , msCustItemUnit, 40 , 0, "DIS;"

Form1.ylwsh.AddItem "OverShipPermit"        , "과출하허용"                , EnCheck        , msOverShipPermit, 1 , 0, ""

> '58
>
>  
>
> Form1.ylwsh.AddItem "Remark2"                        , "비고2"                        , EnText        , msRemark2                , 100, 0, ""

Form1.ylwsh.AddItem "test_sjpark"         , "test_sjpark"                , EnFloat        , mstest_sjpark        , 19, 0, ""

Form1.ylwsh.AddItem "test_hcwoo"         , "test_hcwoo"                , EnFloat        , mstest_hcwoo        , 19, 0, ""

'@@기본적으로 보여지는 시트 갯수 (기본값이 10 / 안뿌리고 싶으면 0 작성)

Form1.ylwsh.AddRowsToSheet

Form1.ylwsh.ReDraw = True

> ' Form1.SS 초기화 END
>
>  
>
> '@@ SheetComboInit() 없으면 초기화가 안된다
>
> Call SheetComboInit() 'Sheet Combo를 초기화 한다.
>
> Call fnFloatDecimalPlaces(txtCurrNm.all(1).TextCode)
>
> Call ActionPostBack(Form1.pageMode.value)
>
>  
>
> Call SetControlKey("chkCredit", "DIS;")
>
> Call SetControlKey("chkShortAmtYn", "DIS;")
>
> End Sub
>
>  
>
> ' Page unload시 호출한다.
>
> '@@새로 화면이 초기화 될때마다 매번 조회할 수 없으니 파일에 저장하여 필요할 때마다 뿌린다
>
> Sub Page_UnLoad()
>
> Form1.ylwsh.SaveTitleInfo ' 쉬트 정보를 Local File에저장한다.
>
>  
>
> Call SetControlKey("chkCredit", "")
>
> Call SetControlKey("chkShortAmtYn", "")
>
> End Sub
>
>  
>
> ' 쉬트에 데이터를 출력한다.
>
> '@@ DataDisplay - 실제로 화면에 뿌림
>
> Sub DataDisplay()
>
>  
>
> Call cmbAccUnit\_\_ctl_onChange()
>
> Call Form1.ylwsh.Display(Form1.ylwsh_Data.value)
>
> Call ylwshButtonDisplay(Form1.ylwsh_Data.value)
>
> Form1.ylwsh_Data.value = ""
>
>  
>
> if txtOrderNo.All(1).value = "" then                                                'Jump할 경우에는 Query타지만 BLNo없은 것은 ADD Mode로

 

> Dim i
>
> for i = 1 to Form1.ylwsh.DataRowCnt
>
> Form1.ylwsh.SetText SS_HEADER, i, SSHD_ADD
>
> next
>
> end if        
>
>  
>
> Call fnAfterProcCut
>
> End Sub
>
>  
>
> Sub ylwshButtonDisplay(strylwshData)
>
> Dim i
>
> Dim ObjSheet
>
> Dim arrylwshData
>
>  
>
> If "\<%=\_vari.S_SALESOPTION%\>" = "0" Then
>
> Exit Sub
>
> End If
>
>  
>
> Set ObjSheet = Form1.ylwsh.GetSheet
>
>  
>
> arrylwshData = SplitArray(strylwshData,CNST_SP_NT,CNST_SP_LF,CNST_SP)

 

> For i = 0 To Form1.ylwsh.DataRowCnt - 1
>
> ObjSheet.Col = Form1.ylwsh.ColX(msOption)
>
> ObjSheet.Row = i + 1
>
> ObjSheet.TypeButtonText = arrylwshData(CInt(i), 10) + "..."
>
> Next
>
> End Sub

 

> ' 쉬트에 저장과 같은 처리결과를 설정한다.
>
> ' @@SheetMessageCheck()를 안하면 serl에 값이 안들어감
>
> Sub SheetMessageCheck()
>
> '@@ Call Form~ 무조건 있어야함
>
> Call Form1.ylwsh.MessageCheckSaveSheet(Form1.ylwsh_Data.value, \_ '@@ \_ =\> 한칸 띄워도 이어줌

2, msSOSerl, msSOSerl, \_

0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)

> Form1.ylwsh_Data.value = ""
>
> End Sub
>
> ' @@ 컨트롤에 대한 코드도움 설정
>
> Sub txtDeptNm_CodeHelp(IsDblClick)        ' 부서

 

 

> Dim arrRtnValue,strRtnSelCnt         
>
> If LoadCodeHelp(CH_NORMAL,"\<%=ConstHel        p.H_DEPT%\>", txtDeptNm.All(1), \_
>
> '@@ ========================= =\> 원래는 숫자인데 알아보기 편하게 명칭으로 작성
>
> '@@ d - ksystem - Common - Const - CodeHelp cs에 나와있음
>
> Nothing, Nothing, \_
>
> Nothing, Nothing, Nothing, Nothing, Nothing, Nothing, Nothing, arrRtnValue, \_
>
> '@@ 2 1
>
> '@@ 3 4 5 6 7 8 9
>
> IsDblClick, HCMD_NORMAL, "", strRtnSelCnt, \_
>
> "", "", "", "", "") = false then

Else

> End If
>
> End Sub

 

> Sub txtEmpNm_CodeHelp(IsDblClick)        ' 담당자

 

 

> Dim arrRtnValue,strRtnSelCnt         
>
> If LoadCodeHelp(CH_NORMAL,"\<%=ConstHelp.H_EMP%\>", txtEmpNm.All(1), \_
>
> Nothing, Nothing, \_
>
> Nothing, Nothing, Nothing, Nothing, Nothing, Nothing, Nothing, arrRtnValue, \_
>
> IsDblClick, HCMD_NORMAL, "", strRtnSelCnt, \_
>
> "", "", "", "", "") = false then

Else

> End If
>
> End Sub

 

> Sub txtCust2Nm_CodeHelp(IsDblClick)        ' 중개인

 

>  
>
> Dim arrRtnValue,strRtnSelCnt         
>
> If LoadCodeHelp(CH_NORMAL,"\<%=ConstHelp.D_CUST%\>", txtCust2Nm.All(1), \_
>
> Nothing, Nothing, \_
>
> Nothing, Nothing, Nothing, Nothing, Nothing, Nothing, Nothing, arrRtnValue, \_
>
> IsDblClick, HCMD_NORMAL, "", strRtnSelCnt, \_
>
> "", "", "", "", "") = false then

Else

> End If                                                        
>
> End Sub

 

> Sub txtCustNm_CodeHelp(IsDblClick)        ' 거래처

 

 

> Dim arrRtnValue,strRtnSelCnt         
>
> Dim strCustCodeCold
>
>  
>
> strCustCodeCold = txtCustNm.All(1).TextCode
>
> If LoadCodeHelp(CH_NORMAL,"\<%=ConstHelp.D_CUST%\>", txtCustNm.All(1), \_
>
> Nothing, Nothing, \_
>
> Nothing, Nothing, Nothing, Nothing, txtCustomerNo.All(1), Nothing, Nothing, arrRtnValue, \_
>
> '@@ ==================== 7번째 (=거래처번호)
>
> '@@ ==\> 거래처를 가져올 때 거래처번호도 같이 가져온다
>
> IsDblClick, HCMD_NORMAL, "", strRtnSelCnt, \_
>
> "", "", "", "", "") then
>
> If Trim(txtCustNm.All(1).TextCode) = "" Then
>
> Else
>
> Call GetCustInfo(txtCustNm.All(1).TextCode)
>
> End If
>
> If strCustCodeCold \<\> txtCustNm.All(1).TextCode Then
>
> Call fnPriceChange(1, Form1.ylwsh.DataRowCnt)
>
> End If        

Else

> End If                                                        
>
> End Sub
>
>  
>
> Sub txtCustomerNo_CodeHelp(IsDblClick)        ' 거래처번호

 

 

> Dim arrRtnValue,strRtnSelCnt
>
> Dim strCustCodeCold,strCustNmOld
>
> strCustCodeCold = txtCustNm.All(1).TextCode         
>
> strCustNmOld = txtCustNm.All(1).Value
>
> If LoadCodeHelp(CH_NORMAL,"\<%=ConstHelp.D_CUSTNO%\>", txtCustomerNo.All(1), \_
>
> Nothing, txtCustNm.All(1), \_
>
> Nothing, Nothing, Nothing, Nothing, Nothing, Nothing, Nothing, arrRtnValue, \_
>
> IsDblClick, HCMD_NORMAL, "", strRtnSelCnt, \_
>
> "", "", "", "", "") then
>
> If Trim(txtCustomerNo.All(1).TextCode) = "" Then
>
> txtCustNm.all(1).TextCode = strCustCodeCold
>
> txtCustNm.all(1).Text= strCustNmOld
>
> Else
>
> txtCustNm.all(1).TextCode = txtCustomerNo.all(1).TextCode
>
> Call GetCustInfo(txtCustomerNo.All(1).TextCode)
>
> End If

 

>  
>
>  
>
> If strCustCodeCold \<\> txtCustNm.All(1).TextCode Then
>
> Call fnPriceChange(1, Form1.ylwsh.DataRowCnt)
>
> End If                        

Else

> End If                                                        
>
> End Sub        

 

> Sub txtCurrNm_CodeHelp(IsDblClick)        ' 화폐
>
> Dim arrRtnValue,strRtnSelCnt
>
> If LoadCodeHelp(CH_NORMAL,"\<%=ConstHelp.A_CURR%\>", txtCurrNm.All(1), \_
>
> Nothing, Nothing, \_
>
> Nothing, Nothing, Nothing, Nothing, Nothing, Nothing, Nothing, arrRtnValue, \_
>
> IsDblClick, HCMD_NORMAL, "", strRtnSelCnt, \_
>
> "", "", "", "", "") = false then

Else

> End If
>
>  
>
> Call fnFloatDecimalPlaces(txtCurrNm.all(1).TextCode)

 

> Call fnGetCurrRate()

 

'                Dim i

'                Dim vntTemp

 

'                For i = 1 To Form1.ylwsh.DataRowCnt

'                        Call CalcOrderSheet(i, 9)

'                Next

 

> End Sub
>
>  

'        Sub datOrderDt\_\_ctl_onChange()

>  

'         Call fnGetCurrRate()

>  

'        End Sub

>  
>
> Sub fnGetCurrRate()
>
> Dim strSpNm
>
> Dim strTag
>
> Dim strParams
>
> Dim arrRtnData, strDate, strCurrCd
>
>  
>
> call parent.divScreenChgZIndex(true)                ' 작업 수행하는 동안 화면 전체 Lock작업(true, false - lock 풀어줌)
>
>  
>
> strDate = replace(datOrderDt.All(1).Value, "-", "")
>
>  
>
> strCurrCd = txtCurrNm.All(1).TextCode
>
>  
>
> strSpNm = "SSAGetCurrRate"
>
>  
>
> 'Parameter를 생성합니다.
>
> strParams = strParams + strSpNm + "'S' " + ",'" + \_
>
> strDate + "','" + \_
>
> strCurrCd + "'" + CNST_SP_LF
>
>  
>
> '생성한 Parameter로 저장후 결과값을 가져옵니다.(파라메타,CommandTimeOut)
>
> arrRtnData = fnComDB(strParams, 30, "Q")
>
>  
>
> If arrRtnData \<\> "" then
>
> fltExRate.All(1).SetValue(Trim(Split(arrRtnData,CNST_SP)(0)))
>
> End If
>
>  
>
> IsfltExRateChg = true
>
>  
>
> if parent.fnSerializeProc(true) = false then ' 순차적으로 실행되게 합니다.
>
> call parent.divScreenChgZIndex(false)
>
> exit Sub
>
> end if        
>
>  
>
> Call fltExRate\_\_ctl_onblur()
>
>  
>
> if parent.fnSerializeProc(false) = false then '순차적으로 실행되게 합니다.
>
> call parent.divScreenChgZIndex(false)
>
> exit Sub
>
> end if                         
>
>  
>
> call parent.divScreenChgZIndex(false)
>
> End Sub

 

> Sub fltExRate_CodeHelp(IsDblClick)
>
> Dim arrRtnValue
>
> Dim strParameter

 

> if IsDblClick = false then
>
> Call fltExRate\_\_ctl_onblur()
>
> exit sub
>
> End If

 

> strParameter = "ExRateDate=" + escape(replace(datOrderDt.all(1).value,"-","")) \_
>
> & "&CurrCd=" + escape(txtCurrNm.all(1).TextCode) \_
>
> & "&CurrNm=" + escape(txtCurrNm.all(1).Value)
>
>  
>
> arrRtnValue = LoadDlgForm(true,"DlgAAGetExRate",strParameter ,GetDlgData())

 

> if typename(arrRtnValue) = "String" And Trim(arrRtnValue) \<\> "Cancel" then
>
> Dim arrTemp
>
>  
>
> arrTemp = cdbl(arrRtnValue)
>
> fltExRate.all(1).SetValue(arrTemp)
>
> end if

 

> Call fltExRate\_\_ctl_onblur()
>
> End Sub
>
>  
>
> ' 쉬트에서 CodeHelp를 선택한 경우
>
> '@@ ShowDic - 시트 코드헬프 관리하는 부분 =\> case문으로 관리한다
>
> Sub ylwsh_ShowDic(Col, Row, NewCol, NewRow, Delete, IsDblClick)
>
> Dim arrRtnValue,strRtnSelCnt
>
> Dim ii        
>
> Dim vntTmp
>
> Dim varWhNm        
>
>  
>
> Select Case Col
>
>         Case Form1.ylwsh.colx(msItemNo)                '품번
>
>         If LoadCodeHelp(CH_NORMAL,"\<%=ConstHelp.D_GOODSNO%\>", Form1.ylwsh, \_
>
> msItemNm, msItemNo, \_
>
> Nothing, msItemcd, Nothing, msSize, msstkUnitNm, msStkUnitCd, Nothing, arrRtnValue, \_
>
> '@@ 2 1
>
> '@@ 3 4 5 6 7 8 9
>
> '@@ 키값은 무조건 4번째에 들어가있다
>
> IsDblClick, HCMD_NORMAL, "", strRtnSelCnt, \_
>
> "", "", "", "", "") then
>
> '@@ == == == == ==
>
> '@@ 마지막 5개는 제뉴인 파라미터처럼 (vntTmp)
>
> For ii = NewRow To NewRow + strRtnSelCnt - 1
>
> Form1.ylwsh.SetText Form1.ylwsh.ColX(msUnitNm), ii, ""
>
> Form1.ylwsh.SetText Form1.ylwsh.ColX(msUnitCd), ii, ""                
>
> Form1.ylwsh.CellText(msPriceDiv, ii) = "1"                                
>
> Next
>
> Call fnPriceChange(NewRow, NewRow + strRtnSelCnt - 1)
>
> Delete = true
>
> Else
>
> End If        

 

'                                For ii = 1 To Form1.ylwsh.DataRowCnt

'                                        Form1.ylwsh.GetText Form1.ylwsh.ColX(msStkCenter), ii, varWhNm

'

'                                        If Trim(varWhNm) = "" Then

'                                         Form1.ylwsh.GetText Form1.ylwsh.ColX(msStkCenter), ii, cmbWhNm.All(1).TextCode

'                                        End If

'                                Next                                        

 

>         Case Form1.ylwsh.colx(msItemNm)                '품명
>
>         If LoadCodeHelp(CH_NORMAL,"\<%=ConstHelp.D_GOODS%\>", Form1.ylwsh, \_
>
> msItemNo, msItemNm, \_
>
> Nothing, msItemcd, Nothing, msSize, msstkUnitNm, msStkUnitCd, Nothing, arrRtnValue, \_
>
> IsDblClick, HCMD_NORMAL, "", strRtnSelCnt, \_
>
> "", "", "", "", "") then
>
> For ii = NewRow To NewRow + strRtnSelCnt - 1
>
> Form1.ylwsh.SetText Form1.ylwsh.ColX(msUnitNm), ii, ""
>
> Form1.ylwsh.SetText Form1.ylwsh.ColX(msUnitCd), ii, ""                
>
> Form1.ylwsh.CellText(msPriceDiv, ii) = "1"                        
>
> Next
>
> Call fnPriceChange(NewRow, NewRow + strRtnSelCnt - 1)
>
> Delete = true                
>
> Else
>
> End If                        
>
>  
>
> Case Form1.ylwsh.colx(msSize)                '규격
>
>         If LoadCodeHelp(CH_NORMAL,"\<%=ConstHelp.D_GOODSDESC%\>", Form1.ylwsh, \_
>
> msItemNm, msSize, \_
>
> Nothing, msItemcd, Nothing, msItemNo, msstkUnitNm, msStkUnitCd, Nothing, arrRtnValue, \_
>
> IsDblClick, HCMD_NORMAL, "", strRtnSelCnt, \_
>
> "", "", "", "", "") then
>
> For ii = NewRow To NewRow + strRtnSelCnt - 1
>
> Form1.ylwsh.SetText Form1.ylwsh.ColX(msUnitNm), ii, ""
>
> Form1.ylwsh.SetText Form1.ylwsh.ColX(msUnitCd), ii, ""                
>
> Form1.ylwsh.CellText(msPriceDiv, ii) = "1"                        
>
> Next
>
> Call fnPriceChange(NewRow, NewRow + strRtnSelCnt - 1)
>
> Delete = true                
>
> Else
>
> End If                        
>
>  

'                                For ii = 1 To Form1.ylwsh.DataRowCnt

'                                        Form1.ylwsh.GetText Form1.ylwsh.ColX(msStkCenter), ii, varWhNm

'                        

'                                        If Trim(varWhNm) = "" Then

'                                         Form1.ylwsh.GetText Form1.ylwsh.ColX(msStkCenter), ii, cmbWhNm.All(1).TextCode

'                                        End If

'                                Next                                                                        

>  
>
>         Case Form1.ylwsh.colx(msUnitNm)                '단위
>
> Form1.ylwsh.GetText Form1.ylwsh.ColX(msItemCd), NewRow, vntTmp                 
>
>         
>
>         If LoadCodeHelp(CH_NORMAL,"\<%=ConstHelp.S_ITEMSALESUNIT%\>", Form1.ylwsh, \_
>
> Nothing, msUnitNm, \_
>
> Nothing, msUnitCd, Nothing, Nothing, Nothing, Nothing, Nothing, arrRtnValue, \_
>
> IsDblClick, HCMD_NORMAL, "", False, \_
>
> vntTmp, "1", "", "", "") then
>
> Call fnGetItemStkQty(NewRow)
>
> Call CalcOrderSheet(NewRow, 8)
>
> Delete = True                
>
> Else
>
> End If                
>
>  
>
>         Case Form1.ylwsh.colx(msDeliveryCust)                '납품처

 

> vntTmp = txtCustNm.all(1).TextCode
>
>         If LoadCodeHelp(CH_NORMAL,"\<%=ConstHelp.S_DELIVERYCUST%\>", Form1.ylwsh, \_
>
> Nothing, msDeliveryCust, \_
>
> Nothing, msDeliveryCustCd, Nothing, Nothing, Nothing, Nothing, Nothing, arrRtnValue, \_
>
> IsDblClick, HCMD_NORMAL, "", strRtnSelCnt, \_
>
> vntTmp, "", "", "", "") = false then
>
> Else
>
> End If                
>
>         Case Form1.ylwsh.colx(msCustItemNm)                '거래처품번

 

>          Dim strCustCd
>
> strCustCd = txtCustNm.All(1).TextCode
>
> If strCustCd = "" Then Exit Sub
>
>         
>
>         If LoadCodeHelp(CH_NORMAL,"\<%=ConstHelp.D_CUSTGOODSNM%\>", Form1.ylwsh, \_
>
> msItemNm, msCustItemNm, \_
>
> Nothing, msItemCd, Nothing, msItemNo, msSize, msstkUnitNm, msStkUnitCd, arrRtnValue, \_
>
> IsDblClick, HCMD_NORMAL, "", strRtnSelCnt, \_
>
> strCustCd, "", "", "", "") then                
>
> For ii = NewRow To NewRow + strRtnSelCnt - 1
>
> Form1.ylwsh.SetText Form1.ylwsh.ColX(msUnitNm), ii, ""
>
> Form1.ylwsh.SetText Form1.ylwsh.ColX(msUnitCd), ii, ""                
>
> Form1.ylwsh.CellText(msPriceDiv, ii) = "1"                        
>
> Next
>
> Call fnPriceChange(NewRow, NewRow + strRtnSelCnt - 1)
>
> Delete = true                
>
> Else
>
> End If                                                                                                                                
>
> End Select
>
>  
>
> End Sub        
>
>  
>
> '@@ ylwsh_Change = 시트 변경 있을 때 이벤트
>
> '@@ ex. 5행의 7번째 컬럼 변경 =\> Row=5 / Col=7이 들어간다
>
> Private Sub ylwsh_Change(Col, Row)
>
> If gstrOpen = True Then Exit Sub
>
> Dim vntKorprice
>
>  

if parent.fnSerializeProc(true) = false then ' 순차적으로 실행되게 합니다.

exit Sub

end if        

>  
>
> If gstrOpen = True Then Exit Sub
>
>  
>
> If Form1.ylwsh.EditCol = 0 Then Exit Sub

 

> If Form1.ylwsh.ColX(msPriceDiv) = Col Then
>
> If Form1.ylwsh.CellText(msPriceDiv, Row) = "9" Then
>
> Form1.ylwsh.CellText(msUnitPrice, Row) = 0
>
> Form1.ylwsh.CellText(msBasicPrice, Row) = 0
>
> Form1.ylwsh.CellText(msOptionPrice, Row) = 0
>
> Form1.ylwsh.CellText(msOriginPrice, Row) = 0
>
> Form1.ylwsh.CellText(msPrice, Row) = 0
>
>  
>
> Form1.ylwsh.CellText(msAmt, Row) = 0
>
> Form1.ylwsh.CellText(msVat, Row) = 0
>
> Form1.ylwsh.CellText(msSumAmt, Row) = 0
>
> Form1.ylwsh.CellText(msKorPrice, Row) = 0
>
> Form1.ylwsh.CellText(msKorAmt, Row) = 0
>
>  
>
> Call fnAfterProcCut
>
> End If
>
> 'Exit Sub
>
> End If
>
>  
>
> ' nType --\> 0: 공급단가 변경시
>
> ' 1: 수량 변경시
>
> ' 2: 부가세여부 변경시
>
> ' 3; 부가세, 공급금액 변경시
>
> ' 4: 기본단가, 옵션단가 변경시
>
> ' 5: 할인율 변경시
>
> ' 6: 할인단가 변경시
>
> ' 7: 원화단가 변경시
>
> If Form1.ylwsh.ColX(msUnitPrice) = Col Then '단위단가 변경

 

 

 

 

 

> Call fnGetItemStkQty(Row) '기본단가 다시 계산해옴
>
> Call CalcOrderSheet(Row, 8)
>
> 'Form1.ylwsh.EditCol = 0
>
> End If
>
>  
>
> If Form1.ylwsh.ColX(msKorPrice) = Col Then ' 원화단가
>
> If "\<%=\_vari.D_WONCURR%\>" = txtCurrNm.All(1).TextCode Or Trim(txtCurrNm.All(1).TextCode) = "" Then
>
> Form1.ylwsh.GetText Form1.ylwsh.ColX(msKorPrice), Row, vntKorprice
>
> Form1.ylwsh.SetText Form1.ylwsh.ColX(msPrice), Row, vntKorprice
>
> Call CalcOrderSheet(Row, 6) '원화인 경우는 먼저 원화단가를 할인단가에 쏴주고 시작
>
> Else
>
> Call CalcOrderSheet(Row, 7)
>
> End If
>
> 'Form1.ylwsh.EditCol = 0
>
> End If
>
> If Form1.ylwsh.ColX(msOriginPrice) = Col Then ' 공급단가
>
> Call CalcOrderSheet(Row, 0)
>
> 'Form1.ylwsh.EditCol = 0
>
> End If
>
> If (Form1.ylwsh.ColX(msBasicPrice) = Col Or Form1.ylwsh.ColX(msOptionPrice) = Col) Then ' 기본단가, 옵션단가
>
> Call CalcOrderSheet(Row, 4)
>
> 'Form1.ylwsh.EditCol = 0
>
> End If
>
>  
>
> If Form1.ylwsh.ColX(msAmt) = Col Then ' 공급금액
>
> Call CalcOrderSheet(Row, 11)
>
> 'Form1.ylwsh.EditCol = 0
>
> End If
>
> If Form1.ylwsh.ColX(msVat) = Col Then ' 부가세

 

 

 

 

> Call CalcOrderSheet(Row, 3)
>
> 'Form1.ylwsh.EditCol = 0
>
> End If
>
> If Form1.ylwsh.ColX(msQty) = Col Then ' 수량
>
> Call fnGetItemStkQty(Row)
>
>  
>
> Call CalcOrderSheet(Row, 1)
>
> 'Form1.ylwsh.EditCol = 0
>
> End If
>
> If Form1.ylwsh.ColX(msVatClss) = Col Then ' 부가세여부(기준원화가 아닐 경우에도 부가세 계산 되도록 수정)

'         If "\<%=\_vari.D_WONCURR%\>" = txtCurrNm.All(1).TextCode Or Trim(txtCurrNm.All(1).TextCode) = "" Then

'         Call CalcOrderSheet(Row, 2)

'         Else

'         If Form1.ylwsh.CellText(Form1.ylwsh.ColX(msVatClss), Form1.ylwsh.ActiveRow) = "0" Then

'         Form1.ylwsh.SetText Form1.ylwsh.ColX(msVatClss), Form1.ylwsh.ActiveRow, "1"

'         Else

'         Form1.ylwsh.SetText Form1.ylwsh.ColX(msVatClss), Form1.ylwsh.ActiveRow, "0"

'         End If

'         End If

> Call CalcOrderSheet(Row, 2)
>
> End If
>
> If Form1.ylwsh.ColX(msDCRate) = Col Then ' 할인율

 

> Call CalcOrderSheet(Row, 5)
>
> 'Form1.ylwsh.EditCol = 0
>
> End If
>
> If Form1.ylwsh.ColX(msPrice) = Col Then ' 할인단가
>
> Call CalcOrderSheet(Row, 6)
>
> 'Form1.ylwsh.EditCol = 0
>
> End If

if parent.fnSerializeProc(false) = false then '순차적으로 실행되게 합니다.

exit Sub

end if        

 

> End Sub
>
>  
>
> '차수 등록
>
> Private Sub cmdRev_OnClick()
>
> If Trim(txtOrderNo.All(1).Value) = "" Then Exit Sub        
>
> Call Save("RV")
>
> End Sub        
>
>  

'        '일괄 창고 입력 (2004.8.31 k2에서 물류센터로 바뀌면서 삭제)

'        Private Sub cmdWhNm_OnClick()                

'                Dim objSalesCommFn

'                set objSalesCommFn = CreateObject("YlwCommonSales.clsCommonSales")        

'        

'                If cmbWhNm.All(1).Value \<\> "" Then

'                        Call objSalesCommFn.fnDataIntoSheet(Form1.ylwsh, cmbWhNm.All(1).Value, msStkCenter)

'                End If

'                Set objSalesCommFn = Nothing

'        End Sub                        

>  
>
> '가용재고 Check
>
> Private Sub cmdChkAvailStock_OnClick()
>
> Dim objSalesCommFn
>
>  
>
> IF Form1.ylwsh.DataRowCnt = 0 then Exit Sub
>
>  
>
> set objSalesCommFn = CreateObject("YlwCommonSales.clsCommonSales")        
>
> If objSalesCommFn.fnAvailStockCheck2(Form1.ylwsh, m_strHostInfo, \_
>
> cmbAccUnit.All(1).Value, replace(datOrderDt.All(1).Value, "-", ""), \_
>
> msItemCd, msStkCenter, msAvailStock) = False Then
>
> End If
>
> Set objSalesCommFn = Nothing

 

> End Sub        
>
>  
>
> '환율 정보
>
> Sub fltExRate\_\_ctl_onblur()
>
> If IsfltExRateChg = false Then Exit Sub
>
> If fltExRate.All(1).Value = "" Or fltExRate.All(1).Value = 0 Then fltExRate.All(1).SetValue(1)

 

> Dim nRow
>
> Dim vHeader
>
> If fltExRate.All(1).Value \<\> "" Or fltExRate.All(1).Value \<\> 0 Then
>
> For nRow = 1 To Form1.ylwsh.DataRowCnt Step 1
>
> Call CalcOrderSheet(nRow, 9)
>
> Form1.ylwsh.GetText SS_HEADER, nRow, vHeader
>
> If vHeader \<\> SSHD_ADD Then
>
> Form1.ylwsh.SetText SS_HEADER, nRow, SSHD_UPDATE
>
> End If
>
> Next
>
> End If
>
> End Sub        
>
>  
>
> Sub fltExRate\_\_ctl_OnChange()
>
> IsfltExRateChg = true
>
> End Sub
>
>  
>
> '할인율 변경 할때(적용 안됨)
>
> Private Sub fltDCRate\_\_ctl_onblur()
>
> Dim nRow
>
> Dim vntTmp
>
> Dim vntPrice
>
> Dim vntKorprice
>
> Dim vntQty
>
> Dim vntDCRate
>
> Dim vntHeader

 

> vntDCRate = fltDCRate.All(1).Value
>
> For nRow = 1 To Form1.ylwsh.DataRowCnt Step 1
>
> Form1.ylwsh.SetText Form1.ylwsh.ColX(msDCRate), nRow, vntDCRate
>
> Call CalcOrderSheet(nRow, 5)
>
> Form1.ylwsh.GetText SS_HEADER, nRow, vntHeader
>
> If vntHeader \<\> SSHD_ADD Then
>
> Form1.ylwsh.SetText SS_HEADER, nRow, SSHD_UPDATE
>
> End If
>
> Next
>
> End Sub                

 

'단가 적용        

> Private Sub cmdPriceChange_OnClick()
>
> Call fnPriceChange(1, Form1.ylwsh.DataRowCnt)
>
> End Sub                                        
>
>  
>
> Sub fnFloatDecimalPlaces(strCurrCd)                        'Sheet 칼럼 자리수 설정
>
> Dim FloatDecimalPlacesAmt, FloatDecimalPlacesCost, objylwsh

 

> If Trim(txtCurrNm.all(1).TextCode) = "" Then
>
> txtCurrNm.all(1).TextCode        = "\<%=\_vari.D_WONCURR%\>"
>
> txtCurrNm.all(1).Value                = "\<%=\_vari.D_WONCURR%\>"
>
> strCurrCd                                        = "\<%=\_vari.D_WONCURR%\>"
>
> End If

 

> If Trim(strCurrCd) = Trim("\<%=\_vari.D_WONCURR%\>") Then
>
> FloatDecimalPlacesAmt = \<%=this.Session\["GoodsWonAmt"\].ToString()%\>
>
> FloatDecimalPlacesCost = \<%=this.Session\["GoodsWonCost"\].ToString()%\>
>
> Else
>
> FloatDecimalPlacesAmt = \<%=this.Session\["GoodsForAmt"\].ToString()%\>
>
> FloatDecimalPlacesCost = \<%=this.Session\["GoodsForCost"\].ToString()%\>
>
> End If
>
>  
>
> 'Dim objSalesCommFn
>
> 'set objSalesCommFn = CreateObject("YlwCommonSales.clsCommonSales")
>
>  
>
> 'Call objSalesCommFn.SetFloatDecimalPlaces(Form1.ylwsh, cint(FloatDecimalPlacesAmt), msAmt)
>
> 'Call objSalesCommFn.SetFloatDecimalPlaces(Form1.ylwsh, cint(FloatDecimalPlacesAmt), msSumAmt)
>
> 'Call objSalesCommFn.SetFloatDecimalPlaces(Form1.ylwsh, cint(FloatDecimalPlacesCost), msUnitPrice)
>
> 'Call objSalesCommFn.SetFloatDecimalPlaces(Form1.ylwsh, cint(FloatDecimalPlacesCost), msBasicPrice)
>
> 'Call objSalesCommFn.SetFloatDecimalPlaces(Form1.ylwsh, cint(FloatDecimalPlacesCost), msOptionPrice)
>
> 'Call objSalesCommFn.SetFloatDecimalPlaces(Form1.ylwsh, cint(FloatDecimalPlacesCost), msOriginPrice)
>
> 'Call objSalesCommFn.SetFloatDecimalPlaces(Form1.ylwsh, cint(FloatDecimalPlacesCost), msPrice)
>
> 'Set objSalesCommFn = Nothing
>
> set objylwsh = Form1.ylwsh.GetSheet
>
> Form1.ylwsh.Col = Form1.ylwsh.ColX(msAmt)
>
> Form1.ylwsh.Row = -1
>
> objylwsh.TypeFloatDecimalPlaces = cint(FloatDecimalPlacesAmt)

 

> Form1.ylwsh.Col = Form1.ylwsh.ColX(msSumAmt)
>
> Form1.ylwsh.Row = -1
>
> objylwsh.TypeFloatDecimalPlaces = cint(FloatDecimalPlacesAmt)

 

> Form1.ylwsh.Col = Form1.ylwsh.ColX(msUnitPrice)
>
> Form1.ylwsh.Row = -1
>
> objylwsh.TypeFloatDecimalPlaces = cint(FloatDecimalPlacesCost)

 

> Form1.ylwsh.Col = Form1.ylwsh.ColX(msBasicPrice)
>
> Form1.ylwsh.Row = -1
>
> objylwsh.TypeFloatDecimalPlaces = cint(FloatDecimalPlacesCost)

 

> Form1.ylwsh.Col = Form1.ylwsh.ColX(msOptionPrice)
>
> Form1.ylwsh.Row = -1
>
> objylwsh.TypeFloatDecimalPlaces = cint(FloatDecimalPlacesCost)

 

> Form1.ylwsh.Col = Form1.ylwsh.ColX(msOriginPrice)
>
> Form1.ylwsh.Row = -1
>
> objylwsh.TypeFloatDecimalPlaces = cint(FloatDecimalPlacesCost)

 

> Form1.ylwsh.Col = Form1.ylwsh.ColX(msPrice)
>
> Form1.ylwsh.Row = -1
>
> objylwsh.TypeFloatDecimalPlaces = cint(FloatDecimalPlacesCost)
>
>  
>
> Form1.ylwsh.Col = Form1.ylwsh.ColX(msVat)
>
> Form1.ylwsh.Row = -1
>
> objylwsh.TypeFloatDecimalPlaces = cint(FloatDecimalPlacesAmt)                
>
>  
>
> set objylwsh = nothing                                        

 

> End Sub        
>
>  
>
> '단가 적용
>
> Private Function fnPriceChange( nStartRow, nEndRow)
>
>  
>
> fnPriceChange = true
>
> Dim objSalesCommFn
>
> set objSalesCommFn = CreateObject("YlwCommonSales.clsCommonSales")
>
> fnPriceChange = objSalesCommFn.fnPriceChange2( \_
>
> Form1.ylwsh, m_strHostInfo, nStartRow, nEndRow, \_
>
> txtCustNm.all(1).TextCode, txtCurrNm.all(1).TextCode, \_
>
> Trim(cmbAccUnit.all(1).value), txtDeptNm.all(1).TextCode, \_
>
> datOrderDt.all(1).Value, \_
>
> msItemCd, msUnitCd, msStkUnitCd, msQty, \_
>
> msBasicPrice, msVatClss, msStkQty, msVatRate, \_
>
> msUnitCd, msUnitNm, msStkCenter, msPriceUnitCd, \_
>
> msPriceUnitNm, msPriceUnitQty, msUnitPrice, \_
>
> msStdCost, msTotCost, msStdSalesPrice, \_
>
> msCustomPrice, msMinPrice)                
>
> Set objSalesCommFn = Nothing

 

> ' 시트 변경

 

 

> Dim lngRow
>
> If fnPriceChange = true Then
>
> For lngRow = nStartRow To nEndRow
>
> Call CalcOrderSheet(lngRow, 8)
>
> Next
>
> End If
>
> Exit Function

 

 

> fnPriceChange = false
>
> Set objSalesCommFn = Nothing
>
> End Function        
>
>  
>
> '재고단위수량
>
> Private Function fnGetItemStkQty(lngRow)
>
> fnGetItemStkQty = True
>
>  
>
> Dim objSalesCommFn
>
> set objSalesCommFn = CreateObject("YlwCommonSales.clsCommonSales")                

 

> fnGetItemStkQty = objSalesCommFn.fnGetItemStkQty( \_
>
> Form1.ylwsh, m_strHostInfo, lngRow, \_
>
> msItemCd, msUnitCd, msStkUnitCd, msQty, msPriceUnitCd, \_
>
> msUnitPrice, msStkQty, msPriceUnitQty, msBasicPrice, msPriceUnitNm)

 

> Set objSalesCommFn = Nothing
>
> End Function        
>
>  
>
> '거래처별 담당자 등록(거래처 코드도움시)
>
> Private Sub GetCustInfo(strCust)
>
>  
>
> Dim objSalesCommFn
>
> set objSalesCommFn = CreateObject("YlwCommonSales.clsCommonSales")                        
>
> Call objSalesCommFn.GetCustInfo(m_strHostInfo, strCust, Rtrim(cmbAccUnit.All(1).Value), \_
>
> txtDeptNm.All(1), txtEmpNm.All(1))
>
> Set objSalesCommFn = Nothing
>
> End Sub        
>
>  
>
> 'Sheet 계산
>
> Sub CalcOrderSheet(nSheetRow, nType)

 

> If gstrOpen = True Then Exit Sub

 

> If CDbl(fltExRate.All(1).Value) = 0 Then
>
> fltExRate.All(1).SetValue(1)
>
> End If
>
> If txtCurrNm.All(1).Value = "" Then
>
> txtCurrNm.All(1).Value = "\<%=\_vari.D_WONCURR%\>"
>
> txtCurrNm.All(1).TextCode = "\<%=\_vari.D_WONCURR%\>"
>
> End If
>
> Dim objSalesCommFn
>
> set objSalesCommFn = CreateObject("YlwCommonSales.clsCommonSales")

 

> Dim strPointType
>
> '금액 0:절사 , 1:반올림

 

> strPointType="\<%=this.Session\["PointType"\]%\>"
>
> if strPointType="0" then
>
> strPointType="-1"
>
> Else
>
> strPointType="0"
>
> End if
>
> 'strPointType, \_
>
> Call objSalesCommFn.SetSalesData(Form1.hidSalesCommon.value)
>
> 'Private Const m_strHostInfo = "[http://localhost/~,KSystem.Net/~,Common/Form/CodeHelp/FrmCodeHelp.aspx~,Common/Form/ProcForm/FrmProcForm.aspx~,SrErp3\|0\|\|](http://localhost/~,KSystem.Net/~,Common/Form/CodeHelp/FrmCodeHelp.aspx~,Common/Form/ProcForm/FrmProcForm.aspx~,SrErp3|0||)"
>
> 'm_strHostInfo은 경로 값..
>
> Call objSalesCommFn.CalcSheet(nSheetRow, cint(nType), Form1.ylwsh, m_strHostInfo, cstr(txtCurrNm.All(1).TextCode), fltExRate.All(1).Value, \_
>
> msItemNm, msQty, msPriceUnitQty, msUnitPrice, msPrice, msKorPrice, msAmt, msKorAmt, msSumAmt, \_
>
> msOptionPrice, msBasicPrice, msVatClss, msVatRate, msVat, msOriginPrice, msDCRate,0,0,0,0,strPointType)
>
> Set objSalesCommFn = Nothing

 

> '''''''' 추가 부분(Local 시 부가세 0로)
>
> Dim vntRepAmt, vntKorprice, vntQty
>
> If GetOptionData(Form1, "optExpClss") \<\> "1" Then                '옵션값 가지고 올때.
>
> Form1.ylwsh.SetText Form1.ylwsh.ColX(msVat), nSheetRow, 0
>
> Form1.ylwsh.GetText Form1.ylwsh.ColX(msAmt), nSheetRow, vntRepAmt
>
> Form1.ylwsh.GetText Form1.ylwsh.ColX(msKorPrice), nSheetRow, vntKorprice
>
> Form1.ylwsh.GetText Form1.ylwsh.ColX(msQty), nSheetRow, vntQty
>
> Form1.ylwsh.SetText Form1.ylwsh.ColX(msSumAmt), nSheetRow, vntRepAmt
>
> If nType = 7 Then
>
> Form1.ylwsh.SetText Form1.ylwsh.ColX(msKorAmt), nSheetRow, ReNumber(vntKorprice \* vntQty, \<%=Session\["GoodsWonAmt"\]%\>,true)
>
> Else
>
> Form1.ylwsh.SetText Form1.ylwsh.ColX(msKorAmt), nSheetRow, ReNumber((vntRepAmt \* CDbl(fltExRate.All(1).Value)), \<%=Session\["GoodsWonAmt"\]%\>, 0, true)
>
> End If
>
> End If

 

> Call fnAfterProcCut

 

> End Sub        

 

> Sub fnAfterProcCut()
>
> fltTotSupplyAmt.All(1).SetValue(Form1.ylwsh.GetSumCols(Form1.ylwsh.ColX(msAmt)))
>
> fltTotTaxAmt.All(1).SetValue(Form1.ylwsh.GetSumCols(Form1.ylwsh.ColX(msVat)))
>
> fltTotalAmt.All(1).SetValue(CDbl(fltTotSupplyAmt.All(1).Value) + CDbl(fltTotTaxAmt.All(1).Value))
>
> End Sub

 

> Sub ChkFixYn_OnClick()
>
> If "\<%=\_vari.S_CONFIRMSAORDER%\>" \<\> "1" Then Exit Sub

 

> If txtOrderNo.all(1).Value = "" Then '' 신규등록인 경우
>
> If Form1.ChkFixYn.Checked = true Then
>
> If trim("\<%=vntConfirmOkSecu%\>") \<\>"1" Then
>
> MessageBoxShow("\<%=\_page.GetMessageString(ConstMessage.USERCONFIRMOK, "확정 처리 권한이 없는 사용자 입니다.")%\>")
>
> Form1.ChkFixYn.Checked = true
>
> Else
>
> 'Form1.ChkFixYn.Checked = true
>
> End If
>
> Else
>
> 'Form1.ChkFixYn.Checked = false
>
> End If
>
> Else '' 조회된 데이타에 대해서 확정,확정취소처리 하는 경우
>
> If Form1.ChkFixYn.Checked = true Then
>
> If trim("\<%=vntConfirmOkSecu%\>") \<\>"1" Then
>
> MessageBoxShow("\<%=\_page.GetMessageString(ConstMessage.USERCONFIRMOK, "확정 처리 권한이 없는 사용자 입니다.")%\>")
>
> Form1.ChkFixYn.Checked = false
>
> Else
>
> 'Form1.ChkFixYn.Checked = true
>
>  
>
> If IsDataChanged() = True And Form1.ylwsh.ChangedCount \> 0 Then ' 데이터 변경여부 확인

                                        Dim bulbtn

> bulBtn = MessageBox("내용이 변경되었습니다. 저장하시겠습니까?", vbYesNo) ' 데이터가 변경되었습니다. + VbLf + 저장하시겠습니까?
>
>  
>
> If bulBtn = vbYes then
>
> Form1.ChkFixYn.Checked = False
>
> Call Save("")
>
>  
>
> Exit Sub
>
> End If
>
>  
>
> Form1.ChkFixYn.Checked = true
>
> End If
>
>  
>
>  
>
> Call fnConfirm
>
> End If
>
> ElseIf Form1.ChkFixYn.Checked = false Then
>
> If trim("\<%=vntConfirmCanSecu%\>") \<\>"1" Then
>
> MessageBoxShow("\<%=\_page.GetMessageString(ConstMessage.USERCONFIRMCANCEL, "확정 취소 권한이 없는 사용자 입니다.")%\>")
>
> Form1.ChkFixYn.Checked = true
>
> Else
>
> 'Form1.ChkFixYn.Checked = false
>
> Call fnConfirm
>
> End If
>
> End If
>
> End If
>
> datOrderDt.all(1).Focus
>
> End Sub

 

> Sub fnConfirm()
>
> Dim szWorkingTag ' C : 확정처리, U : 확정취소처리
>
> Dim strSpNm
>
> Dim strTag
>
> Dim strParams
>
> Dim arrRtnData

 

> If Form1.ChkFixYn.Checked = true Then
>
> szWorkingTag = "C" '' 확정처리
>
> Else
>
> szWorkingTag = "U" '' 확정취소처리
>
> End If

 

> strSpNm = "SSASalesOrderConfirm"

 

> 'Parameter를 생성합니다.
>
> strParams = strParams + strSpNm + " '" + szWorkingTag + "' " + ",'" + \_
>
> cmbAccUnit.all(1).Value + "','" + \_
>
> txtOrderNo.all(1).Value + "','" + \_
>
> "\<%=\_page.EmpID%\>" + "'" + CNST_SP_LF

 

> '생성한 Parameter로 저장후 결과값을 가져옵니다.(파라메타,CommandTimeOut)
>
> arrRtnData = fnComSave(strParams, 30)
>
>  

 

> If arrRtnData \<\> "" then
>
> If Trim(ucase(Split(arrRtnData,CNST_SP)(2))) \<\> "#ERROR" Then
>
> if Split(arrRtnData,CNST_SP)(2) \<\> "" then
>
> datFixDate.all(1).Value = left(Split(arrRtnData,CNST_SP)(2),4) + "-" + Mid(Split(arrRtnData,CNST_SP)(2),5,2) + "-" + right(Split(arrRtnData,CNST_SP)(2),2)
>
> else
>
> datFixDate.all(1).Value = ""
>
> end if
>
> txtFixEmpNo.all(1).Value = Split(arrRtnData,CNST_SP)(3)
>
> call MessageBoxShow(Split(arrRtnData,CNST_SP)(1))
>
> Else
>
> If Form1.ChkFixYn.Checked = true Then
>
> Form1.ChkFixYn.Checked = false
>
> Else
>
> Form1.ChkFixYn.Checked = true
>
> End If
>
> call MessageBoxShow(Split(arrRtnData,CNST_SP)(1))
>
> End If
>
> End If

 

> End Sub

 

> Sub cmdStockList_OnClick()        ' 재고상세현황
>
> 'LoadDlgForm(모달여부,폼ID,Parameter,폼정보)
>
> '폼ID는 여러Dialog중 Open할 폼ID를 기입한다.
>
> 'Parameter(QueryString)는 =과&를 구분자로 만든다 ex) "CustID=11&CustNm=홍길동"
>
> 'GetDlgData():폼로드시 가져온 Dialog정보를 가져온다.
>
> Dim arrRtnValue
>
> Dim strParameter
>
> Dim i
>
> Dim varTemp, varWhcd, varQty, vntRowNo, vntItemCd, vntWhCd, vntQty, vntAccUnitMti

 

If Form1.ylwsh.DataRowCnt = 0 Then Exit Sub

 

For i = 1 To Form1.ylwsh.DataRowCnt Step 1

Form1.ylwsh.GetText Form1.ylwsh.ColX(msItemCd), i, varTemp

Form1.ylwsh.GetText Form1.ylwsh.ColX(msStkCenter), i, varWhcd

Form1.ylwsh.GetText Form1.ylwsh.ColX(msStkQty), i, varQty

 

> if varQty = "" then
>
> varQty = 0
>
> end if

If i = 1 Then

vntRowNo = Cstr(i)

vntItemCd = varTemp

vntWhCd = Right(varWhcd, 2)

vntQty = cstr(varQty)

vntAccUnitMti = cmbAccUnit.all(1).Value

Else

vntRowNo = vntRowNo & "\_/" & cstr(i)

vntItemCd = vntItemCd & "\_/" & varTemp

vntWhCd = vntWhCd & "\_/" & Right(varWhcd, 2)

vntQty = vntQty & "\_/" & varQty

vntAccUnitMti = vntAccUnitMti & "\_/" & cmbAccUnit.all(1).Value

End If

Next

 

strParameter ="DeptCd=" + vntAccUnitMti \_

> & "&RowCount=" + escape(cstr(Form1.ylwsh.DataRowCnt)) \_
>
> & "&RowNo=" + escape(vntRowNo) \_
>
> & "&Qty=" + escape(vntQty) \_
>
> & "&ItemCd=" + escape(vntItemCd) \_
>
> & "&WhCd=" + escape(vntWhCd) \_
>
> & "&Date=" + escape(Replace(datOrderDt.all(1).Value, "-", ""))

 

> 'Dlg종료후 Return받은값

 

 

> arrRtnValue = LoadDlgForm(true,"DlgSAItemStock2",strParameter ,GetDlgData())

 

> Dim arrTemp
>
> arrTemp = split(arrRtnValue,CNST_SP)
>
>  
>
>  
>
> dim strJumpMsg
>
> strJumpMsg = arrRtnValue

 

> Dim RowNo(), WhCd(), intSheetMax, intSheetIndex, intDeli
>
> Dim strCode, cnt
>
> Dim szWHValue, strTemp

 

> If Trim(strJumpMsg) \<\> "" Then
>
> if JumpStringToSplit(strJumpMsg, szWHValue) = True Then
>
> intSheetMax = UBound(szWHValue, 1)
>
> For intSheetIndex = 1 To intSheetMax
>
> Select Case szWHValue(intSheetIndex, 1)
>
> Case "WhCd"
>
> strTemp = szWHValue(intSheetIndex, 2)
>
> cnt = 0
>
> Do While True
>
> intDeli = InStr(1, strTemp, "\_/", vbTextCompare)
>
> If intDeli \> 0 Then
>
> strCode = Trim(Mid(strTemp, 1, intDeli - 1))
>
> strTemp = Mid(strTemp, intDeli + 2, Len(strTemp) - intDeli)
>
> Else
>
> strCode = strTemp
>
> strTemp = ""
>
> End If
>
> cnt = cnt + 1
>
> 'WhCd(cnt) = strCode
>
> Form1.ylwsh.Celltext(msStkCenter, cnt) = strCode
>
> Form1.ylwsh.GetText SS_HEADER, cnt, strCode
>
>  
>
> If Trim(strCode) = "" then
>
> Form1.ylwsh.SetText SS_HEADER, cnt, SSHD_UPDATE
>
> End If                                                

 

> If Trim(strTemp) = "" Then Exit Do
>
> Loop
>
> End Select
>
> Next
>
> End If
>
> End If
>
> end sub
>
>  
>
> Sub CmdStkCenter_onClick()
>
> dim i
>
> For i = 1 to form1.ylwsh.DataRowCnt
>
> Form1.ylwsh.Celltext(msStkCenter, i) = cmbStkCenter.All(1).value
>
> if Form1.ylwsh.Celltext(0, i) \<\> SSHD_ADD then
>
> Form1.ylwsh.Celltext(0, i) = SSHD_UPDATE
>
> end if
>
> Next
>
> End Sub
>
>  
>
> '예상이익
>
> Sub cmdEstProfit_onClick()
>
> dim arrRtnValue, strParameter, i
>
>  
>
> Dim vntRowNo
>
> Dim vntItemCd
>
> Dim vntQty
>
> Dim vntItemCdTmp

Dim vntUnitCd

Dim vntPrice

Dim vntAmt

> Dim vntItemNm
>
> Dim vntItemNo

Dim vntSalesStdCost

Dim vntTotalStdCost

Dim vntPriceTmp

Dim vntQtyTmp

Dim vntAmtTmp

Dim vntSalesStdCostTmp

Dim vntTotalStdCostTmp

Dim vntUnitCdTmp

Dim vntItemNmTmp

Dim vntItemNoTmp

 

If Form1.ylwsh.DataRowCnt = 0 Then Exit Sub

 

For i = 1 To Form1.ylwsh.DataRowCnt

Form1.ylwsh.GetText Form1.ylwsh.ColX(msItemCd), i, vntItemCdTmp

Form1.ylwsh.GetText Form1.ylwsh.ColX(msKorPrice), i, vntPriceTmp

Form1.ylwsh.GetText Form1.ylwsh.ColX(msStkQty), i, vntQtyTmp

Form1.ylwsh.GetText Form1.ylwsh.ColX(msKorAmt), i, vntAmtTmp

Form1.ylwsh.GetText Form1.ylwsh.ColX(msStdCost), i, vntSalesStdCostTmp

Form1.ylwsh.GetText Form1.ylwsh.ColX(msTotCost), i, vntTotalStdCostTmp

Form1.ylwsh.GetText Form1.ylwsh.ColX(msUnitCd), i, vntUnitCdTmp

Form1.ylwsh.GetText Form1.ylwsh.ColX(msItemNm), i, vntItemNmTmp

Form1.ylwsh.GetText Form1.ylwsh.ColX(msItemNo), i, vntItemNoTmp

 

If i = 1 Then

vntRowNo = cstr(i)

vntItemCd = vntItemCdTmp

 

vntPrice = vntPriceTmp

vntQty = vntQtyTmp

vntAmt = vntAmtTmp

vntSalesStdCost = vntSalesStdCostTmp

vntTotalStdCost = vntTotalStdCostTmp

vntUnitCd = vntUnitCdTmp

vntItemNm = vntItemNmTmp

vntItemNo = vntItemNoTmp

Else

vntRowNo = vntRowNo & "\_/" & cstr(i)

vntItemCd = vntItemCd & "\_/" & vntItemCdTmp

vntUnitCd = vntUnitCd & "\_/" & vntUnitCdTmp

vntPrice = vntPrice & "\_/" & vntPriceTmp

vntQty = vntQty & "\_/" & vntQtyTmp

vntAmt = vntAmt & "\_/" & vntAmtTmp

vntSalesStdCost = vntSalesStdCost & "\_/" & vntSalesStdCostTmp

vntTotalStdCost = vntTotalStdCost & "\_/" & vntTotalStdCostTmp

vntItemNm = vntItemNm & "\_/" & vntItemNmTmp

vntItemNo = vntItemNo & "\_/" & vntItemNoTmp

End If

Next

> strParameter = "&CurrCd=" & escape(txtCurrNm.All(1).TextCode) \_

& "&RowCount=" & escape(cstr(Form1.ylwsh.DataRowCnt)) \_

& "&RowNo=" & escape(vntRowNo) \_

& "&ItemCd=" & escape(vntItemCd) \_

& "&Price=" & escape(vntPrice) \_

& "&Qty=" & escape(vntQty) \_

& "&UnitCd=" & escape(vntUnitCd) \_

& "&Amt=" & escape(vntAmt) \_

& "&SalesStdCost=" & escape(vntSalesStdCost) \_

& "&TotalStdCost=" & escape(vntTotalStdCost) \_

& "&CustNm=" & escape(txtCustNm.All(1).value) \_

& "&ItemNm=" & escape(vntItemNm) \_

& "&ItemNo=" & escape(vntItemNo) \_

> arrRtnValue = LoadDlgForm(true,"dlgSAEstProfit",strParameter ,GetDlgData())
>
> end Sub
>
>  
>
> Sub ylwsh_ButtonClicked(Col, Row, ButtonDown)
>
> if Col \<\> form1.ylwsh.ColX(msDeliveryCustBtn) then exit sub
>
> If Form1.ylwsh.DataRowCnt \< Row Then Exit Sub

 

> dim arrRtnValue, arrRtn, strJumpMsg
>
> Dim vntDelvCustNm
>
> Dim vntDelvCustcd
>
> Form1.ylwsh.GetText Form1.ylwsh.ColX(msDeliveryCust), Form1.ylwsh.ActiveRow, vntDelvCustNm
>
> Form1.ylwsh.GetText Form1.ylwsh.ColX(msDeliveryCustCd), Form1.ylwsh.ActiveRow, vntDelvCustcd
>
> strJumpMsg = "&CustNm=" & escape(txtCustNm.All(1).value) \_
>
> & "&CustCd=" & escape(txtCustNm.All(1).TextCode) \_
>
> & "&DelvCustNm=" & escape(CStr(vntDelvCustNm)) \_
>
> & "&DelvCustCd=" & escape(CStr(vntDelvCustcd))
>
> arrRtnValue = LoadDlgForm(true,"dlgSBDelvCust",strJumpMsg ,GetDlgData())
>
> if arrRtnValue = false then
>
> exit Sub
>
> elseif JumpStringToSplit(arrRtnValue, arrRtn) = True Then
>
> Form1.ylwsh.Celltext(msDeliveryCust, Row) = arrRtn(0,2)
>
> Form1.ylwsh.Celltext(msDeliveryCustCd, Row) = arrRtn(1,2)
>
> if vntDelvCustcd \<\> arrRtn(1,2) then
>
> If Form1.ylwsh.Celltext(0, Row) \<\> SSHD_ADD Then                '신규일때는 Update모드로 바꿔줄 필요없음
>
> Form1.ylwsh.Celltext(0, Row) = SSHD_UPDATE
>
> End If
>
> end if
>
> end if

 

> end Sub

 

> Sub ylwsh_Click(Col, Row)
>
> Dim varHeader
>
> Dim varItemCd
>
>  
>
> If "\<%=\_vari.S_SALESOPTION%\>" = "0" Then
>
> Exit Sub
>
> End If
>
>  

 

> If Col \<\> Form1.ylwsh.ColX(msOption) Then exit sub

 

> Form1.ylwsh.GetText SS_HEADER, Row, varHeader
>
> Form1.ylwsh.GetText Form1.ylwsh.ColX(msItemCd), Row, varItemCd

 

> If varHeader = SSHD_ADD Or Trim(varItemCd) = "" or row = 0 Then Exit Sub

 

> 'LoadDlgForm(모달여부,폼ID,Parameter,폼정보)
>
> '폼ID는 여러Dialog중 Open할 폼ID를 기입한다.
>
> 'Parameter(QueryString)는 =과&를 구분자로 만든다 ex) "CustID=11&CustNm=홍길동"
>
> 'GetDlgData():폼로드시 가져온 Dialog정보를 가져온다.
>
> Dim arrRtnValue
>
> Dim strParameter

 

> Dim varTemp
>
> varTemp = Form1.ylwsh.CellText(msOption, Row)
>
> If Trim(varTemp) = lblOption.innerText Then '"옵션있음"
>
> varTemp = "1"
>
> Else
>
> varTemp = "0"
>
> End If

 

> 'Dlg에 넘길 Parameter :Get방식으로 1000여자 정도 넘길수 있다.
>
> strParameter = "QutoOrSO=" + "O" \_
>
> & "&SONo=" + escape(txtOrderNo.all(1).Value) \_
>
> & "&SORev=" + escape(txtRev.all(1).Value) \_
>
> & "&SOSerl="+ Form1.ylwsh.CellText(msSOSerl, Row) \_
>
> & "&ItemNm=" + escape(Form1.ylwsh.CellText(msItemNm, Row)) \_
>
> & "&ItemNo=" + escape(Form1.ylwsh.CellText(msItemNo, Row)) \_
>
> & "&ItemCd=" + escape(Form1.ylwsh.CellText(msItemCd, Row)) \_
>
> & "&OptionCheck="+ varTemp \_
>
> & "&RowNo="+ CStr(Row) \_
>
> & "&ReadOnly="+ "0" \_
>
> & "&JumpPgmId=" + "FrmSASalesOrder_02_sjpark"

 

> 'Dlg종료후 Return받은값

 

 

 

 

 

> arrRtnValue = LoadDlgForm(true,"DlgSAOption",strParameter ,GetDlgData())

 

> Dim arrTemp
>
> Dim i
>
> Dim vntOptionCheck, vntOptionPrice
>
> If Trim(arrRtnValue) \<\> "" Then
>
> if JumpStringToSplit(arrRtnValue, arrTemp) = True Then
>
> For i = 1 To UBound(arrTemp, 1)
>
> Select Case arrTemp(i, 1)

                Case "OptionCheck"

                        vntOptionCheck = Trim(arrTemp(i, 2))

                Case "OptionPrice"

                        vntOptionPrice = Trim(arrTemp(i, 2))

> End Select
>
> Next

 

> If vntOptionCheck = "1" Then
>
> vntOptionCheck = lblOption.innerText '"옵션있음"
>
> Else
>
> vntOptionCheck = lblNoOption.innerText '"옵션없음"
>
> End If

 

> Form1.ylwsh.SetText Form1.ylwsh.ColX(msOptionPrice), Row, vntOptionPrice
>
> ' 버튼에 텍스트

 

 

 

> Form1.ylwsh.Col = msOption
>
> Form1.ylwsh.Row = Row
>
> Form1.ylwsh.GetSheet.TypeButtonText = vntOptionCheck

 

> 'Form1.ylwsh.SetText Form1.ylwsh.ColX(msOption), Row, vntOptionCheck
>
> ' 옵션은 저장된 데이타만 선택할수 있으므로 무조건 업데이트로

 

 

> Form1.ylwsh.SetText SS_HEADER, Row, SSHD_UPDATE
>
> Call CalcOrderSheet(Row, 10)
>
> End If
>
> End If
>
> End Sub
>
>  
>
> Sub cmbAccUnit\_\_ctl_onChange()
>
> dim strRtnData
>
> strRtnData = fnComDB("SDAGetCmbVal 'S60','" + cmbAccUnit.All(1).value + "'", 30, "Q")

 

> Call InitCntlCombo(cmbStkCenter.All(1), strRtnData, false, true)
>
> Call InitSheetCombo(Form1.ylwsh, strRtnData, false, true, msStkCenter, 0)
>
>  
>
> end Sub
>
>  

 

> Function fnCustCreditCheck()
>
> Dim strSpNm
>
> Dim strTag
>
> Dim strParams
>
> Dim arrRtnData
>
> Dim dblAmt
>
> Dim dblVat
>
> Dim strCurrCd
>
> Dim msgResult
>
> fnCustCreditCheck = True
>
> If Trim(txtCurrNm.all(1).TextCode) = "" Then
>
> txtCurrNm.all(1).TextCode = "\<%=\_vari.D_WONCURR%\>"
>
> txtCurrNm.all(1).Value = "\<%=\_vari.D_WONCURR%\>"
>
> End If
>
> strCurrCd = txtCurrNm.all(1).TextCode
>
> dblAmt = Form1.ylwsh.GetSumCols(Form1.ylwsh.ColX(msAmt))

 

> If "\<%=\_vari.D_WONCURR%\>" = strCurrCd Then
>
> dblVat = Form1.ylwsh.GetSumCols(Form1.ylwsh.ColX(msVat))
>
> dblAmt = dblAmt + dblVat
>
> End If

 

> strSpNm = "SSBCustCreditCheck"

 

> 'Parameter를 생성합니다.
>
> 'Parameter를 생성합니다.
>
> strParams = "'" + txtCustNm.all(1).TextCode + "' " + ",'" + \_
>
> replace(datOrderDt.all(1).Value, "-","") + "'," + \_
>
> CStr(dblAmt) + ",'" + \_
>
> strCurrCd + "','X','','','Y'" + ",'" + txtOrderNo.all(1).Value + "'"

 

> '생성한 Parameter로 저장후 결과값을 가져옵니다.(파라메타,CommandTimeOut)
>
> arrRtnData = fnComStrQuery("R",strSpNm,strParams, 600, false,false)

 

> if typename(arrRtnData) = "String" then
>
> If arrRtnData \<\> "" then
>
> If Trim(ucase(Split(arrRtnData,CNST_SP)(0))) \<\> "OK" Then
>
> if Trim(ucase(Split(arrRtnData,CNST_SP)(1))) = "0" then ' 무시일 경우
>
> ElseIf Trim(ucase(Split(arrRtnData,CNST_SP)(1))) = "1" Then ' 경고만 하기
>
> msgResult = MessageBox("\<%=\_page.GetMessageString(ConstMessage.MAXCREDITOVER, "거래처 여신한도를 초과했습니다. 저장하시겠습니까?")%\>", vbYesNo) ' 삭제하시겠습니까?
>
> If msgResult = vbNo Then
>
> fnCustCreditCheck = False
>
> End If
>
> ElseIf Trim(ucase(Split(arrRtnData,CNST_SP)(1))) = "2" Then ' 주문불가
>
> call MessageBoxShow("\<%=\_page.GetMessageString(ConstMessage.MAXCREDITOVERERR, "거래처 여신한도를 초과했습니다. 저장할수 없습니다.")%\>")
>
> fnCustCreditCheck = False
>
> End If
>
> Form1.chkCredit.Checked = True
>
> Else
>
> Form1.chkCredit.Checked = False
>
> end if
>
> End If
>
> End if
>
> End Function

 

> Sub cmdPay_OnClick()
>
> Dim arrRtnValue,strRtnSelCnt

 

> txtPay.all(1).Value = ""

 

> If LoadCodeHelp(CH_NORMAL,"\<%=ConstHelp.P_MOVEOUTTYPE%\>", txtPay.All(1), \_
>
> Nothing, txtPay.All(1), \_
>
> Nothing, Nothing, Nothing, Nothing, Nothing, Nothing, Nothing, arrRtnValue, \_
>
> true, HCMD_NORMAL, "", strRtnSelCnt, \_
>
> "", "", "", "", "") = false then

Else

> End If                                                        

 

> If Trim(txtPay.all(1).Value) \<\> "" Then txtPayment.all(1).Value = txtPay.all(1).Value
>
> end sub

 

> Sub cmdAmdQ_onClick()
>
> dim strParameter
>
> dim arrRtnValue
>
> If Trim(txtRev.all(1).Value) = "" or txtOrderNo.all(1).Value = "" Then Exit Sub

 

> strParameter = "SONo=" & txtOrderNo.all(1).Value
>
> arrRtnValue = LoadDlgForm(true,"dlgSASOAmdDlg",strParameter ,GetDlgData())
>
> end Sub

 

 

> Function optExpClss_onClick()
>
> Dim lngRow
>
> Dim varTemp

 

> For lngRow = 1 to Form1.ylwsh.DataRowCnt
>
> Form1.ylwsh.GetText SS_HEADER, lngRow, varTemp

 

> if varTemp \<\> SSHD_ADD then
>
> Form1.ylwsh.SetText SS_HEADER, lngRow, SSHD_UPDATE
>
> end if
>
> Next

 

> End Function
>
>  
>
> Sub btnItemGrpSel_OnClick()
>
> Dim i
>
> Dim strRtnValue
>
> Dim strParameter
>
> Dim arrRtnValue
>
> Dim RowCnt
>
>  
>
> RowCnt = Form1.ylwsh.DataRowCnt + 1
>
>  
>
> strRtnValue = LoadDlgForm(true,"dlgSAItemGrpDlg",strParameter ,GetDlgData())
>
> arrRtnValue = Split(strRtnValue, CNST_SP)

 

> If UCase(arrRtnValue(0)) = "FALSE" Then
>
>  
>
> ElseIf UCase(arrRtnValue(0)) = "CANCEL" Then
>
>  
>
> Else        
>
> arrRtnValue = ""
>
> arrRtnValue = SplitArray(strRtnValue, CNST_SP_NT, CNST_SP_LF, CNST_SP)
>
>  
>
> If arrRtnValue(0,0) \<\> "" Then
>
> For i = RowCnt To RowCnt + UBound(arrRtnValue)
>
> Form1.ylwsh.CellText(msItemNm, i)                = arrRtnValue(i - RowCnt, 0)
>
> Form1.ylwsh.CellText(msItemNo, i)                = arrRtnValue(i - RowCnt, 1)
>
> Form1.ylwsh.CellText(msSize, i)                        = arrRtnValue(i - RowCnt, 2)
>
> Form1.ylwsh.CellText(msUnitNm, i)                = arrRtnValue(i - RowCnt, 3)
>
> Form1.ylwsh.CellText(msStkUnitNm, i)        = arrRtnValue(i - RowCnt, 4)
>
> Form1.ylwsh.CellText(msSTKQty, i)                = arrRtnValue(i - RowCnt, 5)
>
> Form1.ylwsh.CellText(msItemCd, i)                = arrRtnValue(i - RowCnt, 6)
>
> Form1.ylwsh.CellText(msUnitCd, i)                = arrRtnValue(i - RowCnt, 7)
>
> Form1.ylwsh.CellText(msStkUnitCd, i)        = arrRtnValue(i - RowCnt, 8)
>
>  
>
> Form1.ylwsh.CellText(msPriceDiv, i) = "1" '단가구분 - 확정단가로 선택되도록
>
>  
>
> Next
>
> End If
>
>  
>
>  
>
> Call fnPriceChange(RowCnt, RowCnt + UBound(arrRtnValue))
>
> End If
>
> End Sub
>
>  
>
> '결재상신 (20060112.SHMIN)
>
> Sub btnSaleOrder02Cfm_OnClick()
>
>  

'                If "\<%=\_page.GetActionSecu("btnSaleOrder02Cfm", \_page.UserID, "A")%\>" = False then

'                        Call MessageBoxShow("\<%=\_page.GetMessageString(ConstMessage.NOPRIV,"이 프로그램의 사용권한이 없습니다.")%\>")

'                        Exit Sub

'                End If

 

> If txtOrderNo.All(1).Value = "" Then Exit Sub
>
>  
>
>  
>
> '2008.05.15 전자결재코딩 변경 YJNO
>
> If fnGroupWare("R", txtOrderNo.All(1).Value , ChkFixYn_p) = False Then Exit Sub
>
>  
>
>  

'                Dim strSpNm

'                Dim strTag

'                Dim strParams

'                Dim arrRtnData

'                Dim strURL

'

'                Dim strPgmID, strFormID

'

' strFormID = Trim("\<%=\_page.PgmID%\>")

'

'         If instr(strFormID,"\_") \<\> 0 Then

'                        strPgmID = left(strFormID, instr(strFormID,"\_") - 1)

'                Else

'                        strPgmID = strFormID

'                End If

'

'                strSpNm = "SDAGroupWareCfm"

'

> 'Parameter를 생성합니다.

'                strParams = strParams + strSpNm + " '" + strPgmID + "','" + \_

'                                        txtOrderNo.All(1).Value + "','" + \_

'                                        "\<%=\_page.EmpID%\>" + "','" + \_

'                                        "\<%=\_page.DeptCd%\>" + "'" + CNST_SP_LF

'                        

'                '생성한 Parameter로 저장후 결과값을 가져옵니다.(파라메타,CommandTimeOut)

'                arrRtnData = fnComDB(strParams, 30, "Q")

'

'                If arrRtnData \<\> "" Then

'                        If Trim(ucase(Split(arrRtnData,CNST_SP)(2))) = "#ERROR" Then

'                                Call MessageBoxShow(Split(arrRtnData,CNST_SP)(1))

'                                Exit sub

'                        End If

'                End if

>  

'                ' 그룹웨어건으로 수정

'                ' 2004. 8. 17.

'                ' 유 원 대

'                '=====================================================\< Old소스 \>==============================================================================================

'                'strURL = "http://" + Trim("\<%=mstrGroupWareIP%\>") + "/WBCGI/WBAuthPass.asp?FolderId=" + "\<%=mstrReportId%\>" + "&userid_erp=" + "\<%=mstrUserId%\>" + "&WorkKind=" + "\<%=\_page.PgmID%\>" + "&TblKey=" + txtOrderNo.all(1).Value

' 'Call window.open( strurl , "", "fullscreen=0,toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=0,resizable=1,Height= 679,Width=1012,Top= 0,Left= 0",true)

' '===================================================================================================================================================

'

' If "\<%=mstrVersion%\>" = "0" then                '다존(ASP)

'                        strURL = "http://" + Trim("\<%=mstrGroupWareIP%\>") + "/WBCGI/WBAuthPass.asp?FolderId=" + "\<%=mstrReportId%\>" + "&userid_erp=" + "\<%=mstrUserId%\>" + "&WorkKind=" + "\<%=\_page.PgmID%\>" + "&TblKey=" + Trim(CStr(txtOrderNo.all(1).Value))

'                elseIf "\<%=mstrVersion%\>" = "1" then        '다존(.Net버전)

'                        strurl = "http://" + Trim("\<%=mstrGroupWareIP%\>") + "/WBCGI/WBLogin.aspx?IsAction=1&UserId_auto=" + "\<%=mstrUserId%\>" + "&next=EAERPGetRecord.asp?FromERP=1%26EAID=" + "\<%=mstrReportId%\>" + "%26PumiNo=" + Trim(CStr(txtOrderNo.all(1).Value))

'                elseif "\<%=mstrVersion%\>" = "2" then        '데스크플러스

'                        strURL = "http://" + Trim("\<%=mstrGroupWareIP%\>") + Trim("\<%=mstrURL%\>") + "&userID=" + Trim("\<%=mstrUserId%\>") + "&WorkKind=" + Trim(Cstr(strPgmID)) + "&TblKey=" + Trim(CStr(txtOrderNo.all(1).Value)) + "&Language=" + Trim(CStr("\<%=\_page.LanguageID%\>"))

'                else                                                                        'WellComm

'                        strURL = "http://" + Trim("\<%=mstrGroupWareIP%\>") + Trim("\<%=mstrURL%\>") + "ConnInfo=" + Trim("\<%=\_page.ConnInfoGW%\>") + "&ConnInfoERP=" + Trim("\<%=\_page.ConnInfo%\>") + "&userID=" + Trim("\<%=\_page.UserCd%\>") + "&WorkKind=" + Trim(Cstr(strPgmID)) + "&TblKey=" + Trim(CStr(txtOrderNo.All(1).Value)) + "&Language=" + Trim(CStr("\<%=\_page.LanguageID%\>"))+ "&ReportId=" + Trim(CStr("\<%=mstrReportId%\>"))

' end if

 

' 'Call window.open( strurl , "", "fullscreen=0,toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=0,resizable=1,Height= 679,Width=1012,Top= 0,Left= 0",true)

' Call ShowModalDlg( strurl , "", "fullscreen=0,toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=0,resizable=1,Height= 679,Width=1012,Top= 0,Left= 0",true)

> End Sub
>
> '----------------------------------------------------------------------------------------------------
>
>  
>
> Function fnProcChk(strType, strValue, objControl)
>
> On Error Resume Next
>
> ' 결재상신일경우만체크
>
> If strType \<\> "R" Then
>
> fnProcChk = True
>
> Exit Function
>
> End If
>
>  
>
> fnProcChk = True
>
> End Function
>
>  
>
>  
>
>  
>
>  
>
> '결재취소 (20060112.SHMIN)
>
> Sub btnSaleOrder02Cancel_OnClick()

 

'                If "\<%=\_page.GetActionSecu("btnSaleOrder02Cancel", \_page.UserID, "A")%\>" = False then

'                        Call MessageBoxShow("\<%=\_page.GetMessageString(ConstMessage.NOPRIV,"이 프로그램의 사용권한이 없습니다.")%\>")

'                        Exit Sub

'                End If                 

>  
>
> If txtOrderNo.all(1).Value = "" Then Exit Sub

 

 

 

> '2008.05.15 전자결재코딩 변경 YJNO
>
> If fnGroupWare("C", txtOrderNo.All(1).Value , ChkFixYn_p) = False Then Exit Sub

'         Dim szWorkingTag

'                Dim strSpNm

'                Dim strTag

'                Dim strParams

'                Dim arrRtnData

'

'                Dim strPgmID, strFormID

'

' strFormID = Trim("\<%=\_page.PgmID%\>")

'

'         If instr(strFormID,"\_") \<\> 0 Then

'                        strPgmID = left(strFormID, instr(strFormID,"\_") - 1)

'                Else

'                        strPgmID = strFormID

'                End If

 

'                strSpNm = "SDAGroupWareCancel"

'

'                'Parameter를 생성합니다.

'                strParams = strParams + strSpNm + " '" + strPgmID + "','" + txtOrderNo.all(1).Value + "'" + CNST_SP_LF

'

'                arrRtnData = fnComDB(strParams, 30, "Q")

'                

'                If arrRtnData \<\> "" and Split(arrRtnData,CNST_SP)(0) \<\> "OK" Then

'                        Call MessageBoxShow(Split(arrRtnData,CNST_SP)(1))

'                End if

> End Sub
>
>  
>
> Sub btnSaleOrder02Status_OnClick()
>
>  
>
> '1. 버튼 권한 체크

'                If "\<%=\_page.GetActionSecu("btnSaleOrder02Status", \_page.UserID, "A")%\>" = False then

'                        Call MessageBoxShow("\<%=\_page.GetMessageString(ConstMessage.NOPRIV,"이 프로그램의 사용권한이 없습니다.")%\>")

'                        Exit Sub

'                End If                

>  
>
> '2. Key값 확인
>
> If txtOrderNo.all(1).Value = "" Then Exit Sub
>
>  
>
>  
>
> '2008.05.15 전자결재코딩 변경 YJNO
>
> If fnGroupWare("S", txtOrderNo.All(1).Value , ChkFixYn_p) = False Then Exit Sub
>
>  
>
>  

'                Dim strSpNm

'                Dim strTag

'                Dim strParams

'                Dim arrRtnData

'                Dim strURL

'

'                Dim strPgmID, strFormID

'

' strFormID = Trim("\<%=\_page.PgmID%\>")

'

'         if instr(strFormID,"\_") \<\> 0 then

'                        strPgmID = left(strFormID, instr(strFormID,"\_") - 1)

'                else

'                        strPgmID = strFormID

'                end if

'        

'                '3. 웰컴일때만 결재진행상태 페이지 호출

'                If "\<%=mstrVersion%\>" = "3" then

'                        strURL = "http://" + Trim("\<%=mstrGroupWareIP%\>") + Trim("\<%=mstrURL%\>") + "ConnInfo=" + Trim("\<%=\_page.ConnInfoGW%\>") + "&ConnInfoERP=" + Trim("\<%=\_page.ConnInfo%\>") + "&userID=" + Trim("\<%=\_page.UserCd%\>") + "&WorkKind=" + Trim(Cstr(strPgmID)) + "&TblKey=" + Trim(CStr(txtOrderNo.all(1).Value)) + "&Language=" + Trim(CStr("\<%=\_page.LanguageID%\>"))+ "&ReportId=" + Trim(CStr("\<%=mstrReportId%\>") + "&isview=" + "1")

'         Call ShowModalDlg( strurl , "", "fullscreen=0,toolbar=0,location=0,directories=0,status=1,menubar=0,scrollbars=0,resizable=1,Height= 679,Width=1012,Top= 0,Left= 0",true)

'                end if

>                 
>
> End Sub        
>
> '----------------------------------------------------------------------------------------------------

--\>

> \</SCRIPT\>
>
> \</body\>

\</HTML\>

 

 

cs 필기