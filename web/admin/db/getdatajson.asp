<!--#include virtual="/inc/inc.asp"-->
<!--#include virtual="/inc/JSON_2.0.4.asp"-->
<!--#include virtual="/inc/JSON_UTIL_0.1.1.asp"-->


<!--#include virtual="/admin/db/comm.asp"-->
{"data":
<%
id = clng(request("id"))
'Set rs = Easp.Db.Query("Select "&columns&" from "&tablename&" where id="&id)
'Easp.Print Easp.Encode(rs)
'Easp.Db.Close(rs)
'response.write "Select 'row_'&id as DT_RowId, "&columns&" from "&tablename&" where id="&id
QueryToJSON(conn, "Select 'row_'+convert(varchar(20),id) as DT_RowId, "&columns&" from "&tablename&" ").Flush
'where id="&id'
%>
}