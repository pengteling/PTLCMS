﻿<%@ CODEPAGE=65001 %>

<!--#include file="../../inc/function.asp"-->

<% Response.CodePage=65001 %>
<% Response.Charset="UTF-8" %>
<!--#include file="UpLoad_Class.asp"-->
<!--#include file="JSON_2.0.4.asp"-->
<%
'Easp.Db.SetConnection "default", "MSSQL", "yugao", "jdb_f:jadeboxadm@JADEBOXSERVER\SQLEXPRESS"
'connstr="Provider=SQLOLEDB.1;Server=(local);User ID=yugao_f;Password=jadeboxadm;Database=yugao;"
connstr="Provider=SQLOLEDB.1;Server=10.209.0.141;User ID=xannad_f;Password=xannadadm;Database=xannad;"
Set conn = Server.CreateObject("ADODB.Connection")
	conn.open ConnStr
' KindEditor ASP
'
' 本ASP程序是演示程序，建议不要直接在实际项目中使用。
' 如果您确定直接使用本程序，使用之前请仔细确认相关安全设置。
'

Dim aspUrl, savePath, saveUrl, maxSize, fileName, fileExt, newFileName, filePath, fileUrl, dirName
Dim extStr, imageExtStr, flashExtStr, mediaExtStr, fileExtStr
Dim upload, file, fso, ranNum, hash, ymd, mm, dd, result

aspUrl = Request.ServerVariables("SCRIPT_NAME")
aspUrl = left(aspUrl, InStrRev(aspUrl, "/"))

'文件保存目录路径
savePath = "/uploadfiles/"
'文件保存目录URL
'saveUrl = aspUrl & "../attached/"
saveUrl ="/uploadfiles/"
'定义允许上传的文件扩展名
imageExtStr = "gif|jpg|jpeg|png|bmp"
flashExtStr = "swf|flv|f4v|mp4"
mediaExtStr = "swf|flv|mp3|wav|wma|wmv|mid|avi|mpg|asf|rm|rmvb|mp4"
fileExtStr = "doc|docx|xls|xlsx|ppt|htm|html|txt|zip|rar|gz|bz2|pdf"
'最大文件大小
maxSize = 50 * 1024 * 1024 '5M

Set fso = Server.CreateObject("Scripting.FileSystemObject")
If Not fso.FolderExists(Server.mappath(savePath)) Then
	showError("上传目录不存在。")
End If

dirName = Request.QueryString("dir")
If isEmpty(dirName) Then
	dirName = "image"
End If
If instr(lcase("image,flash,media,file,flvplayer"), dirName) < 1 Then
	showError("目录名不正确。"&dirName)
End If

Select Case dirName
	Case "flash" extStr = flashExtStr
	Case "media" extStr = mediaExtStr
	Case "file" extStr = fileExtStr
	Case "flvplayer" extStr = flashExtStr
	Case Else  extStr = imageExtStr
End Select

set upload = new AnUpLoad
upload.Exe = extStr
upload.MaxSize = maxSize
upload.GetData()
if upload.ErrorID>0 then 
	showError(upload.Description)
end if

'创建文件夹
savePath = savePath & dirName & "/"
saveUrl = saveUrl & dirName & "/"
If Not fso.FolderExists(Server.mappath(savePath)) Then
	fso.CreateFolder(Server.mappath(savePath))
End If
mm = month(now)
If mm < 10 Then
	mm = "0" & mm
End If
dd = day(now)
If dd < 10 Then
	dd = "0" & dd
End If
ymd = year(now) & mm & dd
savePath = savePath & ymd & "/"
saveUrl = saveUrl & ymd & "/"
If Not fso.FolderExists(Server.mappath(savePath)) Then
	fso.CreateFolder(Server.mappath(savePath))
End If

set file = upload.files("imgFile")
if file is nothing then
	showError("请选择文件。")
end if

set result = file.saveToFile(savePath, 0, true)
if result.error then
	showError(file.Exception)
end if

filePath = Server.mappath(savePath & file.filename)
fileUrl = saveUrl & file.filename


rfilePath=savePath & file.filename
'Easp.var("filetype2")=file.filename

filetype = file.extend

Set upload = nothing
Set file = nothing

if dirName="image" then
'存缩略图
'MakeThumb filePath ,filePath,800,0,1
end if

'set result=Easp.Db.Ins("uploadfiles","path:'32434'")
set rs=server.CreateObject("adodb.recordset")
rs.open "select * from uploadfiles where 1=2",conn,1,3

rs.addnew

rs("path")=rfilePath
rs("filetype")=filetype
rs.update
rs.close


If Not fso.FileExists(filePath) Then
	showError("上传文件失败。")
End If

Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
Set hash = jsObject()
hash("error") = 0
hash("url") = fileUrl
hash.Flush
Response.End

Function showError(message)
	Response.AddHeader "Content-Type", "text/html; charset=UTF-8"
	Dim hash
	Set hash = jsObject()
	hash("error") = 1
	hash("message") = message
	hash.Flush
	Response.End
End Function
%>
