<!--#include virtual="/inc/inc.asp"-->

<%
nid=strToNum(Request.QueryString("id"))
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
curpageTitle= newstitle &"-"&catename&"-"&SiteTitle
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
			<input type="text" name="key" id="key" placeholder="Search"><input type="submit" id="search">
		</form>
		</div>
		
		<div class="cate1">
			<a href="">全部</a>
			<a href="" class="on">建筑工程</a>
			<a href="">工业工程</a>
			<a href="">市政工程</a>
			<a href="">国际工程</a>
			<a href="">工程建设</a>
			<a href="">BIM设计</a>
		</div>	

		<div class="box-greybg">
			<div class="cate2">
				<a href="">规划设计</a>
				<a href="" class="on">创意设计</a>
				<a href="">创意设计</a>
				<a href="">创意设计</a>
			</div>
			<div class="cate3">
				<a href="">住宅/公寓/宿舍</a>
				<a href="">商业/办公建筑</a>
				<a href="" class="on">学校/科研建筑</a>
				<a href="">文化/展示建筑</a>
				<a href="">酒店/会所/医疗</a>
				<a href="">工/农业建筑</a>
				<a href="">建筑结构</a>
				<a href="">建筑电气</a>
				<a href="">给排水</a>
				<a href="">暖通空调</a>
				<a href="">绿色建筑</a>
				<a href="">其他</a>
			</div>
		</div>
	</div>
	<div class="tabcon">
		<ul>
			<li><a href="">
				<div class="pic"><img src="images/xm-pic-1-big.jpg" alt=""></div>
				<div class="tit">设计项目名字文字</div>
				<div class="time-views">
					<div class="time">2016/03/03</div>
					<div class="views">1338 次</div>
				</div>
				</a>
			</li>
			<li><a href="">
				<div class="pic"><img src="images/xm-pic-1-big.jpg" alt=""></div>
				<div class="tit">设计项目名字文字</div>
				<div class="time-views">
					<div class="time">2016/03/03</div>
					<div class="views">1338 次</div>
				</div>
				</a>
			</li>
			<li><a href="">
				<div class="pic"><img src="images/xm-pic-1-big.jpg" alt=""></div>
				<div class="tit">设计项目名字文字</div>
				<div class="time-views">
					<div class="time">2016/03/03</div>
					<div class="views">1338 次</div>
				</div>
				</a>
			</li>
			<li><a href="">
				<div class="pic"><img src="images/xm-pic-1-big.jpg" alt=""></div>
				<div class="tit">设计项目名字文字</div>
				<div class="time-views">
					<div class="time">2016/03/03</div>
					<div class="views">1338 次</div>
				</div>
				</a>
			</li>
			<li><a href="">
				<div class="pic"><img src="images/xm-pic-1-big.jpg" alt=""></div>
				<div class="tit">设计项目名字文字</div>
				<div class="time-views">
					<div class="time">2016/03/03</div>
					<div class="views">1338 次</div>
				</div>
				</a>
			</li>
			<li><a href="">
				<div class="pic"><img src="images/xm-pic-1-big.jpg" alt=""></div>
				<div class="tit">设计项目名字文字</div>
				<div class="time-views">
					<div class="time">2016/03/03</div>
					<div class="views">1338 次</div>
				</div>
				</a>
			</li>
			<li><a href="">
				<div class="pic"><img src="images/xm-pic-1-big.jpg" alt=""></div>
				<div class="tit">设计项目名字文字</div>
				<div class="time-views">
					<div class="time">2016/03/03</div>
					<div class="views">1338 次</div>
				</div>
				</a>
			</li>
			<li><a href="">
				<div class="pic"><img src="images/xm-pic-1-big.jpg" alt=""></div>
				<div class="tit">设计项目名字文字</div>
				<div class="time-views">
					<div class="time">2016/03/03</div>
					<div class="views">1338 次</div>
				</div>
				</a>
			</li>

		</ul>
		<div class="pagediv">
			<div class="pages">
				<a href="">01</a>
				<a href="">02</a>
				<a href="" class="on">03</a>
				<a href="">04</a>
				<a href="">05</a>
			</div>
			<div class="prev"><a href="">&lt; Prev</a></div>
			<div class="next"><a href="">Next &gt;</a></div>
		</div>
		
	</div>
