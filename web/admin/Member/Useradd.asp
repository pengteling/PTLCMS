<!--#include file="../../inc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!--#include file="../../inc/md5.asp"-->
<%
dim UserID,Action,FoundErr,ErrMsg
dim rsUser,sqlUser
Action=trim(request("Action"))

if Action="add" then
	UserName=trim(request("UserName"))
	sex=trim(request("sex"))
	Comane=trim(request("Comane"))
	Password=trim(request("Password"))
	Email=trim(request("Email"))
	Phone=trim(request("Phone"))
	Somane=trim(request("Somane"))
	if UserName="" then
		Response.Write("用户名不能为空!")
		Response.End()
	end if
	if Password="" then
		Response.Write("密码不能为空!")
		Response.End()
	end if
	set Rs=server.createobject("adodb.recordset")
	sql="Select * from [User] where UserName='"&UserName&"'"
	Rs.Open sql,conn,1,3
	If Not (Rs.Bof And Rs.Eof) Then
		Response.Write("此用户已经存在!")
		Response.End()
	Else
		Rs.AddNew
			Rs("UserName")=UserName
			Rs("sex")=sex
			Rs("Password")=Md5(Password)
			Rs("Email")=Email
			Rs("Comane")=Comane
			Rs("Phone")=Phone
			Rs("Somane")=Somane
		Rs.Update
	End If
	Rs.Close
	Response.Redirect("UserManage.asp") 
end if
%>

<!-- #include file="../Inc/Head.asp" -->
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td width="862" align="center" valign="top"> 
      <FORM name="Form1" action="Useradd.asp" method="post">
        <table width="100%" border="0" cellpadding="3" cellspacing="1" bgcolor="ECF5FF" class="table_southidc">
          <TR align=center class='title'>
            <TD class="back_southidc" height=25 colSpan=2><b>添加学生信息</b></TD>
          </TR>
          
          <TR class="tdbg" >
            <TD width="120" align="right" class="tr_southidc"><b>学籍号：</b></TD>
            <TD class="tr_southidc"><INPUT style="width:150px;" name=UserName size=30>
                </TD>
          </TR>
          <TR align="center" class="tdbg" >
            <TD align="right" class="tr_southidc"><B>姓名：</B></TD>
            <TD align="left" class="tr_southidc"><INPUT style="width:150px;" type=text size=30 name=Somane><input name="sex" type="radio" value="1" checked>
              男
              <input type="radio" name="sex" value="0">
              女 </TD>
          </TR>
          <TR class="tdbg" >
            <TD width="120" align="right" class="tr_southidc"><B>密码：</B></TD>
            <TD class="tr_southidc"><INPUT style="width:150px;" type=password size=30 name=Password></TD>
          </TR>
          <TR align="center" class="tdbg" >
            <TD align="right" class="tr_southidc"><B>邮箱地址：</B></TD>
            <TD align="left" class="tr_southidc"><INPUT name=email type=text id="email" style="width:150px;" size=30></TD>
          </TR>
          <TR align="center" class="tdbg" >
            <TD align="right" class="tr_southidc"><B>所属班级：</B></TD>
            <TD align="left" class="tr_southidc">
            
            <select name="comane">
            <optgroup >
            
            
	  <%
followid=0
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
          
          <TR align="center" class="tdbg" >
            <TD align="right" class="tr_southidc"><B>联系电话：</B></TD>
            <TD align="left" class="tr_southidc"><INPUT style="width:150px;" type=text size=30 name=Phone></TD>
          </TR>
          <TR align="center" class="tdbg" >
            <TD height="40" colspan="2" class="tr_southidc"><input name="Action" type="hidden" id="Action" value="add">
                <input name=Submit type=submit id="Submit" value="确认添加">
              &nbsp;
              <input type="button" name="Submit2" value="返回上一页" onClick="history.go(-1);">            </TD>
          </TR>
        </TABLE>
      </form></td>
  </tr>
</table>
<!-- #include file="../Inc/Foot.asp" -->
