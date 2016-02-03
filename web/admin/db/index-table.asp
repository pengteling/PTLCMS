<!--#include virtual="/admin/inc/head.asp"-->
<body>
    <div id="wrapper">
<!--#include virtual="/admin/inc/top.asp"-->
<!--#include virtual="/admin/db/comm.asp"-->

<link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.10/css/jquery.dataTables.css">
  
<script type="text/javascript" charset="utf8" src="//cdn.datatables.net/1.10.10/js/jquery.dataTables.js"></script>


<link rel="stylesheet" type="text/css" href="/js/Editor/css/editor.dataTables.min.css">
<script type="text/javascript" charset="utf8" src="/js/Editor/js/dataTables.editor.min.js"></script>
<style>
div.DTED_Lightbox_Wrapper {
    left: 1em;
    right: 1em;
    margin-left: 0;
    width: auto;
    z-index:10001;

}
div.DTED_Lightbox_Background {
  z-index:10000;
}
div.DTE_Body div.DTE_Body_Content div.DTE_Field>div.DTE_Field_Input {
    float: right;
    width: 100%;
}
</style>
<script>
/*函数 多图片上传展示处理*/
function SetDropDownPic(url){
  $("#DTE_Field_uploadfiles").val($("#DTE_Field_uploadfiles").val() + url +"|");
  
  $("#productimages").append("<li><img src='" + url + "' width='120' height='120' /><a href='javascript:DelArray("+(($("#DTE_Field_uploadfiles").val()).split("|").length -2).toString()+")'>删除</a></li>");
}

function ShowPics(){
  var ImgUrl,ImgList;
  ImgList="";
  ImgUrl=$("#DTE_Field_uploadfiles").val();
  ImgUrlArray=ImgUrl.split("|");

  if(ImgUrlArray.length<=1){
  //document.write('您没有上传图片');

  }
  for(i=0;i<ImgUrlArray.length-1;i++){
  ImgList=ImgList+"<li><img src='" + ImgUrlArray[i] + "' width='120' height='120' /><a href='javascript:DelArray("+i+")'>删除</a></li>"
  }
  $("#productimages").html(ImgList);
}
function DelArray(n)
{
  
  if(confirm("确定要删除该图片？删除后点击下面【确认修改】才会生效！")){
  ImgList="";
  var arraylist="";
  ImgUrl=$("#DTE_Field_uploadfiles").val();
  ImgUrlArray=ImgUrl.split("|");
  for(i=0;i<ImgUrlArray.length-1;i++){
    if (i!=n){
ImgList=ImgList+"<li><img src='" + ImgUrlArray[i] + "' width='120' height='120' /><a href='javascript:DelArray("+(i>n?i-1:i)+")'>删除</a></li>";
arraylist=arraylist+ImgUrlArray[i]+"|";
    }
}
$("#DTE_Field_uploadfiles").val(arraylist);
$("#productimages").html(ImgList);
  }
  }

</script>
<script>
/*
 * Editor client script for DB table news
 * Created by http://editor.datatables.net/generator
 */
