<!--#include virtual="/Inc/inc.asp"-->
<%
set rs=Easp.db.sel("select * from {=table} where cateid={id}")
Easp.Json.EncodeUnicode = False
'生成JSON格式数据
rsjson = Easp.Encode(rs)
easp.echo rsjson
%>