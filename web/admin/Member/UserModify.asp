<!--#include file="../../inc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!--#include file="../../inc/md5.asp"-->
<!-- #include file="../Inc/Head.asp" -->
<%
dim UserID,Action,FoundErr,ErrMsg
dim rsUser,sqlUser
Action=trim(request("Action"))
UserID=trim(request("UserID"))
if UserID="" then
	FoundErr=True
	ErrMsg=ErrMsg & "<br><li>参数不足！</li>"
	call WriteErrMsg()
else
	Set rsUser=Server.CreateObject("Adodb.RecordSet")
	sqlUser="select * from [User] where UserID=" & Clng(UserID)
	rsUser.Open sqlUser,conn,1,3
	if rsUser.bof and rsUser.eof then
		FoundErr=True
		ErrMsg=ErrMsg & "<br><li>找不到指定的用户！</li>"
	else
		if Action="Modify" then
			dim UserName,Password,Question,Answer,Sex,Email,Homepage,LockUser,Comane,Add,Somane,Zip,Phone,Fox
			UserName=trim(request("UserName"))
			Password=trim(request("Password"))
			Question=trim(request("Question"))
			Answer=trim(request("Answer"))
			Sex=trim(Request("Sex"))
			Email=trim(request("Email"))
			Homepage=trim(request("Homepage"))
			Comane=trim(request("Comane"))
		zip=trim(request("zip"))
			Add=trim(request("Add"))
			Somane=trim(request("Somane"))
			Zip=trim(request("Zip"))
			Phone=trim(request("Phone"))
			Fox=trim(request("Fox"))
			LockUser=trim(request("LockUser"))
			IsTJ=trim(request("IsTJ"))
			groupid=strtoNum(request("groupid"))
			birthday =Cdate(request("birthday"))
			qqid=trim(request("qqid"))

			if Password<>"" then
				if strLength(Password)>12 or strLength(Password)<4 then
					founderr=true
					errmsg=errmsg & "<br><li>请输入密码(不能大于12小于4)。如不想修改，请留空！</li>"
				else
					if Instr(Password,"=")>0 or Instr(Password,"%")>0 or Instr(Password,chr(32))>0 or Instr(Password,"?")>0 or Instr(Password,"&")>0 or Instr(Password,";")>0 or Instr(Password,",")>0 or Instr(Password,"'")>0 or Instr(Password,",")>0 or Instr(Password,chr(34))>0 or Instr(Password,chr(9))>0 or Instr(Password,"")>0 or Instr(Password,"$")>0 then
						errmsg=errmsg+"<br><li>密码中含有非法字符</li>"
						founderr=true
					end if
				end if
			end if

			if Sex="" then
				founderr=true
				errmsg=errmsg & "<br><li>性别不能为空</li>"
			else
				sex=cint(sex)
				if Sex<>0 and Sex<>1 then
					Sex=1
				end if
			end if
			if Email="" then
				'founderr=true
				'errmsg=errmsg & "<br><li>Email不能为空</li>"
			else
				if IsValidEmail(Email)=false then
					errmsg=errmsg & "<br><li>您的Email有错误</li>"
			   		founderr=true
				end if
			end if
			if LockUser="" then
				FoundErr=True
				ErrMsg=ErrMsg & "<br><li>用户状态不能为空！</li>"
			end if
			if FoundErr<>true then
				rsUser("Sex")=Sex
				rsUser("Email")=Email
				rsUser("HomePage")=HomePage
				rsUser("Comane")=Comane
				rsUser("somane")=somane
				rsUser("Add")=Add
				rsUser("Phone")=Phone
				rsUser("Fox")=Fox
				rsUser("LockUser")=LockUser
				'rsUser("IsTJ")=IsTJ
				rsUser("QQid")= qqid
				rsUser("birthday")=birthday
				rsUser("zip")=zip
				rsUser("groupid")=groupid
				if Password<>"" then rsUser("Password")=md5(Password)
				rsUser.update
				rsUser.Close
				set rsUser=nothing
				call CloseConn() 
				response.redirect "UserManage.asp"
			end if
		end if
	end if
	if FoundErr=True then
		call WriteErrMsg()
	else
%>

