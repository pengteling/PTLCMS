<!--#include file="../../FiveInc/conn.asp"-->
<!--#include file="../../FiveInc/md5.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<%
'response.Buffer=false 
%>

<body>
请耐心等待......<br>
<table>
<%
filepath= request("DefaultPicUrl")
filepath = replace(filepath,"//","/")
'response.write filepath
server_v1=Cstr(Request.ServerVariables("HTTP_REFERER"))
'response.write server_v1&"<br>"
If InStr(server_v1,"member")<=2 Then
response.write "<script>alert('请不要从站外提交');window.location.href='/admin/'</script>"
'response.end
End if

Set rs=server.CreateObject("adodb.recordset")
If filepath<>"" Then


set   fso=Server.CreateObject   ( "Scripting.FileSystemObject") 
  fpath=Server.MapPath(filepath)
  if   fso.FileExists(fpath)   then 
    '文件存在 
	'response.write "er"
  else 
    '文件不存在 
	response.write "<script>alert('服务器找不到你上传的excel文件，可能是上传未成功');window.location.href='/excel/'</script>"
	response.end
end   If



Set db = Server.CreateObject("ADODB.Connection")
'db.Open "Driver={Microsoft Excel Driver (*.xls)};Dbq=" & Server.MapPath("user/"&memberid&".xls")
'打开记录集，表名一定要以"[表名$]"的格式

db.Open "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="& fpath &";Extended Properties=""Excel 8.0;HDR=Yes;IMEX=1""" 

conn.beginTrans
'On Error Resume next
Set Xrs = db.OpenSchema(20)
pnum=1
While Not Xrs.eof '循环工作表

if pnum=1 then '只导入第一个工作表
pnum=pnum+1
cTableName=Xrs("TABLE_name")
response.write "正在导入工作表"&cTableName&"<br>"


strSql="Select * From ["&cTableName&"]"

	Set rs2=server.CreateObject("adodb.recordset")
	
			Set rs=db.Execute(strSql)
			k=1
			Do While Not rs.EOF
					
					'response.write rs(0)
					xh = rs(0)
					if isnumeric(xh) then
					
							'response.write rs(6)
							'rs("序号") = rs(0)  '
							'rs("学校") = rs(1)
							classname = rs(2)  '班级
							stuNo=trim(rs(6)) '学籍号
							Password = right(stuNo,6)
							
							stuName = rs(7) '学生姓名
							
							sex = rs(8)
							if sex="女" then
								sex=0
							else
								sex=1
							end if
							
							stuBirthday =  rs(9) 
							sfzNo=rs(10)
							address =rs(14)
							tel =rs(15)
							zip =rs(16)
							
							
							
							sql="Select * from [User] where UserName='"&stuNo&"'"
							rs2.Open sql,conn,1,3
							If (Rs2.Bof And Rs2.Eof) Then
								
								Rs2.AddNew
									Rs2("UserName")=stuNo
									Rs2("sex")=sex
									Rs2("Password")=Md5(Password)
									'Rs2("Email")=Email
									Rs2("Comane")=classname
									Rs2("Phone")=tel
									Rs2("Somane")=stuName
									rs2("birthday")=stuBirthday
									rs2("qqid")=sfzNo
									rs2("add")=address
									rs2("zip")=zip
								Rs2.Update
								response.write stuNo & "导入成功！<br>"
							else
								response.write stuNo & "已经存在，跳过导入！<br>"
							End If
							Rs2.Close
					
						
					
					end if
					
				
			
						if conn.errors.count=0 Then
			
						Else
						conn.rollbacktrans     '否则取消事务
						response.write "<script>alert('导入失败，"&feedate&"附近的数据格式不对，请确认数据文件是否跟模板文件格式一致，实在找不到原因可求助网站管理员');window.history.back()'</script>"
						response.end
						end If
			
			
					rs.MoveNext
			Loop 
			rs.close
	set rs2=nothing
end if
Xrs.movenext
Wend
Xrs.close
conn.commitTrans       '开始执行事务 
response.write "<script>alert('导入成功');window.location.href='/admin/member/usermanage.asp'</script>"
End if
%></table>