<!--#include file="../../inc/conn.asp"-->
<!--#include file="../admin.asp"-->
<!-- #include file="../Inc/Head.asp" -->

<script>
function CheckForm(){
	if (document.myform.DefaultPicUrl.value=="")
	{
		alert("请先上传excel文件！");
		document.myform.DefaultPicUrl.focus();
		return false;
	}
}
</script>


<form id="myform" name="myform" method="post" action="import.asp" onSubmit="return CheckForm();">
 <table width="100%" border="0" align="center" cellpadding="3" cellspacing="1" class="table_southidc">
    <tr>
      <td colspan="2" align="center"><a href="companyall.asp"><span class="blod">上传会员资料</span></a></td>
    </tr>
<tr>
<td align="right" class="tr_southidc">下载模板文件： </td>
      <td class="tr_southidc"><a href="user.xls" target="_blank">点击下载</a>  请按excel模板文件 准备数据（建议将数据准备好再复制到下载的模板文件中）</td>
</tr>
<tr>
     <td align="right" class="tr_southidc">导入文件路径： </td>
      <td class="tr_southidc">
     <input name="DefaultPicUrl" type="text" id="DefaultPicUrl" value="<%=DefaultPicUrl%>" size="30" maxlength="120" />
    <input name="Submit222" type="button" value="上传Excel文件"  onClick="window.open('../../inc/mx_upload_flash.asp?formname=myform&editname=DefaultPicUrl&uppath=company&filelx=file','','status=no,scrollbars=no,top=300,left=200,width=420,height=136')">
    </td>
    </tr>
    <tr>
      <td align="center" class="tr_southidc">&nbsp;</td>
      <td align="left" class="tr_southidc">&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="submit" name="Submit" value="开始导入" />
        &nbsp;
        </td>
    </tr>
    </table>