<!--#include virtual="/admin/inc/head.asp"-->


<body>

    <div id="wrapper">
    <!--#include virtual="/admin/inc/top.asp"-->

<!-- Page Content -->
        <div id="page-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">添加信息</h1>
                    </div>
                    <!-- /.col-lg-12 -->
</div>
                     <!-- /.row -->
                <div class="row">
                  <div class="panel panel-default">
                       <!--  <div class="panel-heading">
                            Kitchen Sink
                        </div> -->
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
<!-- #include file="news_config.asp" -->
<%
if request("category")<>"" and request("title")<>"" then
	title=ChkFormStr(Request("Title"))
	category=ChkFormStr(Request("category"))
	rs.open "select top 1 * from keys",conn,1,3
	rs.addnew
	rs("title")=title
	rs("category")=category
	rs.update
	rs.close
	set rs=nothing
	response.redirect "keywords.asp"
end if
%>
<table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" class="table_southidc">
  <form name="myform" method="post" action="?" onSubmit="return CheckForm();">
    <tr>
      <td height="30" colspan="3" align="center" class="blod">增加关键词</td>
    </tr>
    <tr bgcolor="#ECF5FF">
      <td height="22" align="center" class="tr_southidc">关键词名称：</td>
      <td colspan="2" width="80%"><input name="title" type="text" class="input" size="30"></td>
    </tr>
    <tr bgcolor="#ECF5FF">
      <td height="22" align="center" class="tr_southidc">所属类别：</td>
      <td colspan="2" width="80%">
<select name="category" id="category">

	<option value="小说书籍">小说书籍</option>
	<option value="作家信息">作家信息</option>
	<option value="新闻资讯">新闻资讯</option>
  <option value="搜索框热词">搜索框热词</option>
</select>
      </td>
    </tr>
    <tr>
      <td height="30" colspan="3" align="center" bgcolor="#ECF5FF"><input type="submit" name="Submit" value="确认添加" class="input">
        
        &nbsp;
        <input type="button" name="Submit2" value="返回上一页" class="input" onClick="history.go(-1);">
        </td>
        </tr>
    </form>
    </table>

</div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                </div>

                </div>
                <!-- /.row -->
            </div>
            <!-- /.container-fluid -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->




</body>
</html>