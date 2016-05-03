<%@ CODEPAGE=65001 %>
<% Response.CodePage=65001 %>
<% Response.Charset="UTF-8" %>
<!--#include virtual="/inc/MD5-2.asp"-->

<%
'Response.write md5("erere")

'固定参数
app_key="23304958"    '假设
app_secret="c579429de37db3983d8b5b9e23c907a6"    '假设
format="json"
time_now =now()
dim params_arr_sign,params_arr_url

'response.write server.urlencode(now())
'response.write timestamp(now())
'te ="http://gw.api.taobao.com/router/rest?sign=36FA16DF40669106B2742F87274FA648&timestamp=2016-01-28+11%3A43%3A53&v=2.0&app_key=12129701&method=alibaba.aliqin.fc.sms.num.send&partner_id=top-apitools&format=json&sms_type=normal&extend=529&rec_num=13452080657&sms_free_sign_name=%E6%B4%BB%E5%8A%A8%E9%AA%8C%E8%AF%81&sms_template_code=SMS_5000241&sms_param=%7B%22code%22%3A%221234%22%2C%22product%22%3A%22ptl%22%7D"

'params_sms_free_sign_name 阿里大鱼中的短信签名
'extend 返回参数
'rec_num 手机号
'sms_template_code 阿里大鱼中的短信模板编号'
'sms_param 短信模板中需要传的变量 json

call sms("大鱼测试","529","15310289823","SMS_6811119","{""code"":""YHX123456"",""customer"":""大鱼测试""}")
function sms(sms_free_sign_name,extend,rec_num,sms_template_code,sms_param)
'sms_free_sign_name ="活动验证3"
'extend ="529"
'rec_num="13452080657"
'sms_template_code="SMS_5000241"
'sms_param="{""code"":""1234"",""product"":""ptl""}"


params_arr = createParamsArr(sms_free_sign_name,extend,rec_num,sms_template_code,sms_param)
params_arr_sign = Sortarray(params_arr) '签名用'
params_arr_url = FilterPara(params_arr_sign)  '传参用

response.write RequestUrl(createParamsUrl())

end function
'数组 按字母排序'
Function Sortarray(ary)
Dim KeepChecking,I,FirstValue,SecondValue
 KeepChecking=TRUE
Do Until KeepChecking=FALSE
 KeepChecking=FALSE
 For I=0 to UBound(ary)
 If I=UBound(ary) Then Exit For
  If ary(I)>ary(I+1) Then
   FirstValue=ary(I)
   SecondValue=ary(I+1)
   ary(I)=SecondValue
   ary(I+1)=FirstValue
   KeepChecking=TRUE
  End If
 Next
Loop
 Sortarray=ary
End Function



'Get方法请求url,获取请求内容
	Function RequestUrl(url)
		Set XmlObj = Server.CreateObject("Microsoft.XMLHTTP")
		XmlObj.open "GET",url, false
		XmlObj.send
		RequestUrl = XmlObj.responseText
		Set XmlObj = nothing
	End Function
	
	'Post方法请求url,获取请求内容
	Function RequestUrl_post(url,data)
		Set XmlObj = Server.CreateObject("Microsoft.XMLHTTP")
		XmlObj.open "POST", url, false
		'XmlObj.setrequestheader "POST","/t/add_t HTTP/1.1"
		'XmlObj.setrequestheader "Host"," graph.qq.com "
		XmlObj.setrequestheader "content-length ",len(data)   
        XmlObj.setrequestheader "content-type", "application/json"
		XmlObj.setrequestheader "Connection"," Keep-Alive"
        XmlObj.setrequestheader "Cache-Control"," no-cache"
        XmlObj.send(data)
		RequestUrl_post = XmlObj.responseText
		Set XmlObj = nothing
	End Function
	

'生成sign签名 md5 拼接参数 '
function createSign()

