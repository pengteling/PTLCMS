<!--#include virtual="/inc/inc.asp"-->

<%
curpageTitle=""&SiteTitle 
'cateid_d1=36
isindex=1
cateid_d1 = 0
%>
<!--#include virtual="/top.asp"-->

<div class="fullSlide">
		<div class="bd">
			<ul>
			<%
			set rs=Easp.Db.Sel("select * from ad where catalogid=2 order by id desc")
			while not rs.eof
			%>
				<li><img src="<%=rs("photo")%>"/>
				<div class="layers">
				<div class="main">
					<div class="mengban"></div>
					<a target="_blank" href="<%=rs("linkurl")%>"><div class="con"><div class="tit"><%=rs("title")%></div>
					<div class="intro">   <%=rs("content")%></div></div></a>
				</div>
				</div>

				</li>
				<%
				rs.movenext
				wend
				rs.close
				%>				
				
			</ul>
		</div>

		<div class="hd"><ul></ul></div>

		<!-- <a class="prev" href="javascript:void(0)"></a>
		<a class="next" href="javascript:void(0)"></a> -->
</div>

<div class="i-xm main" id="index-xm">
	<div class="tabtit">
		
		<%
			DIM tabid
			set rs=Easp.Db.Sel("select * from category where followid=228 order by orderid")
			while not rs.eof
				
				response.write "<a href="""&companyURL(rs("cateid"),rs("catetype"),rs("outlinkurl"),rs("modeltype"),rs("dirpath"),supporthtml)&""">"&rs("catename")&"</a>"
				
				
			rs.MoveNext
			wend
			'rs.close

			%>
	</div>
	<div class="tabcon">
<%
rs.movefirst

while not rs.eof
	Set NewsListRs = Easp.Db.sel("Select top 12 * from project where isdel=0 and passed=1 and cateid in ( select cateid from category where charindex(',"&rs("cateid")&",',','+parentid+',')>0 ) Order By [px] desc,posttime Desc,[ID] Desc")
	response.write "<ul>"
	if not NewsListRs.eof then
		
	while not NewsListRs.eof
%>
<li><a href="projectitem.asp?id=<%=NewsListRs("id")%>">
				<div class="pic"><img src="<%=NewsListRs("defaultpicurl")%>" alt=""></div>
				<div class="tit"><%=NewsListRs("title")%></div>
				<div class="time-views">
					<div class="time"><%=formatdate(NewsListRs("posttime"),10)%></div>
						<div class="views"><%=NewsListRs("hits")%> 次</div>
				</div>
				</a>
			</li>
<%

	NewsListRs.movenext
	
	wend
	NewsListRs.close
	
	end if
	response.write "</ul>"

rs.movenext
wend
rs.close
%>
		
	</div>
</div>

<div class="index-ad">
	
	<%
			set rs=Easp.Db.Sel("select * from ad where catalogid=5 order by id desc")
			while not rs.eof
			%>				
				<div class="ad"><a href="<%=rs("linkurl")%>" target="_blank"><img src="<%=rs("photo")%>" alt=""></a></div>

				<%
				rs.movenext
				wend
				rs.close
				%>			
</div>

<div class="about">
	<div class="main">
		<div class="fl">
			<div class="subtit">公司简介</div>
			<div class="intro">中机中联工程有限公司（CMCU），创建于1964年，是国有科技型工程公司，隶属于世界500强企业，中央大型企业集团——中国机械工业集团有限公司。总部设在中国重庆。CMCU是最早组建的国家级大型甲级设计研究院之一，在中国勘察设计咨询业内享有盛誉，是我国勘察设计、项目管理和工程总承...</div>
		</div>
		<div class="fr">
			<div class="pic"><img src="images/i-about-img.jpg" alt=""></div>
		</div>
	</div>
</div>

<!--#include virtual='/foot.asp'-->