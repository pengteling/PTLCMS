<!--#include virtual="/inc/inc.asp"-->
<!--#include virtual="/admin/db/comm.asp"-->
<%
id = clng(request("id"))
Set rs = Easp.Db.Query("Select "&columns&" from "&tablename&" where id="&id)
Easp.Print Easp.Encode(rs)
Easp.Db.Close(rs)
%>