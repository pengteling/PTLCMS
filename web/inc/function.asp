<%
'函数名：GetRndPassword
'作  用：获取系统随机密码
'返回值：GetRndPassword -----值
'================================================
Function GetRndPassword(PasswordLen)
	Dim Ran,i,strPassword
	strPassword=""
	For i=1 To PasswordLen
		Randomize
		Ran = CInt(Rnd * 2)
		Randomize
		If Ran = 0 Then
			Ran = CInt(Rnd * 25) + 97
			strPassword =strPassword & UCase(Chr(Ran))
		ElseIf Ran = 1 Then
			Ran = CInt(Rnd * 9)
			strPassword = strPassword & Ran
		ElseIf Ran = 2 Then
			Ran = CInt(Rnd * 25) + 97
			strPassword =strPassword & Chr(Ran)
		End If
	Next
	GetRndPassword=strPassword
End Function

'****************************************************
'过程名：WriteErrMsg
'作  用：显示错误提示信息
'参  数：无
'****************************************************
sub WriteErrMsg()
	dim strErr
	strErr=strErr & "<html><head><title>错误信息</title><meta http-equiv='Content-Type' content='text/html; charset=utf-8'>" & vbcrlf
	strErr=strErr & "<link href='style.css' rel='stylesheet' type='text/css'></head><body>" & vbcrlf
	strErr=strErr & "<table cellpadding=2 cellspacing=2 border=0 width=400 class='border' align=center>" & vbcrlf
	strErr=strErr & "  <tr align='center'><td height='20' class='title'><strong>错误信息</strong></td></tr>" & vbcrlf
	strErr=strErr & "  <tr><td height='100' class='tdbg' valign='top'><b>产生错误的可能原因：</b><br>" & errmsg &"</td></tr>" & vbcrlf
	strErr=strErr & "  <tr align='center'><td class='title'><a href='javascript:history.go(-1)'>【返回】</a></td></tr>" & vbcrlf
	strErr=strErr & "</table>" & vbcrlf
	strErr=strErr & "</body></html>" & vbcrlf
	response.write strErr
end sub

'****************************************************
'过程名：WriteSuccessMsg
'作  用：显示成功提示信息
'参  数：无
'****************************************************
sub WriteSuccessMsg(SuccessMsg)
	dim strSuccess
	strSuccess=strSuccess & "<html><head><title>成功信息</title><meta http-equiv='Content-Type' content='text/html; charset=utf-8'>" & vbcrlf
	strSuccess=strSuccess & "<link href='style.css' rel='stylesheet' type='text/css'></head><body>" & vbcrlf
	strSuccess=strSuccess & "<table cellpadding=2 cellspacing=2 border=0 width=400 class='border' align=center>" & vbcrlf
	strSuccess=strSuccess & "  <tr align='center'><td height='20' class='title'><strong>恭喜你！</strong></td></tr>" & vbcrlf
	strSuccess=strSuccess & "  <tr><td height='100' class='tdbg' valign='top'><br>" & SuccessMsg &"</td></tr>" & vbcrlf
	strSuccess=strSuccess & "  <tr align='center'><td class='title'><a href='javascript:history.go(-1)'>【返回】</a></td></tr>" & vbcrlf
	strSuccess=strSuccess & "</table>" & vbcrlf
	strSuccess=strSuccess & "</body></html>" & vbcrlf
	response.write strSuccess
end sub

