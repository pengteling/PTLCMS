<!--#include virtual="/inc/inc.asp"-->
<!--#include virtual="/inc/JSON_2.0.4.asp"-->
<!--#include virtual="/inc/JSON_UTIL_0.1.1.asp"-->


<!--#include virtual="/admin/db/comm.asp"-->
<%
'response.write request.form
'j=1
Set data=Server.CreateObject("Scripting.Dictionary")

for each i in Request.Form    	
    	'response.write i &"-" &  Request.Form(i) &"<br>"    
    	'redim preserve rdata(j)
    	'redim preserve vdata(j)
    	'rdata(j) = i 
    	'vdata(j) = request.form(i)  
    	'j=j+1  
        data.add i,	request.form(i)          
next

'response.write rdata(1) &"-" &vdata(1)
'response.write ubound(rdata)

'response.write data("action")

for each key in data
    start1  = instr(key,"][")+2
    start0 = instr(key,"[row_")+5

    if start1>3 then
        over1 =instr(start1,key,"]")
        newkey =mid(key,start1,over1-start1)
        rowid =mid(key,start0,start1-start0-2)

        data.Key(key)=newkey
        'response.write newkey
        'response.write rowid & newkey & data(newkey) &"<br>"
    end if
next

	if data("action") ="edit" then	
		for each key in data
			if key<>"action" then
			result =Easp.Db.Upd( tablename, ""&key&"='"&data(key)&"'","id="&rowid)
			'result = Easp.Db.Upd("table_name", "field1 = {f1}, field2 = field2 + 1", "class_id = {cid}"
			end if
		next
	elseif data("action") ="create" then
	sqlstr=""
		for each key in data
			
			if key<>"action" then
				if sqlstr="" then
				sqlstr = key&":'"&data(key)&"'"
				else
				sqlstr = sqlstr & ","&key&":'"&data(key)&"'"
				end if
			end if

		next
		'response.write sqlstr
		result =Easp.Db.Ins(tablename,""&sqlstr&"")


		%>
{"data":
<%
id = clng(request("id"))
'Set rs = Easp.Db.Query("Select "&columns&" from "&tablename&" where id="&id)
'Easp.Print Easp.Encode(rs)
'Easp.Db.Close(rs)
'response.write "Select 'row_'&id as DT_RowId, "&columns&" from "&tablename&" where id="&id
QueryToJSON(conn, "Select 'row_'+convert(varchar(20),id) as DT_RowId, "&columns&" from "&tablename&" where id=(select @@Identity) ").Flush
'where id="&id'
%>
}
		<%
		response.end()

	elseif data("action")="remove" then
		result =Easp.Db.Del(tablename,"id="&rowid)
	end if


%>

{"data":
<%
id = clng(request("id"))
'Set rs = Easp.Db.Query("Select "&columns&" from "&tablename&" where id="&id)
'Easp.Print Easp.Encode(rs)
'Easp.Db.Close(rs)
'response.write "Select 'row_'&id as DT_RowId, "&columns&" from "&tablename&" where id="&id
QueryToJSON(conn, "Select 'row_'+convert(varchar(20),id) as DT_RowId, "&columns&" from "&tablename&" order by elite desc,px desc,posttime desc,id desc").Flush
'where id="&id'
%>
}