var k =1;
var editor1,editor2;
(function($){

$(document).ready(function() {
  var editor = new $.fn.dataTable.Editor( {
    ajax: 'getdatajson.asp',
    table: '#news',
    fields: [

      {
        "label": "标题",
        "name": "title"
      }, {
                "label": "图片:",
                "name": "defaultpicurl",
                "type": "text"                
                
            },
            {
                "label": "大图片:",
                "name": "uploadfiles",
                "type": "text"                
                
            },
      {
        "label": "摘要",
        "name": "content_zy",
        "type": "textarea"
      },
      {
        "label": "内容",
        "name": "content",
        "type": "textarea"
      }
    ]
  } );
 // New record
    $('a.editor_create').on('click', function (e) {
        e.preventDefault();
 
        editor.create( {
            title: '增加记录',
            buttons: 'Add'
        } );
    } );
 
    // Edit record
    $('#news').on('click', 'a.editor_edit', function (e) {
        e.preventDefault();
 
        editor.edit( $(this).closest('tr'), {
            title: 'Edit record',
            buttons: 'Update'
        } );
    } );
 
    // Delete a record
    $('#news').on('click', 'a.editor_remove', function (e) {
        e.preventDefault();
 
        editor.remove( $(this).closest('tr'), {
            title: 'Delete record',
            message: 'Are you sure you wish to remove this record?',
            buttons: 'Delete'
        } );
    } );



    editor.on('open', function(e,json,data) {
    //editor.show(); //Shows all fields
    //editor.hide('ID');
    //editor.hide('Field_Name_1');
    //alert($("#DTE_Field_content_zy").val());
  //if(editor.modifier().attr("id")==data.DT_RowId){

     $.getScript('/kindeditor/kindeditor-min.js', function() {
            KindEditor.basePath = '/kindeditor/';
            //editor1 =KindEditor.create('textarea');
            var options ={
               basePath :'/kindeditor/',
              allowFileManager : true,  
              cssPath : '/kindeditor/plugins/code/prettify.css',
              uploadJson : '/kindeditor/asp/upload_json.asp',
              fileManagerJson : '/kindeditor/asp/file_manager_json.asp'
            };
            editor1 = KindEditor.create("#DTE_Field_content",options);
            //editor2 = KindEditor.create("#DTE_Field_content_zy",options);
            //editor1.sync();
            //alert($("textarea").val());
                          //增加上传按钮
              if($('#image3').length<=0){
                          $("<input type='button' value='上传图片' id='image3'>").insertAfter("#DTE_Field_defaultpicurl");

                          $("<input type='button' value='上传多图' id='J_selectImage'>").insertAfter("#DTE_Field_uploadfiles");
                          $("<ul id='productimages'></ul>").insertAfter("#J_selectImage");
                          $("#DTE_Field_uploadfiles").hide();
                          ShowPics();

                          // var editor = KindEditor.editor({
                          //   basePath :'/kindeditor/',
                          //   allowFileManager : true,  
                          //   cssPath : '/kindeditor/plugins/code/prettify.css',
                          //   uploadJson : '/kindeditor/asp/upload_json.asp',
                          //   fileManagerJson : '/kindeditor/asp/file_manager_json.asp'
                          // });

                          $('#image3').click(function() {
                            editor1.loadPlugin('image', function() {
                              editor1.plugin.imageDialog({
                                showRemote : true,
                                imageUrl : $('#DTE_Field_defaultpicurl').val(),
                                clickFn : function(url, title, width, height, border, align) {
                                  $('#DTE_Field_defaultpicurl').val(url);
                                  editor1.hideDialog();
                                }
                              });
                            });
                          });

                          $('#J_selectImage').click(function() {
                        editor1.loadPlugin('multiimage', function() {
                          editor1.plugin.multiImageDialog({
                            clickFn : function(urlList) {
                              //var div = K('#productimages');
                              //div.html('');          
                              //$('#DTE_Field_uploadfiles').val(urlList);     
                              $.each(urlList, function(i, url) {
                                //div.append('<li><img src="' + url.url + '"></li>');
                                SetDropDownPic(url.url);
                              });
                              editor1.hideDialog();
                            }
                          });
                        });
                      });
              }
              //上传图片插件结束

          });
  // }
     
     
    //alert($("textarea").val());
});
    editor.on('processing',function(){
      //alert("er");
      
   //if(editor.modifier().attr("id")==data.DT_RowId){
    editor1.sync();
   // editor2.sync();
    
  //    alert("33");
      console.log("Eee");
      //editor.fields("DTE_Field_content_zy").html(editor1.html());
   // }
      //alert(editor1.html());
      
      //KindEditor.remove('textarea');
    })
    editor.on('close',function(){
      //alert("erer");

      KindEditor.remove('textarea');
    })

  var table = $('#news').DataTable( {
     "order": [[ 3, "desc" ]],
    // dom: 'Bfrtip',
    // ajax: 'getdatajson.asp',
    
    select: true,
    lengthChange: false,
    buttons: [
      { extend: 'create', editor: editor },
      { extend: 'edit',   editor: editor },
      { extend: 'remove', editor: editor }
    ]
  } );
} );

}(jQuery));

</script>
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


      <h1>
        DataTables Editor <span>news</span>
      </h1>
      <a href="" class="editor_create">添加新记录</a>
      <table cellpadding="0" cellspacing="0" border="0" class="display" id="news" width="100%">
        <thead>
          <tr>
            <th>id</th>
            <th>title</th>
            <th>content</th>
            <th>时间</th>
            <th>Edit / Delete</th>
          </tr>
        </thead>
        <tbody>
          <%
Easp.Db.PageSize = 3
Set rs = Easp.Db.GetRS("Select "&columns_data&" from "&tablename&" order by id desc")

'Easp.Print Easp.Encode(rs)
'Easp.Db.Close(rs)
while not rs.eof
response.write "<tr id='row_"&rs("id")&"'>"
columns_arr = split(columns_data,",")
for i = 0 to ubound(columns_arr)
response.write "<td>"&rs(columns_arr(i))&"</td>"

next
response.write "<td><a href="""" class=""editor_edit"">Edit</a> / <a href="""" class=""editor_remove"">Delete</a></td>"
response.write "</tr>"

rs.movenext
wend
rs.close


          %>
        </tbody>
      </table>

<%
response.write Easp.Db.GetPager("bootstrap")

%>



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