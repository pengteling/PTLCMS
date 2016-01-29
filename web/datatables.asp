<%
'response.write request.form
j=1
for each i in Request.Form    	
    	'response.write i &"-" &  Request.Form(i) &"<br>"    
    	redim preserve rdata(j)
    	redim preserve vdata(j)
    	rdata(j) = i 
    	vdata(j) = request.form(i)  
    	j=j+1  	
next

'response.write rdata(1) &"-" &vdata(1)
'response.write ubound(rdata)



if rdata(1) = "action" then

	if vdata(1) ="edit" then
	

	elseif vdata(1) ="create" then


	elseif vdata(1) ="remove" then

	end if

end if

%>