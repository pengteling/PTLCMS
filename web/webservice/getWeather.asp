<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>  
<%response.charset="utf-8"%> 

<%  

Dim strxml  

Dim str  



'定义soap消息  

strxml = "<?xml version='1.0' encoding='utf-8'?>"  

strxml = strxml & "<soap:Envelope xmlns:soap=""http://schemas.xmlsoap.org/soap/envelope/"" xmlns:xsi=""http://www.w3.org/2001/XMLSchema-instance"" xmlns:xsd=""http://www.w3.org/2001/XMLSchema"">"  

strxml = strxml & "<soap:Body> "  

strxml = strxml & "<getSupportCity xmlns=""http://WebXml.com.cn/"">"  

strxml = strxml & "<byProvinceName>四川</byProvinceName>"  

strxml = strxml & "</getSupportCity>"  

strxml = strxml & "</soap:Body>"  

strxml = strxml & "</soap:Envelope>"  


'<?xml version="1.0" encoding="utf-16"?>
'<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
'  <soap:Body>
'    <getSupportCity xmlns="http://WebXml.com.cn/">
'      <byProvinceName>重庆</byProvinceName>
'    </getSupportCity>
'  </soap:Body>
'</soap:Envelope>



'定义一个XML的文档对象，将手写的或者接受的XML内容转换成XML对象  

'set x = createobject("Microsoft.DOMDocument")  

'初始化XML对象  

'将手写的SOAP字符串转换为XML对象  

' x.loadXML strxml  

'初始化http对象  

Set h = createobject( "Microsoft.XMLHTTP")  

'向指定的URL发送Post消息  

h.open "POST", "http://www.webxml.com.cn/WebServices/WeatherWebService.asmx", False  

h.setRequestHeader "Content-Type", "text/xml;charset=utf-8"  

h.setRequestHeader "SOAPAction", "http://WebXml.com.cn/getSupportCity"  

h.send (strxml)  

While h.readyState <> 4  

Wend  

'显示返回的XML信息  

str = h.responseText  

'将返回的XML信息解析并且显示返回值  

Set xmlDOC = createobject("MSXML2.DOMDocument")  

'x.loadXML str  



'str = x.childNodes(1).Text  

xmlDOC.load(h.responseXML)


set nodeobj=xmlDOC.getelementsbytagname("getSupportCityResult").item(0).childNodes.item(0)'当前结点对像
set nodeAttributelen=xmlDOC.documentElement.childNodes.selectSingleNode("getSupportCityResult")'当前结点属性数


'response.write(str)  
response.write nodeobj.Text
'response.write nodeAttributelen.item(0).text



%>  
