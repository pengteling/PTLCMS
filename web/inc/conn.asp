<%
'Easp.Db.SetConnection "default", "MSSQL", "xannad", "xannad:xannadadm@PTL-PC\SQLEXPRESS"
Easp.Db.SetConnection "default", "MSSQL", "xannad", "xannad:xannadadm@JADEBOXSERVER\SQLEXPRESS"
'Easp.Db.SetConnection "default", "MSSQL", "xannad", "xannad_f:xannadadm@10.209.0.141"
'connstr="Provider=SQLOLEDB.1;Server=JADEBOXSERVER\SQLEXPRESS;User ID=xannad;Password=xannadadm;Database=xannad;"
'connstr="Provider = Microsoft.Jet.OLEDB.4.0;Data Source = " & Server.MapPath(MyDbPath & db)
'Easp.Db.SetConnection "default", "ACCESS", MyDbPath & db,""
'Set conn = Server.CreateObject("ADODB.Connection")
''	conn.open ConnStr

Set conn = Easp.Db.GetConn()
set rs=server.CreateObject("adodb.recordset")

sub CloseConn()
	conn.close
	set conn=nothing
end sub	

%>