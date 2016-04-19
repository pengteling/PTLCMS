<!--#include virtual="/admin/inc/head.asp"-->
<body>

    <div id="wrapper">
    <!--#include virtual="/admin/inc/top.asp"-->

<!-- Page Content -->
        <div id="page-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">管理员分组</h1>
                    </div>
                    <!-- /.col-lg-12 -->
</div>
                     <!-- /.row -->
                <div class="row">
                  <div class="panel panel-default">
                       <!--  <div class="panel-heading">
                            Kitchen Sink
                        </div> -->
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
<%
Action=ChkFormStr(Request("Act"))
title=ChkFormStr(request("title"))
ID=strToNum(Request("ID"))
orderID=strToNum(Request("orderID"))
if Action="Add" then
	if title="" then
		Response.Write("<script language=JavaScript>alert(""请填写分组名称!"");location.href=""javascript:history.back(-1);"";</script>")
		Response.End()
	end if
	Set rs=Server.CreateObject("Adodb.RecordSet")
	rs.open "Select * From zh_AdminGroup Where title='" & title & "'",conn,1,3
	if not (rs.bof and rs.EOF) then
		Response.Write("<script language=JavaScript>alert(""此分组已存在!"");location.href=""javascript:history.back(-1);"";</script>")
		Response.End()
	else
    	rs.addnew
     	rs("title")=title
		rs("orderid")=orderid
    	rs.update
     	rs.Close
	    set rs=Nothing
    	call CloseConn()
		Response.Redirect "ad_sort.asp"  
	end if
ElseIf Action="Del" Then
	Conn.Execute("Delete from zh_AdminGroup Where ID="&ID&"")
	Response.Redirect "ad_sort.asp"
ElseIf Action="Update" Then
	if title="" then
		Response.Write("<script language=JavaScript>alert(""请填写分组名称!"");location.href=""javascript:history.back(-1);"";</script>")
		Response.End()
	end if
	If ID=0 Then
		Response.Write("<script language=JavaScript>alert(""请正常选择!"");location.href=""javascript:history.back(-1);"";</script>")
		Response.End()
	End If
	Set rs=Server.CreateObject("Adodb.RecordSet")
	rs.open "Select * From zh_AdminGroup Where title='" & title & "' and ID<>"&ID&"",conn,1,3
	if not (rs.bof and rs.EOF) then
		Response.Write("<script language=JavaScript>alert(""此分组已存在!"");location.href=""javascript:history.back(-1);"";</script>")
		Response.End()
	else
     	Conn.Execute("Update zh_AdminGroup Set title='"&title&"' Where ID="&ID&"")
    	call CloseConn()
		Response.Redirect "ad_sort.asp"  
	end if
end if


dim sql,rsClass,rsSmallClass,ErrMsg
set rsClass=server.CreateObject("adodb.recordset")
rsClass.open "Select * From zh_AdminGroup Order By orderid,id ",conn,1,3
%>
<script language="JavaScript" type="text/JavaScript">
function checkBig()
{
  if (document.form1.title.value=="")
  {
    alert("名称不能为空！");
    document.form1.title.focus();
    return false;
  }
}
function ConfirmDelBig()
{
   if(confirm("确定要删除吗？"))
     return true;
   else
     return false;
	 
}
</script>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="1" bgcolor="#000000" class="table_southidc">
  <tr>
  	<td width="40" align="center"><strong>序号</strong></td>
    <td width="378" height="30" align="center"><strong>管理员分组名称</strong></td>
    <td width="368" height="30" align="center"><strong>操作选项</strong></td>
  </tr>
