<!--#include virtual="/Inc/inc.asp"-->
<!--#include virtual="/Inc/md5.asp"-->

<%
	Dim server_b1,server_b2
	server_b1=Cstr(Request.ServerVariables("HTTP_REFERER"))
	server_b2=Cstr(Request.ServerVariables("SERVER_NAME"))
	If mid(server_b1,8,len(server_b2))<>server_b2 Then
		'Call ShowErr("<li>本页面禁止由外部链接<li>请从本站首页进入！",0,"default.asp")
		'Response.Write("<li>本页面禁止由外部链接<li>请从本站首页进入！")
		response.write"<SCRIPT language=JavaScript>alert('本页面禁止由外部链接！');"
		response.write"location.href=""../index.asp"";</SCRIPT>"
		response.End
	End If

dim username,password,CheckCode
username=(Request.Form("username"))
password=(Request.Form("password"))
CheckCode=(Request.Form("CheckCode"))

'Response.Write(CheckCode)
'Response.Write(Session("getcode"))
'Response.Write md5(password)
'Response.End
Easp.var("password")=md5(password)

dim FoundErr,ErrMsg
FoundErr=false
if UserName="" or IsEmpty(UserName)=True or IsNull(UserName) then
	FoundErr=True
	ErrMsg=ErrMsg & "<br><li>用户名不能为空！</li>"
end if
if Password="" or IsEmpty(Password)=True or IsNull(Password) then
	FoundErr=True
	ErrMsg=ErrMsg & "<br><li>密码不能为空！</li>"
end if

If CStr(Session("getcode"))<>CStr(Trim(Request("CheckCode"))) Then
	FoundErr=True
	ErrMsg=ErrMsg & "<br><li>您输入的确认码和系统产生的不一致，请重新输入!</li>"
	Session("getcode") = ""
End If

if FoundErr<>True then
	
	Set rs = Easp.Db.Sel("Select * From zh_admin where username = {username} and password={password} ")

	if not rs.eof then
		'response.cookies("login")="1"
		RndPassword=GetRndPassword(16)
		Set LoginRs=server.CreateObject("adodb.recordset")
		sql="select * from zh_Admin where id="&rs("id")
		LoginRs.open sql,conn,1,3		
			LoginRs("LastLoginIP")=Request.ServerVariables("REMOTE_ADDR")
			LoginRs("LastLoginTime")=now()
			LoginRs("LoginTimes")=LoginRs("LoginTimes")+1
			LoginRs("RndPassword")=RndPassword
			
			LoginRs.update
			session.Timeout=SessionTimeout
			session("AdminID")=LoginRs("id")
			session("AdminName")=LoginRs("username")
			session("AdminPassword")=LoginRs("Password")		
			session("RndPassword")=RndPassword
			LoginRs.close
			set LoginRs=nothing
		Response.Redirect "index.asp"
		
	else
	
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>用户名或密码错误！！！</li>"
		response.write md5("pengteling")
		
			
			
			
	end if
	
end if
if FoundErr=True then
	call WriteErrMsg()
end if

%>