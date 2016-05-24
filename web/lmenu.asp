<%rs.open "select cateid,catename,catename_en,outlinkurl,catetype,modeltype,catedir,sonid,defaultpicurl from category where cateid in("&parentid&") order by depth ",conn,1,1
k=1
menustr = "<a href=""/"">首页</a>"
while not rs.eof 

if k=1 then
	cateId_d1=rs("Cateid")
	catename_d1=rs("catename")
	catename_d1_en= rs("catename_en")
	catedir_d1=rs("catedir")
	sonid_d1 =rs("sonid")
	defaultpic_d1=rs("defaultpicurl")
end if
if k=2 then
cateId_d2 = rs("Cateid")
sonid_d2 =rs("sonid")
'if rs("defaultpicurl")<>"" then defaultpic_d1=rs("defaultpicurl")
end if

if k=3 then
cateId_d3 = rs("Cateid")
sonid_d3 =rs("sonid")
end if

if cateid=rs("cateid") then
menustr = menustr &" > <a href="""& companyURL(rs("cateid"),rs("catetype"),rs("outlinkurl"),rs("modeltype"),rs("catedir"),supportHtml)&"""><span class=""red"">"&rs("catename")&"</span></a>"
else
menustr = menustr &" > <a href="""& companyURL(rs("cateid"),rs("catetype"),rs("outlinkurl"),rs("modeltype"),rs("catedir"),supportHtml)&""">"&rs("catename")&"</a>"
end if
'menustr = menustr&" >> "&rs("catename")
k=k+1

rs.movenext
wend
rs.close


currentTitle=catename
curpageTitle= catename&"-"&SiteTitle
%>