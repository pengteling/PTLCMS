<!--#include virtual="/admin/inc/head.asp"-->
<body>

    <div id="wrapper">
    <!--#include virtual="/admin/inc/top.asp"-->

<!-- Page Content -->
        <div id="page-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">添加广告</h1>
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
'获得大类
dim first,classid
dim i
dim act,catalogid,title,adType,photo,imgW,imgH,linkUrl,content
act=request.QueryString("act")
if(act="add") then
	catalogid=cint(request.Form("catalogid"))	
	title=trim(request.Form("title"))
	if(isnull(title) or len(title)<1) then
		response.Write("<script>alert('广告标题不能为空！');history.back();</script>")
		response.End()
	end if
	adType=Cint(request.Form("adType"))
	if(isnull(adType) or not isnumeric(adType)) then
		response.Write("<script>alert('广告类型不能为空！');history.back();</script>")
		response.End()
	end if
	if(adType=0) then		
		content=trim(Request.Form("content"))
		if(isnull(content) or len(content)<1) then
			response.Write("<script>alert('广告内容不能为空！');history.back();</script>")
			response.End()
		end If
		if not isempty(request.Form("imgW")) then 
			imgW=request.Form("imgW")
		end if
		if not isempty(request.Form("imgH")) then 
			imgH=request.Form("imgH")
		end if	
	elseif(adType=1) then
		photo=trim(Request.Form("photo"))
		if not isempty(request.Form("imgW")) then 
			imgW=request.Form("imgW")
		end if
		if not isempty(request.Form("imgH")) then 
			imgH=request.Form("imgH")
		end if	
		linkUrl=trim(Request.Form("linkUrl"))
		if(isnull(photo) or len(photo)<1) then
			response.Write("<script>alert('图片地址不能为空！');history.back();</script>")
			response.End()
		end if
		if(isnull(imgW) or len(imgW)<1) then
			response.Write("<script>alert('图片宽度不能为空！');history.back();</script>")
			response.End()
		end if
		if(isnull(imgH) or len(imgH)<1) then
			response.Write("<script>alert('图片高度不能为空！');history.back();</script>")
			response.End()
		end if
		
	elseif(adType=2) then
	linkUrl=trim(Request.Form("linkUrl"))
		photo=trim(Request.Form("photo"))
		if not isempty(request.Form("imgW")) then 
			imgW=request.Form("imgW")
		end if
		if not isempty(request.Form("imgH")) then 
			imgH=request.Form("imgH")
		end if	
		if(isnull(photo) or len(photo)<1) then
			response.Write("<script>alert('flash地址不能为空！');history.back();</script>")
			response.End()
		end if
		if(isnull(imgW) or len(imgW)<1) then
			response.Write("<script>alert('flash宽度不能为空！');history.back();</script>")
			response.End()
		end if
		if(isnull(imgH) or len(imgH)<1) then
			response.Write("<script>alert('flash高度不能为空！');history.back();</script>")
			response.End()
		end if
	end if
	

	orderid = request.form("orderid")
	if not isnumeric(orderid) then
		response.Write("<script>alert('序号必须是阿拉伯数字');history.back();</script>")
		response.End()
	else
		orderid = cint(orderid)
	end if

	
	'''''''''''''''''''''''''''''''''添加到库''''''''''''''''''''''''''''
	set rs=server.createobject("adodb.recordset")
	sql="select top 1 * from ad where 1=0 order by id desc "
	rs.open sql,conn,3,3
	rs.addnew
	rs("catalogId")=catalogid
	rs("title")=title
	rs("content")=content
	rs("adType")=adType
	rs("photo")=photo
	rs("linkUrl")=linkUrl
	rs("imgW")=imgW
	rs("imgH")=imgH
	rs("moditime")=now
	rs("orderid")=orderid
	rs.update
	rs.close
	set rs=nothing
	''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
	response.Write("成功添加广告~!")
	response.Write("<br><a href=""ad_add.asp"">继续添加-></a>")
else
%>
<FORM method="POST" name="form1" action="ad_add.asp?act=add" style="margin:0 0 0 0;">
  <TABLE width="100%" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="#A4B6D7" class="table_southidc">
<TR>
  <TD height="22" colspan="2" align="center"><span style="font-weight: bold">添加广告</span></TD>
  </TR>
<TR bgcolor="#F5F5F5">
  <TD width="18%" align="right" bgcolor="#ECF5FF">所 属 类 别：</TD>
  <TD width="82%" align="left" bgcolor="#ECF5FF"><select name="catalogid" >
  <option value="0">所有</option>