Function htmlspecialchars(str)
	str = Replace(str, "&", "&amp;")
	str = Replace(str, "<", "&lt;")
	str = Replace(str, ">", "&gt;")
	str = Replace(str, """", "&quot;")
	htmlspecialchars = str
End Function

Function alltrim(str)
	str = Replace(str, " ", "")
	str= replace(str,chr(9),"")
	str= replace(str,chr(13),"")	

	alltrim = str
End Function


Function strToNum(str)
         '将字符串转换为数字
         dim retStr
		 str = sqlbad(str) 
		 if len(str)>0 and isnumeric(str) then
		    retStr = clng(str)
		 else
		    retStr = 0
		 end if
		 strToNum = retStr
End Function

Function CheckNum(ByVal CheckStr)
	CheckStr = sqlbad(Trim(CheckStr))
	If CheckNum = "" Or Not IsNumeric(CheckStr) Or Len(CheckStr) > 10 Then
		CheckNum = 0
		Exit Function
	Else
		If CLng(Left(CheckStr,9)) > 214748367 Then
			CheckNum = 0
			Exit Function
		ElseIf CLng(Left(CheckStr,9)) = 214748367 And CLng(Right(CheckStr,1)) > 7 Then
			CheckNum = 0
			Exit Function
		Else
			If CheckStr < 0 Then CheckStr = 0
			CheckNum = CLng(CheckStr)
		End If
	End If
End Function

'判断是否为空
Function CheckNull(str)
	str=trim(str)
	If len(str)=0 or isempty(str) or isnull(str) Then
		CheckNull=""
	Else
		CheckNull=str
	End If
End Function

Function Sqlbad(str)
	 '删除信息中错误的字符
	 if len(str)=0 or isempty(str) or isnull(str) then
		sqlbad = ""
	 else
		sqlbad = replace(replace(replace(replace(trim(""&str&""),"'",""),"""","&quot;"),"<","&lt;"),">","&gt;")
	 end if
End Function


'=============================================================
'函数名：ChkFormStr
'作  用：过滤表单字符
'参  数：str   ----原字符串
'返回值：过滤后的字符串
'=============================================================
Public Function ChkFormStr(ByVal str)
	Dim fString
	fString = str
	If IsNull(fString) Then
		ChkFormStr = ""
		Exit Function
	End If
	fString = Replace(fString, "'", "&#39;")
	fString = Replace(fString, Chr(34), "&quot;")
	fString = Replace(fString, Chr(13), "")
	fString = Replace(fString, Chr(10), "")
	fString = Replace(fString, Chr(9), "")
	fString = Replace(fString, ">", "&gt;")
	fString = Replace(fString, "<", "&lt;")
	fString = Replace(fString, "%", "％")
	ChkFormStr = Trim(JAPEncode(fString))
End Function


'================================================
	'函数名：JAPEncode
	'作  用：日文片假名编码
	'参  数：str ----原字符
	'================================================
	Public Function JAPEncode(ByVal str)
		Dim FobWords, i
		'on error resume next
		If IsNull(str) Or Trim(str) = "" Then
			JAPEncode = ""
			Exit Function
		End If
		FobWords = Array(92, 304, 305, 430, 431, 437, 438, 12460, 12461, 12462, 12463, 12464, 12465, 12466, 12467, 12468, 12469, 12470, 12471, 12472, 12473, 12474, 12475, 12476, 12477, 12478, 12479, 12480, 12481, 12482, 12483, 12485, 12486, 12487, 12488, 12489, 12490, 12496, 12497, 12498, 12499, 12500, 12501, 12502, 12503, 12504, 12505, 12506, 12507, 12508, 12509, 12510, 12521, 12532, 12533, 65340)
		For i = 1 To UBound(FobWords, 1)
			If InStr(str, ChrW(FobWords(i))) > 0 Then
				str = Replace(str, ChrW(FobWords(i)), "&#" & FobWords(i) & ";")
			End If
		Next
		JAPEncode = str
	End Function
	'================================================
	'函数名：JAPUncode
	'作  用：日文片假名解码
	'参  数：str ----原字符
	'================================================
	Public Function JAPUncode(ByVal str)
		Dim FobWords, i
		'on error resume next
		If IsNull(str) Or Trim(str) = "" Then
			JAPUncode = ""
			Exit Function
		End If
		FobWords = Array(92, 304, 305, 430, 431, 437, 438, 12460, 12461, 12462, 12463, 12464, 12465, 12466, 12467, 12468, 12469, 12470, 12471, 12472, 12473, 12474, 12475, 12476, 12477, 12478, 12479, 12480, 12481, 12482, 12483, 12485, 12486, 12487, 12488, 12489, 12490, 12496, 12497, 12498, 12499, 12500, 12501, 12502, 12503, 12504, 12505, 12506, 12507, 12508, 12509, 12510, 12521, 12532, 12533, 65340)
		For i = 1 To UBound(FobWords, 1)
			If InStr(str, "&#" & FobWords(i) & ";") > 0 Then
				str = Replace(str, "&#" & FobWords(i) & ";", ChrW(FobWords(i)))
			End If
		Next
		str = Replace(str, Chr(0), "")
		str = Replace(str, "'", "''")
		JAPUncode = str
	End Function



	function wrongMsg(str)
	response.write str &"<a href=""javascript:history.back();"">返回</a>"
	response.End()
end function

Function GetLocationURL() 
Dim Url 
Dim ServerPort,ServerName,ScriptName,QueryString 
ServerName = Request.ServerVariables("SERVER_NAME") 
ServerPort = Request.ServerVariables("SERVER_PORT") 
ScriptName = Request.ServerVariables("SCRIPT_NAME") 
'QueryString = Request.ServerVariables("QUERY_STRING") 
Url="http://"&ServerName 
If ServerPort <> "80" Then Url = Url & ":" & ServerPort 
Url=Url&ScriptName 
If QueryString <>"" Then Url=Url&"?"& QueryString 
GetLocationURL=Url 
End Function 

Function LeftStr(StrValue,NumValue)
 Dim nStr,a,i
 for i=1 to Len(StrValue)
  a=Mid(StrValue,i,1)
  if Asc(a)<0 then
   nStr=nStr+2
  else
   nStr=nStr+1
  end if
  LeftStr=LeftStr&a

  if nStr>=CInt(NumValue) then
  if LeftStr<>StrValue then LeftStr=LeftStr&"…"
   Exit Function
   end if
 next
   
End Function


'=============================================================
'过滤SQL非法字符部分
'说明: 将字符串中的一些字符去掉后,输出剩余字符串
'作用: 作为写入数据的规范
'示例: XXX = CheckSQL(Str)
'=============================================================
Public Function CheckSQL(CheckStr)
	CheckStr = Trim(CheckStr)
	If IsNull(CheckStr) Or CheckStr = "" Then CheckSQL = "" : Exit Function
	CheckStr = Replace(CheckStr, "%",		vbNullString)
	CheckStr = Replace(CheckStr, "@",		vbNullString)
	CheckStr = Replace(CheckStr, "!",		vbNullString)
	CheckStr = Replace(CheckStr, "^",		vbNullString)
	CheckStr = Replace(CheckStr, "=",		vbNullString)
	CheckStr = Replace(CheckStr, "--",		vbNullString)
	CheckStr = Replace(CheckStr, "$",		vbNullString)
	CheckStr = Replace(CheckStr, "'",		vbNullString)
	CheckStr = Replace(CheckStr, ";",		vbNullString)
	CheckStr = Replace(CheckStr, Chr(0),	vbNullString)
	CheckStr = Replace(CheckStr, Chr(34),	vbNullString)
	CheckSQL = CheckStr
End Function

'********************************************
'函数名：IsValidEmail
'作  用：检查Email地址合法性
'参  数：email ----要检查的Email地址
'返回值：True  ----Email地址合法
'       False ----Email地址不合法
'********************************************

Function IsValidEmail(email)
	dim names, name, i, c
	IsValidEmail = true
	names = Split(email, "@")
	if UBound(names) <> 1 then
	   IsValidEmail = false
	   exit function
	end if
	for each name in names
		if Len(name) <= 0 then
			IsValidEmail = false
    		exit function
		end if
		for i = 1 to Len(name)
		    c = Lcase(Mid(name, i, 1))
			if InStr("abcdefghijklmnopqrstuvwxyz_-.", c) <= 0 and not IsNumeric(c) then
		       IsValidEmail = false
		       exit function
		     end if
	   next
	   if Left(name, 1) = "." or Right(name, 1) = "." then
    	  IsValidEmail = false
	      exit function
	   end if
	next
	if InStr(names(1), ".") <= 0 then
		IsValidEmail = false
	   exit function
	end if
	i = Len(names(1)) - InStrRev(names(1), ".")
	if i <> 2 and i <> 3 then
	   IsValidEmail = false
	   exit function
	end if
	if InStr(email, "..") > 0 then
	   IsValidEmail = false
	end if
End Function

'***************************************************
'函数名：IsObjInstalled
'作  用：检查组件是否已经安装
'参  数：strClassString ----组件名
'返回值：True  ----已经安装
'       False ----没有安装
'***************************************************
Function IsObjInstalled(strClassString)
	on error resume next
	IsObjInstalled = False
	Err = 0
	Dim xTestObj
	Set xTestObj = Server.CreateObject(strClassString)
	If 0 = Err Then IsObjInstalled = True
	Set xTestObj = Nothing
	Err = 0
End Function

'****************************************************
'函数名：SendMail
'作  用：用Jmail组件发送邮件
'参  数：ServerAddress  ----服务器地址
'        AddRecipient  ----收信人地址
'        Subject       ----主题
'        Body          ----信件内容
'        Sender        ----发信人地址
'****************************************************
Function SendMail(MailServerAddress,AddRecipient,Subject,Body,Sender,MailFrom)
	'on error resume next
	Dim JMail
	Set JMail=Server.CreateObject("JMail.SMTPMail")
	if err then
		SendMail= "<br><li>没有安装JMail组件</li>"
		err.clear
		exit function
	end if
	JMail.Logging=True
	JMail.Charset="utf-8"
	JMail.ContentType = "text/html"
	JMail.ServerAddress=MailServerAddress
	JMail.AddRecipient=AddRecipient
	JMail.Subject=Subject
	JMail.Body=MailBody
	JMail.Sender=Sender
	JMail.From = MailFrom
	JMail.Priority=1
	JMail.Execute 
	Set JMail=nothing 
	if err then 
		SendMail=err.description
		err.clear
	else
		SendMail="OK"
	end if
End Function


'// 图片处理函数
function MakeThumb(fileName,saveName,limitW,limitH,nType)
if not(limitW>0 or limitH>0) then exit function
Dim ojpg,oh,ow
Set ojpg = Server.CreateObject("Persits.Jpeg")
ojpg.open fileName
oh = ojpg.OriginalHeight
ow = ojpg.OriginalWidth
select case nType
case 0
    Rem 限定宽高
    if limitW>0 and limitH>0 then
      ojpg.width=limitW
      ojpg.height=limitH
    end if
'case 1
'    Rem 只限定宽度，高度按比例
'    if limitW>0 then
'      ojpg.width=limitW
'      ojpg.height=oh/ow*limitW
'    end if
case 1
    Rem 只限定宽度，高度按比例
    if limitW>0 and limitW<ojpg.width  then '如果比限定尺寸小 则不压缩宽度了
      ojpg.width=limitW
      ojpg.height=oh/ow*limitW
	else
		exit function
    end if
case 2
    Rem 只限定高度，宽度按比例
    if limitH>0 then
      ojpg.height=limitH
      ojpg.width=ow/oh*limitH
    end if
case 3
    Rem 按限定的宽高比裁切
    if limitW>0 and limitH>0 then
      Dim lheight:lheight=oh*limitW/ow
      If lheight<limitH Then
        ojpg.Height = limitH
        ojpg.Width = ow*ojpg.Height/oh
      Else
        ojpg.width = limitW
        ojpg.Height = oh*ojpg.width/ow
      End if
      ojpg.Crop 0, 0,limitW,limitH
    End If
case 4
		ojpg.Quality = 100
		'If  ojpg.OriginalHeight/limitH *ojpg.OriginalWidth > limitW Then
				 ojpg.PreserveAspectRatio = True '等比缩放
				 if ojpg.OriginalWidth/ojpg.OriginalHeight > limitW/limitH then '太扁了，要剪掉左右部分
				  ojpg.Height = limitH
				  ojpg.crop CInt((ojpg.Width - limitW)/2),0,CInt((ojpg.Width-limitW)/2)+limitW,limitH
				 else '太高了，要剪掉上下部分
				  ojpg.Width = limitW
				  ojpg.crop 0,CInt((ojpg.Height-limitH)/2),limitW,CInt((ojpg.Height-limitH)/2)+limitH
				 end if
		'end if
case else
    exit function
end select
ojpg.Interpolation =2
ojpg.Quality = 100
' 设定锐化效果
ojpg.Sharpen 1, 120
ojpg.save saveName
Set ojpg = nothing
end Function


function companyURL(cateid,catetype,outlinkurl,modeltype,catedir,isStatic)
	if catetype=3 then '外部链接
		companyURL =outlinkurl	
	else
	
		if isStatic="0" then
			select case modeltype
				case 0  '文字信息模型
					if catetype=1 then					
						companyURL="news.asp?id="&cateid					
					else 'catetype=0 or 2 单页或栏目首页
						companyURL="company.asp?id="&cateid
					end if			
				case 1 '图片信息模型
					'companyURL = "pic.asp?id="&cateid				
					companyURL = "pic.asp?id="&cateid	
				case 2 '图文信息模型
					companyURL="picnews.asp?id="&cateid		
				case 3 '作家列表模型'	
					companyURL="writers.asp?id="&cateid
			end select
		else '静态			
			'companyURL =HtmlRoot&catedir&"-cat"&cateid&".html"					
			companyURL =HtmlRoot&catedir&"/index.html"					
		end if
		
	end if

end function


function companyUrl_db(cateid)
	set rs_cate=server.CreateObject("adodb.recordset")
	rs_cate.open "Select * from category where cateid="&cateid,conn,1,1
	if not rs_cate.eof then
		companyUrl_db =companyURL(cateid,rs_cate("catetype"),rs_cate("outlinkurl"),rs_cate("modeltype"),rs_cate("dirpath"),supporthtml)
	end if
	rs_cate.close


end Function

function dirpath(cateid)

	set rs_dirpath= server.CreateObject("adodb.recordset")
	set rs_dirpath2 = server.CreateObject("adodb.recordset")
	'response.write "select parentid,dirpath from category where cateid="&cateid
	rs_dirpath.open "select parentid,dirpath from category where cateid="&cateid,conn,1,3
	if not rs_dirpath.eof then
		
		parentid_temp = rs_dirpath("parentid")
		tempdir =""
		
		'response.write "Select catedir from category where cateid in ("&parentid_temp&") order by depth"
		'response.end 
		rs_dirpath2.open "Select catedir from category where cateid in ("&parentid_temp&") order by depth",conn,1,1
		while not rs_dirpath2.eof

			tempdir=tempdir&""&rs_dirpath2(0)&"/"
			
		rs_dirpath2.movenext
		wend
		rs_dirpath2.close
		
		rs_dirpath("dirpath")=tempdir
		rs_dirpath.update
		
	rs_dirpath.movenext
	end if
	rs_dirpath.close
	
	set rs_dirpath= nothing
	set rs_dirpath2=  nothing

end function
%>