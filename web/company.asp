<!--#include virtual="/inc/inc.asp"-->
<%
nid=strToNum(Request.QueryString("id"))
rs.open "select * from category where cateid="&nid,conn,1,1
if not rs.eof then
	cateid=rs("cateid")
	parentid=rs("parentid")
	sonid=rs("sonid")
	followid=rs("followid")	
	catetype=rs("catetype")
	modeltype=rs("modeltype")
	catename= rs("catename")		
	com_title=rs("title")
	Com_Content=rs("content")
	depth =rs("depth")
	catedir=rs("catedir")
	catename_en =rs("catename_en")
	
	'xmname= replace(catename,"培训","")
	if com_title="" or isnull(com_title) then com_title=catename
else
	response.write "网址传递参数有误"
	response.End()

end if
rs.close


%>
<!--#include virtual="/lmenu.asp"-->
<!--#include virtual="/top.asp"-->

<div class="curloaction">
	<div class="main">		
		<%=menustr%>
	</div>
</div>

<div class="main" style="min-height: 600px;">
	<h3 style="line-height: 60px; text-align: center;"><%=com_title%></h3>
	<p><%=Com_Content%></p>
</div>

<!--#include virtual="/foot.asp"-->