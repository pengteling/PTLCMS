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
/*
 * Editor client script for DB table news
 * Created by http://editor.datatables.net/generator
 */
var k =1;
var editor1;
(function($){

$(document).ready(function() {
  var editor = new $.fn.dataTable.Editor( {
    ajax: 'getdatajson.asp',
    table: '#news',
    fields: [
      {
        "label": "title",
        "name": "title"
      },
      {
        "label": "content",
        "name": "content_zy",
        "type": "textarea"
      }
    ]
  } );
 // New record
    $('a.editor_create').on('click', function (e) {
        e.preventDefault();
 
        editor.create( {
            title: 'Create new record',
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
            editor1 =KindEditor.create('textarea');
            //editor1.sync();
            //alert($("textarea").val());
          });
  // }
     
     
    //alert($("textarea").val());
});
    editor.on('processing',function(){
      //alert("er");
      
   //if(editor.modifier().attr("id")==data.DT_RowId){
      editor1.sync();
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
    dom: 'Bfrtip',
    ajax: 'getdatajson.asp',
    columns: [
      {
        "data": "title"
      },
      {
        "data": "content_zy"
      },
      {
                "data": "null",
                "className": "center",
                "defaultContent": '<a href="" class="editor_edit">Edit</a> / <a href="" class="editor_remove">Delete</a>'
            }
    ],
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
            <th>title</th>
            <th>content</th>
            <th>Edit / Delete</th>
          </tr>
        </thead>
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