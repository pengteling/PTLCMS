<!--#include virtual="/inc/inc.asp"-->
<%

curpageTitle="CMCU云登陆-"&SiteTitle 

%>

<!--#include virtual="/top.asp"-->

<div class="login-main">
	<div class="main">
		<div class="login-container">
			<h3>欢迎登录CMCU云平台</h3>
			<form action="?" method="post">
			<input type="text" class="ipt-user" placeholder="youremail@gmail.com" required="required" >
			<input type="password" class="ipt-pwd" placeholder="•••••••••••••" required="required" >
			<input type="submit" class="ipt-submit" value="登录">
			</form>
			<div class="splitline"><div class="hr1"></div><div class="words">or</div><div class="hr2"></div></div>
			<div class="somemore">
				<div class="fr">没有账号？赶快 <a href="">注册</a> 吧</div>
				<div class="fl"><a href="">忘记密码？</a></div>
			</div>
		</div>
	</div>
</div>

<!--#include virtual="/foot.asp"-->