﻿<!--#include virtual="/admin/inc/head.asp"-->


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
<%
dim rs
dim sql
dim count
followid=strToNum(request("cateid"))

'Call p_cate(followid,2)
%>
<script language = "JavaScript">

function CheckForm()
{

	if (document.myform.title.value.length == 0) {
		alert("信息标题没有填写.");
		document.myform.title.focus();
		return false;
	}
		if (document.myform.Author.value.length == 0) {
		alert("信息发布人没有填写");
		document.myform.Author.focus();
		return false;
	}
		if (document.myform.ComeFrom.value.length == 0) {
		alert("信息来源没有填写");
		document.myform.ComeFrom.focus();
		return false;
	}
	editor1.sync();
	//editor2.sync();
	if (document.myform.content.value.length == 0){
		alert("信息内容不能为空！");
		
		return false;
	}
    
 return true; 
	
}

function SetDropDownPic(url){
	document.myform.UploadFiles.value=document.myform.UploadFiles.value + url +"|";
	document.myform.IncludePic.value="1";
}
</script>

<table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" class="table_southidc">
  <form name="myform" method="post" action="News_save.asp" onSubmit="return CheckForm();">
    
    <tr bgcolor="#ffffff">
      <td height="22" align="center" class="tr_southidc">信息标题：</td>
      <td colspan="2" width="80%"><input name="title" type="text" class="input" size="30">
        
        <!-- 颜色：<input name="color" id="color_t" class="input" size="10"/>
        
        <img src="../images/color.png" id="pickcolor"> 
        <script src="/js/jquery.colorpicker.js"></script>
        <script type="text/javascript">
    $(function(){
        $.showcolor('pickcolor','color_t');//第一参数：按钮ID，第二参数： 文本框ID
       
    })
</script>-->
            </td>
    </tr>
    <tr>
            <td height="22" align="center" class="tr_southidc">信息类别：</td>
            <td colspan="2" class="tr_southidc"><div align="left">
            
            	<select name="cateid">
          
          <%

set rs=server.CreateObject("adodb.recordset")
			rs.open "select cateid,catename,followid,depth,sonid,parentid,orderID from category where catetype<=3 "&sql_sonid&" order by depth,orderID",conn,1,1
			if not rs.eof then
				data= rs.getRows()
			end if
			rs.close
			
	class_list=""
	
	
