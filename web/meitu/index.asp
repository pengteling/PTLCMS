<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>美图WEB开放平台</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<script src="http://open.web.meitu.com/sources/xiuxiu.js" type="text/javascript"></script>
<script type="text/javascript">
window.onload=function(){
	//xiuxiu.setLaunchVars("cropPresets", "60x60");
       /*第1个参数是加载编辑器div容器，第2个参数是编辑器类型，第3个参数是div容器宽，第4个参数是div容器高*/
	xiuxiu.embedSWF("altContent",5,"100%","100%");

       //修改为您自己的图片上传接口
	xiuxiu.setUploadURL("http://localhost:529/meitu/upload.asp");
        xiuxiu.setUploadType(2);
        xiuxiu.setUploadDataFieldName("upload_file");
	xiuxiu.onInit = function ()
	{
		xiuxiu.loadPhoto("http://open.web.meitu.com/sources/images/1.jpg");
	}	
	xiuxiu.onUploadResponse = function (data)
	{
		//alert("上传响应" + data);  可以开启调试
	}
	xiuxiu.onBeforeUpload = function (data, id)
	{
		data.width=1000;	
		data.height=1000;	
		alert(data.width);
	  var size = data.size;
	  if(size > 2 * 1024 * 1024)
	  { 
	    alert("图片不能超过2M"); 
	    return false; 
	  }
	  return true; 
	}
}
</script>
<style type="text/css">
	html, body { height:100%; overflow:hidden; }
	body { margin:0; }
</style>
</head>
<body>
<div id="altContent">
	<h1>美图秀秀</h1>
</div>
</body>
</html>