for i = 0 to ubound(params_arr_sign)
	'response.write params_arr(i) &"<br>"

	temp = params_arr_sign(i)
	temp =replace(temp,"=","") '去掉=号'
	if i=0 Then
	params_str = temp
	else
	params_str = params_str &temp
	end if
'response.write params_str &"<br>"
next
params_str = app_secret &params_str &app_secret
'response.write params_str &"<br>"
createSign = ucase(md5(params_str))
end function

'params_str = server.urlencode(params_str)
'response.write createSign()
'response.write ucase(md5(createSign()))

'根据短信所需参数 参数数组'
function createParamsArr(sms_free_sign_name,extend,rec_num,sms_template_code,sms_param)	
	'params_sign = "sign=" &sign
	params_timestamp = "timestamp=" & timestamp(time_now)
	params_app_key = "app_key=" &app_key
	params_method = "method=alibaba.aliqin.fc.sms.num.send"
	params_format ="format=json"
	params_v ="v=2.0"
	params_sign_method="sign_method=md5"
	params_sms_type = "sms_type=normal"
	params_sms_free_sign_name = "sms_free_sign_name="&sms_free_sign_name
	params_extend = "extend="&extend
	params_rec_num ="rec_num="&rec_num
	params_sms_template_code = "sms_template_code="&sms_template_code
	params_sms_param = "sms_param="&sms_param
	createParamsArr =array(params_timestamp,params_app_key,params_method,params_format,params_v,params_sign_method,params_sms_type,params_sms_free_sign_name,params_extend,params_rec_num,params_sms_template_code,params_sms_param)
end function



'通过参数数组 生成API URL'
function createParamsUrl()

params_url ="http://gw.api.taobao.com/router/rest?sign="& createSign()

for i = 0 to ubound(params_arr_url)
	'response.write params_arr(i) &"<br>"	
	
	params_url = params_url &"&"&params_arr_url(i)
	'response.write params_url &"<br>"	
next
	
createParamsUrl = params_url

end function

'response.write createParamsUrl()
'response.write ubound(params_arr_url)



'生成时间缀 '
function timestamp(temp_date)
	timestamp=year(temp_date)&"-"&right(100+month(temp_date),2)&"-"&right(100+day(temp_date),2) & " " &right(100+hour(temp_date),2)&":"&right(100+minute(temp_date),2)&":"&right(100+second(temp_date),2)    
end function

'生成urlencode的时间缀'
function timestamp2(temp_date)
	timestamp2=year(temp_date)&"-"&right(100+month(temp_date),2)&"-"&right(100+day(temp_date),2) & server.urlencode(" " &right(100+hour(temp_date),2)&":"&right(100+minute(temp_date),2)&":"&right(100+second(temp_date),2)    )
end function

''
' 除去数组中的空值和签名参数
' param sPara 签名参数组
' return 去掉空值与签名参数后的新签名参数组
Function FilterPara(sPara)
	Dim sParaFilter(),nCount,j
	nCount = ubound(sPara)
	j = 0
	For i = 0 To nCount
		'把sPara的数组里的元素格式：变量名=值，分割开来
		'response.write sPara(i)
		pos = Instr(sPara(i),"=")			'获得=字符的位置
		nLen = Len(sPara(i))				'获得字符串长度
		itemName = left(sPara(i),pos-1)	'获得变量名
		itemValue = right(sPara(i),nLen-pos)'获得变量的值
		
		If itemValue <> "" and isnull(itemValue) = false Then
			Redim Preserve sParaFilter(j)
			if itemName="sms_free_sign_name" or itemName="sms_param" or itemName ="timestamp" then
			sParaFilter(j) = itemName &"=" & server.urlencode(itemValue)
			'elseif itemName ="timestamp" then
			'sParaFilter(j) = itemName &"=" &timestamp2(time_now)
			else
			sParaFilter(j) =sPara(i)
			end if
			j = j + 1
		End If
	Next
	
	FilterPara = sParaFilter
End Function

%>