<%
set rs=server.CreateObject("adodb.recordset")
sql="select id,title from catalogs order by id asc"
rs.open sql,conn,3,1
if not rs.eof then
	do while not rs.eof
		if clng(request("sortid"))=rs("id") then
		response.Write("<option value="""&rs("id")&""" selected>"&rs("title")&"</option>")
		else
		response.Write("<option value="""&rs("id")&""">"&rs("title")&"</option>")
		end if
	rs.movenext
	loop
else
	response.Write("暂时没有分类,请先添加分类!")
	response.End()
end if
rs.close
set rs=nothing
%>
    </select></TD>
</TR>
<TR bgcolor="#F5F5F5">
  <TD align="right" bgcolor="#ECF5FF">标题名称：</TD>
  <TD align="left" bgcolor="#ECF5FF"><input name="title" type="text" id="title" size="60">
    <span class="red">*</span></TD>
</TR>
<TR bgcolor="#F5F5F5">
  <TD align="right" bgcolor="#ECF5FF">广告类型：</TD>
  <TD align="left" bgcolor="#ECF5FF"><input name="adType" type="radio" onClick="chanText()" value="0" checked>
    富媒体
      <input name="adType" type="radio" value="1" onClick="chanImg()">
图片
<input name="adType" type="radio" value="2" onClick="chanFlash()"> 
Flash</TD>
</TR>
<TR bgcolor="#F5F5F5" id="objUrl">
  <TD align="right" bgcolor="#ECF5FF">图片|Flash地址：</TD>
  <TD align="left" bgcolor="#ECF5FF">
    <input name="photo" type="text" id="photo" size="50">
    <span class="tr_southidc">
    <input name="Submit222" type="button" value="上传->"  onClick="window.open('../../inc/mx_upload_flash.asp?formname=form1&editname=photo&uppath=UploadFiles/Ad&filelx=jpgswf','','status=no,scrollbars=no,top=300,left=200,width=420,height=136')">
    <span class="red">*</span></span></TR>
<TR bgcolor="#F5F5F5" id="objWidth">
  <TD align="right" bgcolor="#ECF5FF">宽度：</TD>
  <TD align="left" bgcolor="#ECF5FF">
    <input name="imgW" type="text" id="imgW" size="10" value="">
    <span class="red">*</span>  </TR>
<TR bgcolor="#F5F5F5" id="objHeight">
  <TD align="right" bgcolor="#ECF5FF">高度：</TD>
  <TD align="left" bgcolor="#ECF5FF">
    <input name="imgH" type="text" id="imgH" size="10" value="">
    <span class="red">*</span>  </TR>
<TR bgcolor="#F5F5F5" id="objLink">
  <TD align="right" bgcolor="#ECF5FF">链接：</TD>
  <TD align="left" bgcolor="#ECF5FF">
    <input name="linkUrl" type="text" id="linkUrl" size="60">
  </TR>
  <TR bgcolor="#F5F5F5" id="objOrderid">
  <TD align="right" bgcolor="#ECF5FF">序号：</TD>
  <TD align="left" bgcolor="#ECF5FF">
    <input name="orderid" type="text" id="orderid" size="10" value="0"> * 阿拉伯数字，数字越大排序越靠前 </TR>
<TR bgcolor="#F5F5F5" style="display:none; " id="textContent">
	<TD align="right" bgcolor="#ECF5FF">广告内容：</TD>
	<TD align="left" bgcolor="#ECF5FF">		
    <link rel="stylesheet" href="/kindeditor/themes/default/default.css" />
	 <link rel="stylesheet" href="/kindeditor/plugins/code/prettify.css" />
	<script charset="utf-8" src="/kindeditor/kindeditor.js"></script>
	<script charset="utf-8" src="/kindeditor/lang/zh_CN.js"></script>
	<script charset="utf-8" src="/kindeditor/plugins/code/prettify.js"></script>
	<script>
		var editor1;
		KindEditor.ready(function(K) {
			editor1 = K.create('textarea', {
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
		</script>
	<textarea rows="12" name="content" cols="70" style="width:100%;height:400px;visibility:hidden;"></textarea>
	<span class="red">*</span></TR>
<TR bgcolor="#F5F5F5">
	<TD align=right bgcolor="#ECF5FF">&nbsp;	  </TD>
    <TD align=left bgcolor="#ECF5FF">
        <input type=submit name=b1 value="提 交">&nbsp;&nbsp;
        <input type=reset name=b2 value="重 填">       
    </TD>
</TR>
</TABLE>
</FORM>
<%
end if
%>
<script>
function chanText()
{
	document.getElementById("objUrl").style.display='none';
	//document.getElementById("objWidth").style.display='none';
	//document.getElementById("objHeight").style.display='none';
	document.getElementById("objLink").style.display='none';
	document.getElementById("textContent").style.display='';
}
function chanImg()
{
	document.getElementById("objUrl").style.display='';
	document.getElementById("objWidth").style.display='';
	document.getElementById("objHeight").style.display='';
	document.getElementById("objLink").style.display='';
	document.getElementById("textContent").style.display='none';
}
function chanFlash()
{
	document.getElementById("objUrl").style.display='';
	document.getElementById("objWidth").style.display='';
	document.getElementById("objHeight").style.display='';
	document.getElementById("objLink").style.display='';
	document.getElementById("textContent").style.display='none';
}
chanText();
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




</body>
</html>