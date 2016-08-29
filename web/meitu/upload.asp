<%

If request.servervariables("HTTP_REFERER") ="" Then
	'判断来源
End if
Server.ScriptTimeout=3600
i=Request.TotalBytes
r=1024*300  '限制文件大小'
If i<r Then r=i
Set S=Server.CreateObject("Adodb.Stream")
S.Type=1
S.Mode=3
S.Open
While i>0
S.Write Request.BinaryRead(r)
i=i-r
Wend
S.Position=0
S.SaveToFile server.MapPath("test.jpg"),2
S.Close
%>