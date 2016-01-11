<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->



<form name="form1" method="post" action="import.asp">
  <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#ECF5FF" class="table_southidc">
    <tr>
      <td height="25" colspan="2" align="center"><span style="font-weight: bold">导出订单到Excel</span></td>
    </tr>
  <tr>
      <td width="8%" height="25" align="center" class="tr_southidc">查询开始日期</td>
      <td width="62%" class="tr_southidc"><input name="date1" type="text" id="date1" value="<%=formatDate(date()-30,2)%>" size="20" maxlength="40" onfocus="WdatePicker({maxDate:'%y-%M-%d'})">  格式：<%=formatDate(Date()-30,2)%>    </td>
    </tr>
    <tr>
      <td height="22" align="center" class="tr_southidc">查询结束日期</td>
      <td class="tr_southidc"><input name="date2" type="text" id="date2" value="<%=formatDate(date(),2)%>" size="20" maxlength="120" onfocus="WdatePicker({maxDate:'%y-%M-%d'})"> 格式：<%=formatDate(Date()-30,2)%>    </td>
    </tr>
   
    <tr>
      <td height="25" colspan="2" align="center" bgcolor="#E3E3E3" class="tr_southidc">
        <input name="submit" type="submit" value="导出">
&nbsp;        <input name="reset" type="button" value="返回上一页" onClick="history.go(-1);">      </td>
    </tr>
  </table>
</form>
<!-- #include file="../Inc/Foot.asp" -->