<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="862" align="center" valign="top"> 
      <FORM name="Form1" action="UserModify.asp" method="post">
        <table width="100%" border="0" cellpadding="2" cellspacing="1" bgcolor="ECF5FF" class="table_southidc">
          <TR align=center class='title'> 
            <TD class="back_southidc" height=25 colSpan=2><b>修改注册用户信息</b></TD>
          </TR>
          <TR class="tdbg" > 
            <TD width="120" align="right" class="tr_southidc"><b>用户名：</b></TD>
            <TD class="tr_southidc"> <INPUT name=UserName value="<%=rsUser("UserName")%>" id="username2" readonly disabled></TD>
          </TR>
          <TR class="tdbg" > 
            <TD width="120" align="right" class="tr_southidc"><B>用户密码：</B></TD>
            <TD class="tr_southidc"> <INPUT   type=password maxLength=16 size=30 name=Password> <font color="#FF0000">如果不想修改，请留空</font>            </TD>
          </TR>
          
          <TR class="tdbg" > 
            <TD width="120" align="right" class="tr_southidc"><b>姓名：</b></TD>
            <TD class="tr_southidc"> <INPUT name=Somane value="<%=rsUser("Somane")%>" ></TD>
          </TR>
          
          <TR class="tdbg" > 
            <TD width="120" align="right" class="tr_southidc"><strong>性别：</strong></TD>
            <TD class="tr_southidc"> <INPUT type=radio value="1" name=sex <%if rsUser("Sex")=1 then response.write "CHECKED"%>>
              男 &nbsp;&nbsp; <INPUT type=radio value="0" name=sex <%if rsUser("Sex")=0 then response.write "CHECKED"%>>
            女</TD>
          </TR>
          
           <TR class="tdbg" > 
            <TD align="right" class="tr_southidc"><strong>联系电话：</strong><br></TD>
            <TD class="tr_southidc"><INPUT name=Phone value="<%=rsUser("Phone")%>" size=30 maxLength=50></TD>
          </TR>
          
          <TR class="tdbg" > 
            <TD width="120" align="right" class="tr_southidc"><strong>邮箱地址：</strong></TD>
            <TD class="tr_southidc"> <INPUT name=Email value="<%=rsUser("Email")%>" size=30   maxLength=50>            </TD>
          </TR>
         <!-- <TR class="tdbg" > 
            <TD width="120" align="right" class="tr_southidc"><strong>你的主页：</strong></TD>
            <TD class="tr_southidc"> <INPUT   maxLength=100 size=30 name=homepage value="<%=rsUser("HomePage")%>"></TD>
          </TR>-->
          <TR class="tdbg" > 
            <TD width="120" align="right" class="tr_southidc"><strong>家庭地址：</strong></TD>
            <TD class="tr_southidc"> <INPUT name=Add value="<%=rsUser("Add")%>" size=30 maxLength=50></TD>
          </TR>
         
          <TR class="tdbg" > 
            <TD align="right" class="tr_southidc"><strong>邮政编码：</strong><br></TD>
            <TD class="tr_southidc"><INPUT name=zip value="<%=rsUser("zip")%>" size=30 maxLength=50></TD>
          </TR>
            <TR class="tdbg" > 
            <TD align="right" class="tr_southidc"><strong>身份证号码：</strong></TD>
            <TD class="tr_southidc"><INPUT name=qqid value="<%=rsUser("qqid")%>" size=30 maxLength=50></TD>
          </TR>
           <TR class="tdbg" > 
            <TD align="right" class="tr_southidc"><strong>生日：</strong></TD>
            <TD class="tr_southidc"><INPUT name=birthday value="<%=rsUser("birthday")%>" size=30 maxLength=50></TD>
          </TR>
         <!-- <TR class="tdbg" > 
            <TD align="right" class="tr_southidc"><strong>移动电话：</strong></TD>
            <TD class="tr_southidc"><INPUT name=Fox value="<%=rsUser("Fox")%>" size=30 maxLength=50></TD>
          </TR>-->
          <TR class="tdbg" > 
            <TD width="120" align="right" class="tr_southidc"><strong>所属班级：</strong></TD>
            <TD class="tr_southidc">
            
          
            <select name="comane">
            <optgroup >
            
            
	  <%
followid=trim(rsUser("comane"))
rs.open "select cateid,catename,followid,depth,sonid,parentid,orderID from category where catetype<=3 order by depth,orderID",conn,1,1
			if not rs.eof then
				data= rs.getRows()
			end if
			rs.close
			
	class_list=""
	
	
sub classlist(byval t0)
		dim i
		for i=0 to ubound(data,2)
			if t0=data(2,i) then
				if followid = data(1,i) then
					isslected="selected"
				else
					isslected=""
				end if
				if data(3,i)=2 then 
					class_list=class_list&"</optgroup><optgroup label="""&data(1,i)&""">"
				else
					class_list=class_list&"<option value="""&data(1,i)&""" "&isslected&">"
				end if
				

For k=2 To data(3,i)
class_list=class_list&"&nbsp;&nbsp;&nbsp;&nbsp;"
next

If data(3,i)>1 then class_list=class_list& "├"
				class_list=class_list& data(1,i)&"</option>"
				
				classlist(data(0,i))
			end if
		next
	end sub
	if isarray(data) then	
		call classlist(Usercateid)	
	end if	
		response.write class_list
%>    </optgroup></select>

            
            </TD>
          </TR>
          <TR class="tdbg" > 
            <TD width="120" align="right" class="tr_southidc"><strong>用户状态：</strong></TD>
            <TD class="tr_southidc"><input type="radio" name="LockUser" value="False" <%if rsUser("LockUser")=False then response.write "checked"%>>
              正常&nbsp;&nbsp; <input type="radio" name="LockUser" value="True" <%if rsUser("LockUser")=True then response.write "checked"%>>
            锁定</TD>
          </TR>
          <TR align="center" class="tdbg" > 
            <TD height="40" class="tr_southidc">&nbsp;</TD>
            <TD height="40" align="left" class="tr_southidc"><input name="Action" type="hidden" id="Action" value="Modify">
              <input name=Submit   type=submit id="Submit" value="保存修改结果">
              <input name="UserID" type="hidden" id="UserID" value="<%=rsUser("UserID")%>">
            <input type="button" name="Submit2" value="返回上一页" onClick="history.go(-1);" /></TD>
          </TR>
        </TABLE>
    </form></td>
  </tr>
</table>
<!-- #include file="../Inc/Foot.asp" -->
<%
	end if
	rsUser.close
	set rsUser=nothing
end if
call CloseConn()
%>