<%
do while not rsClass.eof
%>
  <tr bgcolor="#F2F8FF" class="tdbg">
  <td bgcolor="#F2F8FF" class="tr_southidc" align="center"><%=rsClass("orderid")%></td>
    <td width="378" height="22" bgcolor="#F2F8FF" class="tr_southidc"><img src="../Images/tree_folder4.gif" width="19" height="18"><%=rsClass("title")%></td>
    <td align="left" bgcolor="#F2F8FF" class="tr_southidc" style="padding-right:10">&nbsp;
  <%if (rsClass("title"))<>"超级管理员" then%>  
    <a href="Manage_page_permission.asp?ID=<%=rsClass("ID")%>">页面权限</a> | <a href="Manage_Admin_permission.asp?ID=<%=rsClass("ID")%>">栏目权限</a> | <a href="ad_sort.asp?Act=Modi&ID=<%=rsClass("ID")%>">修改</a> | <a href="ad_sort.asp?Act=Del&Id=<%=rsClass("ID")%>" onClick="return ConfirmDelBig();">删除</a>
    <%else%>
   
    <%end if%>
    </td>
  </tr>
<%
rsClass.MoveNext
Loop
%>
</table>
<%
rsClass.close
set rsClass=nothing
%>
<%If Action<>"Modi" Then%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">   
   <tr>
     <td height="5"></td>
   </tr>
</table>
<form name="form1" method="post" action="ad_sort.asp?Act=Add" onSubmit="return checkBig()">
   <table width="100%" border="0" align="center" cellspacing="1" class="table_southidc">
       <tr bgcolor="#E3E3E3" class="tdbg">
           <td width="13%" align="right" bgcolor="#E3E3E3" class="tr_southidc" style="font-weight: bold">添加新分组</td>
           <td width="15%" align="right" bgcolor="#E3E3E3" class="tr_southidc"><strong>分组名称：</strong></td>
           <td width="18%" bgcolor="#E3E3E3" class="tr_southidc"><input name="title" type="text" size="20" maxlength="30"></td>
           
            <td width="15%" align="right" bgcolor="#E3E3E3" class="tr_southidc"><strong>分组序号：</strong></td>
           <td width="8%" bgcolor="#E3E3E3" class="tr_southidc"><input name="orderid" type="text" size="2" maxlength="10"></td>
           
           <td width="54%" bgcolor="#E3E3E3" class="tr_southidc"><input name="Add" type="submit" value="确认添加"></td>
       </tr>
   </table>
</form>
<%End If%>
<%
If Action="Modi" Then
Set Rs=Conn.Execute("select * from zh_AdminGroup Where ID="&ID&"")
	if not rs.eof then
		title=rs("title")
		orderId=rs("orderid")
		ID=rs("id")
	else
		Response.Write("<script language=JavaScript>alert(""此分组不存在或已被删除!"");location.href=""ad_sort.asp"";</script>")
		Response.End()
	end if
	rs.close
%>
<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">   
   <tr>
     <td height="5"></td>
   </tr>
</table>
<form name="form1" method="post" action="ad_sort.asp?Act=Update&ID=<%=ID%>" onSubmit="return checkBig()">
   <table width="100%" border="0" align="center" cellspacing="1" class="table_southidc">
       <tr bgcolor="#E3E3E3" class="tdbg">
           <td width="13%" align="right" bgcolor="#E3E3E3" class="tr_southidc" style="font-weight: bold">分组修改</td>
           <td width="15%" align="right" bgcolor="#E3E3E3" class="tr_southidc"><strong>分组名称：</strong></td>
           <td width="18%" bgcolor="#E3E3E3" class="tr_southidc"><input name="title" value="<%=title%>" type="text" size="20" maxlength="30"></td>
            <td width="15%" align="right" bgcolor="#E3E3E3" class="tr_southidc"><strong>分组序号：</strong></td>
           <td width="8%" bgcolor="#E3E3E3" class="tr_southidc"><input name="orderid" type="text" size="2" maxlength="10" value="<%=orderID%>"></td>
           <td width="54%" bgcolor="#E3E3E3" class="tr_southidc"><input name="Add" type="submit" value="确认修改"><a href="ad_sort.asp">取消修改并返回</a></td>
       </tr>
   </table>
</form>
<%End If%>
</div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                </div>

                </div>
                <!-- /.row -->
            </div>
            <!-- /.container-fluid -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->




</body>
</html>