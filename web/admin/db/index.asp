<!--#include virtual="/admin/inc/head.asp"-->
<body>
    <div id="wrapper">
<!--#include virtual="/admin/inc/top.asp"-->

<!-- Page Content -->
        <div id="page-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">数据管理</h1>
                    </div>
                    <!-- /.col-lg-12 -->
</div>
                     <!-- /.row -->
                <div class="row">
                  <div class="panel panel-default">
                        <div class="panel-heading">
                            列表
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        <div class="table-responsive">
<%
columns = "id,title,content_zy"
columns_name ="ID,名称,内容"
tablename = "news_c"
%>

<table  class="table table-striped table-bordered table-hover">
    <thead id="theadlist">
    <tr>
        <%
        columns_name_arr = split(columns_name,",")
        for i =0 to ubound(columns_name_arr)
        response.write "<th>"&columns_name_arr(i)&"</th>"
        next
        %>
        <th>操作</th>
    </tr>
                                        
    </thead>
    <tbody id="datalist">
    </tbody>
</table>

<script>
$(function(){
var json =<%
Set rs = Easp.Db.Query("Select "&columns&" from "&tablename&"")
Easp.Print Easp.Encode(rs)
Easp.Db.Close(rs)
%>;
var transform = {"tag":"tr","children":[
<%
columns_arr = split(columns,",")
for i=0 to ubound(columns_arr)
    %>
{"tag":"td","html":"${<%=columns_arr(i)%>}"}
<%
    if i=ubound(columns_arr) then

        else
            response.write ","
    end if
next

%>,{"tag":"td","html":"<a href='javascript:void(0)' data-toggle='modal' data-target='#win-new-info' data-infoid='${id}'>编辑</a> <a data-toggle='modal' data-target='#myModal' data-infoid='${id}'>删除</a>"}
  ]};
$("#datalist").json2html(json.rows,transform);

//alert(json.rows[0]);
// var tempstr="";
// var json2 = json.rows[0];
// for (var i in json2){
//     tempstr += "<th>"+i+"</th>";

// }
// tempstr="<tr>"+tempstr+"</tr>";

// $("#theadlist").html(tempstr);

})  ;
</script>




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



 <div class="modal fade" id="win-new-info" role="dialog" aria-hidden="true" tabindex="-1">
    <div class="modal-dialog">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
          <h4 class="modal-title" id="modal-title">添加新网站</h4>
        </div>
        <div class="modal-body">
          <form action="?action=savenew" method="post" class="form" id="form-addnew">
            <input type="hidden" name="cid" id="cid" value="">
            <div class="form-group">
              <label for="title" class="control-label">网站名称：</label>
              <input type="text" name="sitename" id="sitename_add" class="form-control" value="" placeholder="请输入..." />
            </div>
            <div class="form-group">
              <label for="title" class="control-label">客户名称：</label>
              <input type="text" name="sitecompany" id="sitecompany_add" class="form-control" value="" placeholder="请输入..." />
            </div>
            <div class="form-group">
              <label for="title" class="control-label">联系人：</label>
              <input type="text" name="lxperson" id="lxperson_add" class="form-control" value="" placeholder="请输入..." />
            </div>
            <div class="form-group">
              <label for="title" class="control-label">联系电话：</label>
              <input type="text" name="lxtel" id="lxtel_add" class="form-control" value="" placeholder="请输入电话..." />
            </div>
            <div class="form-group">
              <label for="title" class="control-label">上线时间：</label>
              <input type="text" name="start_date" id="start_date_add" class="form-control" value="2016-01-21" placeholder="格式形如2014-5-23..." />
            </div>
          </form>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
          <button type="button" class="btn btn-primary" id="btn-sumbit">保存</button>
        </div>
      </div>
      <!-- /.modal-content --> 
    </div>
    <!-- /.modal-dialog --> 
  </div>
  <div class="modal small fade" id="myModal" role="dialog" aria-hidden="true" tabindex="-1">
    <div class="modal-dialog modal-sm">
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
          <h3 id="myModalLabel">确认删除</h3>
        </div>
        <div class="modal-body">
          <p class="error-text"><i class="icon-warning-sign modal-icon"></i>确认要删除这个网站?删除后无法恢复！</p>
        </div>
        <div class="modal-footer">
          <button class="btn" data-dismiss="modal" aria-hidden="true">取消</button>
          <a href="Del.asp?id=XXX" class="btn btn-danger">删除</a> </div>
      </div>
    </div>
  </div>

</body>
</html>