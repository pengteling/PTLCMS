<!--#include virtual="/inc/inc.asp" -->
<%

response.buffer=true	
'强制浏览器重新访问服务器下载页面，而不是从缓存读取页面
Response.Buffer = True 
Response.Expires = -1
Response.ExpiresAbsolute = Now() - 1 
Response.Expires = 0 
Response.CacheControl = "no-cache" 
%>


<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    

    <title>后台管理-<%=sitetitle%></title>

    <!-- Bootstrap core CSS -->
<link href="/css/base.css" rel="stylesheet">   
<link href="/css/signin.css" rel="stylesheet">
<script src="/js/base.js" type="text/javascript"></script>



</head>
<body>

    <div class="container">

      <form class="form-signin" role="form" method="post" action="Admin_ChkLogin.asp">
        <h2 class="form-signin-heading">请登陆</h2>
        <input type="text" name="username" id="username" maxlength="16" class="form-control" placeholder="用户名" required autofocus>
        <input type="password" name="password" id="password" maxlength="16" class="form-control" placeholder="密码" required>
        <div class="row">
        <div class="col-xs-4">
         <input type="text"  id="checkcode" name="checkcode" maxlength="4" size="6" class="form-control" placeholder="验证码" required/></div>
         <div class="col-xs-4">
         <img src="../Inc/getcode_zh.asp" alt="验证码,看不清楚?请点击刷新验证码" height="16" style="cursor : pointer;" onClick="this.src='../Inc/getcode_zh.asp?t='+(new Date().getTime());" /></div>
         </div>
        <!--<div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> 记住登陆
          </label>
        </div>-->
        <button class="btn btn-lg btn-primary btn-block" type="submit">登陆</button>
      </form>

    </div> <!-- /container -->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
  </body>
</html>
