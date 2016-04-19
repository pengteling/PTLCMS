<!--#include virtual="/admin/inc/head.asp"-->
<body>

    <div id="wrapper">
    <!--#include virtual="/admin/inc/top.asp"-->

<!-- Page Content -->
        <div id="page-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">数据库备分</h1>
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
if request("action")="Backup" then

conn.execute ("backup database xannad to DISK =N'"&Server.MapPath("../../fdatabase")&"\"& formatdate(date(),2)& hour(now()) &Minute(now()) &second(now())&".bak'")
result="备分成功！"
end if
%>

     <table cellspacing=1 cellpadding=1 align=center width="90%">                

      <tr>

       <th height=25 >

       &nbsp;&nbsp;<B>数据库备份</B>

       </th>

      </tr>

      <form method="post" action="?action=Backup">

      <tr>

       <td height=100  style="line-height:150%">

             

              

      &nbsp;&nbsp;<input type=submit value="备份数据"><hr align="center" width="90%" color="#999999">&nbsp;&nbsp;<font color="#666666">·<%=result%></font></td>

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