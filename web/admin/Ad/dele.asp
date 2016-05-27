<!--#include virtual="/admin/inc/head.asp"-->
<body>

    <div id="wrapper">
    <!--#include virtual="/admin/inc/top.asp"-->

<!-- Page Content -->
        <div id="page-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">广告分类</h1>
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
<%
'定义变量
dim id,tabname,newsUrl,isoutlink
id=Clng(request.QueryString("id"))
tabname=trim(request.QueryString("table"))
%>
<meta http-equiv="refresh" content="1;URL=<%=request.ServerVariables("HTTP_REFERER")%>">
<%
if(tabname="news") then
 	newsUrl=conn.execute("select pagepath from "&tabname&" where id="&id)(0)
 	isoutlink=Cint(conn.execute("select isoutlink from "&tabname&" where id="&id)(0))
 	if(isoutlink=0) then
 	Set fso = Server.CreateObject(xiaodaofso)
 	if not fso.FileExists(server.MapPath("../"&newsUrl)) then  
 		Response.Write("<h1>Error:</h1>" & server.MapPath("../"&newsUrl)&" does not exist<p>")
 		conn.execute("delete from "&tabname&" where id="&id)		
 	else
 		fso.DeleteFile(server.MapPath("../"&newsUrl))
 		Response.Write("<h1>成功删除文件:</h1>" & server.MapPath("../"&newsUrl))
 	end if
 	set fso=nothing
 	end if
else
	
end if
conn.execute("delete from "&tabname&" where id="&id)
call closeconn()
%>
<div align="center">
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p>&nbsp;</p>
  <p class="style1">
  <%response.Write("delete success!")%></p>
</div>

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
