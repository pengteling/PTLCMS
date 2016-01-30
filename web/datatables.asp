<%
'response.write request.form
'j=1
Set data=Server.CreateObject("Scripting.Dictionary")

for each i in Request.Form    	
    	'response.write i &"-" &  Request.Form(i) &"<br>"    
    	'redim preserve rdata(j)
    	'redim preserve vdata(j)
    	'rdata(j) = i 
    	'vdata(j) = request.form(i)  
    	'j=j+1  
        data.add i,	request.form(i)          
next

'response.write rdata(1) &"-" &vdata(1)
'response.write ubound(rdata)

'response.write data("action")

for each key in data
    start1  = instr(key,"][")+2
    start0 = instr(key,"[row_")+5

    if start1>3 then
        over1 =instr(start1,key,"]")
        newkey =mid(key,start1,over1-start1)
        rowid =mid(key,start0,start1-start0-2)

        data.Key(key)=newkey
        'response.write newkey
        'response.write rowid & newkey & data(newkey) &"<br>"
    end if
next

	if data("action") ="edit" then	

	elseif data("action") ="create" then

	elseif data("action")="remove" then

	end if


%>