<!--#include virtual="/inc/inc.asp"-->

<%

nid=strToNum(Request.QueryString("id"))
if request("id")="" then nid=228
rs.open "select * from category where cateid="&nid,conn,1,1
if not rs.eof then
  cateid=nid
  parentid=rs("parentid")
  sonid=rs("sonid")
  followid=rs("followid") 
  catetype=rs("catetype")
  modeltype=rs("modeltype")
  catename= rs("catename")    
  title=rs("title")
  Com_Content=rs("content")
  depth_cate= rs("depth")

else

  response.write "网址传递参数有误"
  response.End()

end if
rs.close
%>
<!--#include virtual="/lmenu.asp"-->
<%
curpageTitle= catename&"-"&SiteTitle
%>
<!--#include virtual="/top.asp"-->

<div class="curloaction">
	<div class="main">		
		<%=menustr%>
	</div>
</div>

<div class="i-xm main">
	<div class="catebox">
		<div class="searchbox">
		<form action="" id="frm-so">
			<input type="text" name="so" id="key" placeholder="Search"><input type="submit" id="search">
		</form>
		</div>
		
		<div class="cate1">
			<a href="project.asp" <%if nid=228 then response.write "class=""on"""%>>全部</a>
			<!-- <a href="" class="on">建筑工程</a>
			<a href="">工业工程</a>
			<a href="">市政工程</a>
			<a href="">国际工程</a>
			<a href="">工程建设</a>
			<a href="">BIM设计</a> -->
			<%
			set rs=Easp.Db.Sel("select * from category where followid=228 order by orderid")
			while not rs.eof
				if rs("cateid") = cateId_d2 then
					response.write "<a href="""&companyURL(rs("cateid"),rs("catetype"),rs("outlinkurl"),rs("modeltype"),rs("dirpath"),supporthtml)&""" class=""on"">"&rs("catename")&"</a>"
				else
				response.write "<a href="""&companyURL(rs("cateid"),rs("catetype"),rs("outlinkurl"),rs("modeltype"),rs("dirpath"),supporthtml)&""">"&rs("catename")&"</a>"
				end if
			rs.MoveNext
			wend
			rs.close

			%>
		</div>	
		<%
		if depth_cate>1 then
		%>
		<div class="box-greybg">
			<div class="cate2">
				<%
			set rs=Easp.Db.Sel("select * from category where followid="&cateid_d2&" order by orderid")
			while not rs.eof
				if rs("cateid") = cateId_d3 then
					response.write "<a href="""&companyURL(rs("cateid"),rs("catetype"),rs("outlinkurl"),rs("modeltype"),rs("dirpath"),supporthtml)&""" class=""on"">"&rs("catename")&"</a>"
				else
				response.write "<a href="""&companyURL(rs("cateid"),rs("catetype"),rs("outlinkurl"),rs("modeltype"),rs("dirpath"),supporthtml)&""">"&rs("catename")&"</a>"
				end if
			rs.MoveNext
			wend
			rs.close

			%>
			</div>
		<%
		if depth_cate>2 then
		%>
			<div class="cate3">
				<%
			set rs=Easp.Db.Sel("select * from category where followid="&cateid_d3&" order by orderid")
			while not rs.eof
				if rs("cateid") = cateId_d4 then
					response.write "<a href="""&companyURL(rs("cateid"),rs("catetype"),rs("outlinkurl"),rs("modeltype"),rs("dirpath"),supporthtml)&""" class=""on"">"&rs("catename")&"</a>"
				else
				response.write "<a href="""&companyURL(rs("cateid"),rs("catetype"),rs("outlinkurl"),rs("modeltype"),rs("dirpath"),supporthtml)&""">"&rs("catename")&"</a>"
				end if
			rs.MoveNext
			wend
			rs.close

			%>
			</div>
			<%end if%>
		</div>
		<%end if%>
	</div>
	<div class="tabcon">
		

		<%


  TrNum=0
  cateid = strToNum(Request("id"))  
  Keyword = ChkFormStr(Request("so"))
  
  msql="Select * from project where isdel=0 and passed=1 "
If cateid<>0 Then
    'msql=msql&" and cateid="&cateid&""
   msql=msql&" and cateid in ("&sonid&")"
End If
'if firstchar<>"" then
 ''   msql=msql&" and firstchar='"&firstchar&"'"
'end if
'if types<>"" then
''    msql=msql&" and charindex(',"&types&",',','+types+',')>0"
''  end if
'if area<>"" then
''    msql=msql&" and area='"&area&"'"
''  end if

If Keyword<>"" Then
    msql=msql&" and (title like '%"&Keyword&"%' or content like '%"&Keyword&"%')"
End If


if order=0 then  
  
  'msql=msql&" Order By permonth Desc,hits desc"
elseif order=1 then
  msql=msql&" Order By posttime Desc"
elseif order=2 then
  msql=msql&" Order By firstchar asc"
elseif order=3 then
  msql=msql&" Order By permonth Desc,hits desc"
end if
    'response.write msql
    msql=msql&" Order By [px] desc,posttime Desc,[ID] Desc"

Easp.Db.PageSize =12
 Set NewsListRs = Easp.Db.GetRS(msql)
  
  If  NewsListRs.Eof Then
    Response.Write "<br />&nbsp;&nbsp;&nbsp;没有找到项目!<br><br><br>"
  Else
      Response.Write ("<ul>")&vbcrlf
    For TrNum=1 To Easp.Db.PageSize
      If NewsListRs.Eof Then Exit For 
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
    
  NewsListRs.MoveNext
    Next
      Response.Write("</ul>")&vbcrlf
    Set NewsListRs = Nothing
    If Easp.Db.PageCount >1 Then
      'Response.Write(""&mypage.showpage()&"")
      'Easp.Db.SetPager("jadebox","{first}{prev}{liststart}{list}{listend}{next}{last}")

      
      Easp.db.SetPager "jadebox", "<div class='pages'>{liststart}{list}{listend}</div><div class='prev'>{prev}</div><div class='next'>{next}</div>", Array("listlong:6","listsidelong:3","prev:&lt; Prev","next:Next &gt;","first:←","last:→")  
      response.write "<div class=""pagediv"">"
      Easp.Print Easp.Db.GetPager("jadebox")
      response.write "</div>"
    End If
  End If


'ShowWriters()
%>
			
		
	</div>
</div>

  
<!--#include virtual="/foot.asp"-->
