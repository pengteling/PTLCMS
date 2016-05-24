<!-- Navigation -->
        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="#"><%=sitetitle%>后台管理系统</a>
            </div>
            <!-- /.navbar-header -->

            <ul class="nav navbar-top-links navbar-right">
                
            
                <!-- /.dropdown -->
                <li class="dropdown">
                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                        <i class="fa fa-user fa-fw"></i>  <i class="fa fa-caret-down"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-user">
                        <li><a href="/admin/manager/Manage_Admin.asp"><i class="fa fa-user fa-fw"></i> 管理员</a>
                        </li>
                        <li><a href="/admin/config/siteconfig.asp"><i class="fa fa-gear fa-fw"></i> 网站配置</a>
                        </li>
                        <li><a href="/" target="_blank"><i class="fa fa-files-o fa-fw"></i> 预览网站</a></li>
                        <li class="divider"></li>
                        <li><a href="/admin/loginout.asp"><i class="fa fa-sign-out fa-fw"></i> 退出</a>
                        </li>
                    </ul>
                    <!-- /.dropdown-user -->
                </li>
                <!-- /.dropdown -->
            </ul>
            <!-- /.navbar-top-links -->

            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
<%
    if session("AdminName")="pengteling" then
%>            
 <li>
    <a href="#"><i class="fa fa-list fa-fw"></i> 网站页面<span class="fa arrow"></span></a>
    <ul class="nav nav-second-level">   
     <li> <a href="/admin/catepage/companyadd.asp">添加页面</a></li>
      <li> <a href="/admin/catepage/companyall.asp">页面管理</a></li>

      </ul>
      </li>   
        <%
        end if

        set rs2=server.CreateObject("adodb.recordset")
        rs.open "Select * from catepage_c where depth=1 "&sql_sonid_page&"  order by orderid",conn,1,1
        while not rs.eof
        %> 

<li>
    <a href="#"><i class="fa fa-list fa-fw"></i> <%=rs("catename")%><span class="fa arrow"></span></a>
    <ul class="nav nav-second-level">                                
    <%
 ' response.write "Select * from catepage where depth=2 "&sql_sonid_page&" and followid="& rs("cateid")&" order by orderid"
rs2.open "Select * from catepage_c where depth=2 "&sql_sonid_page&" and followid="& rs("cateid")&"  order by orderid",conn,1,1
while not rs2.eof

%>
<li> <a href="/admin/<%=rs2("outlinkurl")%>"><%=rs2("catename")%></a></li>
<%
rs2.movenext
wend
rs2.close  
  
  

    %>
    </ul>
                            <!-- /.nav-second-level -->
</li>


  <%
  rs.movenext
  wend
  rs.close  %>

                       
                        
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        </nav>