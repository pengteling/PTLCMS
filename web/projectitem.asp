<!--#include virtual="/inc/inc.asp"-->

<%
newsid=strToNum(Request.QueryString("id"))

rs.open "select * from project where (((project.isdel)=0) AND ((project.passed)=1)) and id="&newsid&" ",conn,1,3
if not rs.eof then
rs("hits")=rs("hits")+1
rs.update
nid =rs("cateid")
cateid=nid
newstitle=rs("title")
News_Content=rs("content")
News_Content1=rs("content1")
News_Content2=rs("content2")
News_Content3=rs("content3")
News_Content4=rs("content4")
qqurl=rs("qqurl")
weibo=rs("weibo")
content_zy =rs("content_zy")
posttime=formatdate(rs("posttime"),5)
author=rs("author")
defaultpicurl=rs("defaultpicurl")
hits=rs("hits")
uploadfiles = rs("uploadfiles")
if uploadfiles<>"" then
bigimgs=split(uploadfiles,"|")
end if


a=instr(1,News_Content,"<a href=",1)+9
	if a>9 then
	b=instr(a+1,news_content,"""")
	
	downfileurl =mid(news_content,a,b-a)
	
	'response.write "http://"&Request.ServerVariables("Http_Host")&downfileurl
	if instr(lcase(downfileurl),"uploadfile")>0 then
	'response.Redirect(downfileurl)
	end if
	end if
else
response.write "该文章不存在或未通过审核！"
response.end
end if
rs.close

set ReadRs=server.CreateObject("adodb.recordset")
ReadRs.open "select top 1 * from news_c where cateid="&nid&" and isdel=0 and id>"&newsid &" order by id ",conn,1,1
if not ReadRs.eof then
prelink="<a href=""readnews.asp?id="&ReadRs("id")&""">"&ReadRs("Title")&"</a>"
else
prelink="这是第一篇"
end if
ReadRs.Close
ReadRs.open "select top 1 * from news_c where  cateid="&nid&" and isdel=0 and  id<"&newsid&" order by id desc",conn,1,1
if not ReadRs.eof then
nextlink="<a href=""readnews.asp?id="&ReadRs("id")&""">"&ReadRs("Title")&"</a>"
else
nextlink="已经是最后一篇"
end if
set ReadRs=nothing


rs.open "select * from category where cateid="&nid,conn,1,1
if not rs.eof then
	parentid=rs("parentid")
	sonid=rs("sonid")
	followid=rs("followid")	
	catetype=rs("catetype")
	modeltype=rs("modeltype")
	catename= rs("catename")		
	title=rs("title")
	Com_Content=rs("content")
else
	response.write "网址传递参数有误"
	response.End()
end if
rs.close
%>
<!--#include virtual="/lmenu.asp"-->
<%
curpageTitle= newstitle &"-"&catename&"-"&SiteTitle
%>
<!--#include virtual="/top.asp"-->

<div class="curloaction">
	<div class="main">		
		<%=menustr%>
	</div>
</div>
<div class="fmtbox main">
	<div class="tit"><h3>项目名称：<%=newstitle%></h3></div>
	<div class="tabtit">
		<a href="">图片</a>          <a href="">视频</a>          <a href="">模型</a>  
	</div>
	<div class="tabbd">
		<div class="tabcon">
			<div class="slideimage">
				<div class="slidebox">					
					<div class="bd">
						<ul>
						<%
						for i = 0 to ubound(bigimgs)-1
							response.write "<li><img src="""&bigimgs(i)&"""></li>"
						next
						%>
							
						</ul>
					</div>
					<div class="hd">
						<ul>
							<%
						for i = 0 to ubound(bigimgs)-1
							response.write "<li><img src="""&bigimgs(i)&"""></li>"
						next
						%>
						</ul>
					</div>
				</div>
			</div>
		</div>
		<div class="tabcon">
			<%if qqurl<>"" then%>
				<iframe width=1170 height=616 src="<%=qqurl%>" frameborder=0 allowfullscreen></iframe>
			<%else%>
			这里是视频显示区域
			<%end if%>
			<!-- <iframe src="http://sina.cn" frameborder="0"></iframe> -->
		</div>
		<div class="tabcon">
			
		<%if weibo<>"" then%>
				<iframe width=1170 height=616 src="<%=weibo%>" frameborder=0 allowfullscreen></iframe>
			<%else%>
			这里是模型显示区域
			<%end if%>
			<!-- <iframe src="http://www.so.com" frameborder="0"></iframe> -->
		</div>
	</div>
	<div class="someintro">
		
<%=News_Content%>


	</div>
	<div class="content">
			<%=News_Content1%>

	</div>

</div>

<div class="tjxm">
	<div class="subtit">推荐项目</div>

	<div class="xmlist">
		<ul>
		<%
			set rs=Easp.Db.sel("select top 3 * from project where (((project.isdel)=0) AND ((project.passed)=1))   order by elite desc,px desc,posttime desc,id desc")
			while not rs.eof
		%>
			<li><a href="projectitem.asp?id=<%=rs("id")%>">
					<div class="pic"><img src="<%=rs("defaultpicurl")%>" alt=""></div>
					<div class="tit"><%=rs("title")%></div>
					<div class="time-views">
						<div class="time"><%=formatdate(rs("posttime"),10)%></div>
						<div class="views"><%=rs("hits")%> 次</div>
					</div>
					</a>
				</li>
				<%
				rs.movenext
				wend
				rs.close
				%>
				
		</ul>
	</div>

</div>

<!--#include virtual="/foot.asp"-->