sub classlist(byval t0)
		dim i
		for i=0 to ubound(data,2)
			if t0=data(2,i) then
				if followid = data(0,i) then
					isslected="selected"
				else
					isslected=""
				end if
				class_list=class_list&"<option value="""&data(0,i)&""" "&isslected&">"

For k=2 To data(3,i)
class_list=class_list&"&nbsp;&nbsp;&nbsp;&nbsp;"
next

If data(3,i)>1 then class_list=class_list& "├"
				class_list=class_list& data(1,i)&"</option>"
				
				classlist(data(0,i))
			end if
		next
	end sub
	if isarray(data) then	
		call classlist(0)	
	end if	
		response.write class_list
		  %>
        </select>
            	</div></td>
          </tr>
   <!--<input name="Author" type="hidden" id="auther" value="<%=session("AdminName")%>" >     -->  
 
    <tr bgcolor="#ffffff">
      <td height="25" align="center">发 布 人：</td>
      <td colspan="2"><input name="Author" type="text" id="auther" value="<%=session("AdminName")%>" >
       <span class="TableRow1">
        <select name=font2 onChange="Author.value=this.value;">
          <option selected value="">选择作者</option>
          <option value='佚名'>佚名</option>
          <option value='本站'>本站</option>
          <option value='不详'>不详</option>
          <option value='未知'>未知</option>
          <option value='admin'>admin</option>
        </select>
      </span></td>
    </tr>
    <tr bgcolor="#ffffff">
      <td height="25" align="center">信息来源：</td>
      <td colspan="2"><input name="ComeFrom" type="text" id="ComeFrom" value="网络">
        <span class="TableRow1">
        <select name=font1 onChange="ComeFrom.value=this.value;">
          <option selected value="">选择来源</option>
          <option value='本站原创'>本站原创</option>
          <option value='本站整理'>本站整理</option>
          <option value='不详'>不详</option>
          <option value='转载'>转载</option>
        </select>
      </span></td>
    </tr>
    <tr bgcolor="#ffffff">
      <td height="25" align="center" valign="top">信息摘要：</td>
      <td colspan="2" valign="top"><textarea id="content_zy" name="content_zy" style="width:700px;height:60px;visibility:;"></textarea>限255字</td>
    </tr>
    <tr bgcolor="#ffffff">
      <td height="25" align="center" valign="top">信息内容：</td>
      <td colspan="2" valign="top"> 
            <link rel="stylesheet" href="/kindeditor/themes/default/default.css" />
	 <link rel="stylesheet" href="/kindeditor/plugins/code/prettify.css" />
	<script charset="utf-8" src="/kindeditor/kindeditor.js"></script>
	<script charset="utf-8" src="/kindeditor/lang/zh_CN.js"></script>
	<script charset="utf-8" src="/kindeditor/plugins/code/prettify.js"></script>
	<script>
		var editor1;
		KindEditor.ready(function(K) {
			editor1 = K.create('#contentid', {
				cssPath : '/kindeditor/plugins/code/prettify.css',
				uploadJson : '/kindeditor/asp/upload_json.asp',
				fileManagerJson : '/kindeditor/asp/file_manager_json.asp',
				allowFileManager : true,
				filterMode : false, // true:开启过滤模式, false:关闭过滤模式
				afterCreate : function() {
					var self = this;
					K.ctrl(document, 13, function() {
						self.sync();
						K('form[name=example]')[0].submit();
					});
					K.ctrl(self.edit.doc, 13, function() {
						self.sync();
						K('form[name=example]')[0].submit();
					});
				}
				
			});
			
			prettyPrint();
			
			
		});
		
		KindEditor.ready(function(K) {
				var editor = K.editor({
					allowFileManager : true,	
					cssPath : '/kindeditor/plugins/code/prettify.css',
					uploadJson : '/kindeditor/asp/upload_json.asp',
					fileManagerJson : '/kindeditor/asp/file_manager_json.asp'
				});
			
				K('#image3').click(function() {
					editor.loadPlugin('image', function() {
						editor.plugin.imageDialog({
							showRemote : true,
							imageUrl : K('#DefaultPicUrl').val(),
							clickFn : function(url, title, width, height, border, align) {
								K('#DefaultPicUrl').val(url);
								editor.hideDialog();
							}
						});
					});
				});
			});


			</script>
<textarea id="contentid" name="content"  style="width:700px;height:500px;visibility:hidden;"></textarea>
 <div>
       <input name="saveimg" type="checkbox" value="1">保存远程图片</div>
         </td>
    </tr>

    <tr bgcolor="#ffffff">
      <td height="22" align="center" class="tr_southidc">关键词：</td>
      <td colspan="2" width="80%"><input name="keys" type="text" class="input" size="50">用英文逗号,分隔
      </td>
    </tr>
     
    <tr>
      <td height="30" align="center" bgcolor="#ffffff"><span class="tr_southidc">首页图片：</span></td>
      <td width="301" height="30" bgcolor="#ffffff"><span class="tr_southidc">
        <input name="DefaultPicUrl" type="text" id="DefaultPicUrl" value="" size="30" maxlength="120" />
      </span></td>
      <td width="495" bgcolor="#ffffff"><span class="tr_southidc">
       <!-- <input type="button" name="Submit22" value="直接从上传图片中选择" onClick="window.open('../SelectPic.asp','','status=no,scrollbars=yes,top=300,left=200,width=396,height=254');" />-->
        <input name="Submit222" type="button" value="上传图片"   id="image3">
      </span></td>
    </tr>
    <tr>
      <td height="30" align="center" bgcolor="#ffffff"><span class="tr_southidc">是否推荐：</span></td>
      <td height="30" colspan="2" align="left" bgcolor="#ffffff"><input name="Elite" type="checkbox" id="Elite" value="yes">是<font color="#0000FF">（如果选中的话将在首页做为图片信息显示）</font></td>
    </tr>
	<tr>
      <td height="30" align="center" bgcolor="#ffffff">排序：</td>
      <td height="30" colspan="2" align="left" bgcolor="#ffffff"><span class="tr_southidc">
        <input name="px" type="text" id="px" value="0" size="10" maxlength="5" />
        数字越大越靠前
      </span></td>
    </tr>
    <tr>
      <td height="30" align="center" bgcolor="#ffffff">通过审核：</td>
      <td height="30" colspan="2" align="left" bgcolor="#ffffff"><span class="tr_southidc">
        
        <input name="Passed" type="checkbox" id="Passed" value="yes" checked>是<font color="#0000FF">（如果选中的话将直接发布）</font>
      </span></td>
    </tr>
    <tr>
      <td height="30" align="center" bgcolor="#ffffff"><span class="tr_southidc">发布时间：</span></td>
      <td height="30" colspan="2" align="left" bgcolor="#ffffff"><span class="tr_southidc">
        <input name="PostTime" type="text" id="PostTime" value="<%=Now()%>" size="30" maxlength="120" />
      </span><font color="#0000FF">（为了避免出错，尽量不要更改。格式：<%=Now()%>）</font></td>
    </tr>
    <tr>
      <td height="30" colspan="3" align="center" bgcolor="#ffffff"><input type="submit" name="Submit" value="确认添加" class="input">
        
        &nbsp;
        <input type="button" name="Submit2" value="返回上一页" class="input" onClick="history.go(-1);">
        <input name="Act" type="hidden" id="Act" value="Add">        <input name="UploadFiles" type="hidden" id="UploadFiles" />
        <span class="tr_southidc">
        <input name="IncludePic" type="hidden" id="IncludePic" value="0" />
        </span></td>
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