</div>

  <%



Function ShowWriters()
  TrNum=0
  cateid = strToNum(Request("id"))  
  Keyword = ChkFormStr(Request("so"))
  
  msql="Select * from project where isdel=0 and passed=1 "
If cateid<>0 Then
    'msql=msql&" and cateid="&cateid&""
   msql=msql&" and cateid in ("&sonid&")"
End If
if firstchar<>"" then
    msql=msql&" and firstchar='"&firstchar&"'"
end if
if types<>"" then
    msql=msql&" and charindex(',"&types&",',','+types+',')>0"
  end if
if area<>"" then
    msql=msql&" and area='"&area&"'"
  end if

If Keyword<>"" Then
    msql=msql&" and (title like '%"&Keyword&"%' or content like '%"&Keyword&"%')"
End If

if order=0 then  
  'msql=msql&" Order By [px] desc,posttime Desc,[ID] Desc"
  msql=msql&" Order By permonth Desc,hits desc"
elseif order=1 then
  msql=msql&" Order By posttime Desc"
elseif order=2 then
  msql=msql&" Order By firstchar asc"
elseif order=3 then
  msql=msql&" Order By permonth Desc,hits desc"
end if
    'response.write msql

Easp.Db.PageSize =12
 Set NewsListRs = Easp.Db.GetRS(msql)
  
  If  NewsListRs.Eof Then
    Response.Write "<br />&nbsp;&nbsp;&nbsp;没有找到符合条件的作家!"
  Else
      Response.Write ("<div class=""writerlist""><ul>")&vbcrlf
    For TrNum=1 To Easp.Db.PageSize
      If NewsListRs.Eof Then Exit For 
%>
<li>
              <div class="pic"><img src="<%=NewsListRs("defaultpicurl")%>" alt=""></div>
              <div class="bluemb">
                <p><a href="writer.asp?id=<%=NewsListRs("id")%>">
                    <%=leftstr(NewsListRs("content_zy"),200)%>
                  </a></p>
                  <div class="icon">
                    <a href="http://weibo.com/u/<%=NewsListRs("weibo")%>" target="_blank"><i class="fa fa-weibo"></i></a>
                    <a href="javascript:;" class="heartbeat"><i class="fa fa-heart"></i></a>
                    <a href="writer.asp?id=<%=NewsListRs("id")%>"><i class="fa fa-align-right"></i></a>
                  </div>
              </div>
              <div class="wtit"><a href="writer.asp?id=<%=NewsListRs("id")%>"><%=NewsListRs("title")%></a></div>
            <!--   <div class="wcate"><a href="">分类名称</a></div> -->

</li>
<%    
    
  NewsListRs.MoveNext
    Next
      Response.Write("</ul>")&vbcrlf
    Set NewsListRs = Nothing
    If Easp.Db.PageCount >1 Then
      'Response.Write(""&mypage.showpage()&"")
      'Easp.Db.SetPager("jadebox","{first}{prev}{liststart}{list}{listend}{next}{last}")
      Easp.db.SetPager "jadebox", "{first}{prev}{liststart}{list}{listend}{next}<span class='last'>{last}</span>", Array("listlong:6","listsidelong:3","prev:上一页","next:下一页","first:←","last:→")  
      response.write "<div class=""pagediv""><div class=""pagebar"">"
      Easp.Print Easp.Db.GetPager("jadebox")
      response.write "</div></div>"
    End If
  End If

End Function
'ShowWriters()
%>
<!--#include virtual="/foot.asp"-->
