<%

dim geturl,objStream,imgs 

imgs=Request.BinaryRead(Request.TotalBytes)  
Set objStream = Server.CreateObject("ADODB.Stream") 
objStream.Type =1 
objStream.Open 
objstream.write imgs 
objstream.SaveToFile server.MapPath("1.gif"),2 
objstream.Close() 
set objstream=nothing 







%>
