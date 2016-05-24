<!DOCTYPE html>
<html lang="ZH-cn">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	<meta name="renderer" content="webkit">		
	<%if seo_keys<>"" then%>
	<meta name="keywords" content="<%=seo_keys%>" />
	<meta name="description" content="<%=content_zy%>" />
	<%else%>
	<meta name="keywords" content="<%=SiteKey%>" />
	<meta name="description" content="<%=SiteDescription%>" />
	<%end if%>
	<meta name="author" content="http://www.westsg.com.cn" />
	<title><%=curpageTitle%></title>
	<link rel="stylesheet" href="css/style.css">
	<link rel="stylesheet" href="css/animate.css">
</head>
<body>
<div class="header">
	<div class="head1">
		<div class="main">
			<div class="fr"><a href="login.asp">登陆</a><a href=""><i class="ico-app"></i>云平台APP</a><a href="tel:400-106-1010">服务热线:<span class="tel">400-106-1010</span></a></div>
			<div class="fl">欢迎来到中机中联工程有限公司！</div>
		</div>
	</div>
	<div class="head2">
		<div class="main">
			<div class="logo"><a href="./"></a></div>
			<div class="nav">
			<%
				set rs=Easp.Db.sel("select top 5 * from category where followid=0 and ishome=1 order by orderid")
				while not rs.eof
					response.write "<div  class=""navli""><a href="""&companyURL(rs("cateid"),rs("catetype"),rs("outlinkurl"),rs("modeltype"),rs("dirpath"),supporthtml)&""">"&rs("catename")&"</a></div>"
					rs.movenext
				wend
				rs.close				
			%>				
			</div>
		</div>
	</div>
</div>
<% if isindex<>1 then%>
<div class="nbanner"> <img src="images/nbanner.jpg"></div>
<%end if%>