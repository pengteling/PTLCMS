<!--#include virtual="/admin/inc/head.asp"-->



<%
dim id,act
set rs=server.createobject("adodb.recordset")
ID=strToNum(request("ID"))
Act=ChkFormStr(Request("Act"))
If Act="del" Then
	'response.write "由于网站架构删除对网站数据影响很大，如需删除请联系作者"
	'response.end()
	Easp.Db.Begin '开始事务

	set rs=Easp.db.sel("Select * From category Where cateID="&ID&"")
	If Not rs.Eof Then
	dim followid,parentid,sonid,sonid_p,sonid_arr
		followid=rs("followid")	
		parentid=rs("parentid")	
		sonid=rs("sonid")
		sonid_arr=split(sonid,",")
	End If
	'rs.Delete
	'rs.Update
	rs.Close
	
	'response.write "delete from category where cateid in ("&sonid&")"
	Easp.Db.query ("delete from category where cateid in ("&sonid&")")
	Easp.Db.query  ("Delete from news where cateid in ("&sonid&")")
	
	set rs=Easp.Db.sel( "select cateid,sonid from category where cateid in ("&parentid&") and cateid<>"&ID&" order by depth,orderID")
	
	while not rs.eof 
		sonid_p = rs("sonid")
		sonid_p =","+sonid_p+","
		
		for i=0 to ubound(sonid_arr)
			sonid_p =replace(sonid_p,","+sonid_arr(i)+",",",") '删除后 其父栏目的 子栏目数据变化
		next
		
		sonid_p =right(sonid_p,len(sonid_p)-1)
		sonid_p =left(sonid_p,len(sonid_p)-1)
		
		rs("sonid") = sonid_p
		rs.update
	
	rs.movenext
	wend
	rs.close
	
	
	Easp.Db.Commit '提交事务

	Response.Redirect("companyAll.asp")
	Response.End()
End IF
If Act="IsHide" Then
	s=strToNum(request("s"))
	Easp.Db.query("Update category Set IsHome="&s&" Where cateID="&ID&"")
	Response.Redirect("companyAll.asp")
	Response.End()
End If
If Act="IsOut" Then
	Easp.Db.query("Update category Set IsOutLink=0 Where cateID="&ID&"")
	Response.Redirect("companyAll.asp")
	Response.End()
End If
If Act="IsPage" Then
	p=strToNum(request("p"))
	If p=0 Then p=ID
	Easp.Db.query("Update category Set IsIndex=0 Where cateID="&p&" Or followid="&p&"")
	Easp.Db.query("Update category Set IsIndex=1 Where cateID="&ID&"")
	set Rs=server.createobject("adodb.recordset")
	Response.Redirect("companyAll.asp")
	Response.End()
End If

%>
<body>

    <div id="wrapper">
		<!--#include virtual="/admin/inc/top.asp"-->
        

            

        <!-- Page Content -->
        <div id="page-wrapper">
            <div class="container-fluid">
                <div class="row">
                    <div class="col-lg-12">
                        <h1 class="page-header">Blank</h1>
                    </div>
                    <!-- /.col-lg-12 -->
                </div>
                <!-- /.row -->
                <div class="row">
                	<div class="panel panel-default">
                        <div class="panel-heading">
                            Kitchen Sink
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                
<table class="table table-hover">
<thead>
  <tr>
    <th>栏目名</th>
    <th>属性</th>
    <th>相关操作</th>    
  </tr>
</thead>
  <tbody>
<%

dim data,class_list,imgno,trclass,tempKG,k,catetype,catetype_str
set rs =Easp.Db.sel("select cateid,catename,followid,depth,sonid,parentid,orderID,cateType,isHome from category order by depth,orderID")
			if not rs.eof then
				data= rs.getRows()
			end if
			rs.close
			
	class_list=""
	
	
sub classlist(byval t0)
		dim i
		for i=0 to ubound(data,2)
			if t0=data(2,i) then
			'If data(3,i)>1 then class_list=class_list& "├"
		if  data(3,i)=1  then '一级分类 和 有下级栏目的 分类显示 +号图标  or instr(data(4,i),",")>0
					imgno=3
					trclass="td_southidc"
		else
					imgno=3		
					trclass="td_southidc"		
		end if
				trclass="td_southidc" &	data(3,i)	
				class_list=class_list&"<tr class="""&trclass&"""><td align=""left"">"
				tempKG=""
				For k=2 To data(3,i)
					class_list=class_list&"&nbsp;&nbsp;&nbsp;&nbsp;"
					tempKG=tempKG&"&nbsp;&nbsp;&nbsp;&nbsp;"
				next
				
				
				
				class_list=class_list&"<img src=""../Images/tree_folder"&imgno&".gif"" width=""19"" height=""18"" align=""absbottom""><b>"&data(1,i)&"</b> ("&data(6,i)&")</td>"
				select case data(7,i)
					case 1
					catetype= "栏目（列表）"
					 catetype_str="<a href=""companyadd.asp?Act=edit&ID="&data(0,i)&""">修改属性</a> | <a href=""companyadd.asp?followid="&data(0,i)&""">添加下级栏目</a> | <a href=""companyAll.asp?Act=del&ID="&data(0,i)&""" onClick=""return confirm('删除之后,相关内容也会被删除,并且不能恢复!\n\n确定要删除吗？');"">删除</a>"
					 case 0
					catetype= "栏目（内容）"
					 catetype_str="<a href=""companyadd.asp?Act=edit&ID="&data(0,i)&""">修改属性</a> | <a href=""companyadd.asp?followid="&data(0,i)&""">添加下级栏目</a> | <a href=""companyAll.asp?Act=del&ID="&data(0,i)&""" onClick=""return confirm('删除之后,相关内容也会被删除,并且不能恢复!\n\n确定要删除吗？');"">删除</a>"
					case 2
					catetype= "单网页"
					catetype_str="<a href=""companyadd.asp?Act=edit&ID="&data(0,i)&""">修改属性</a> | <a href=""companyadd.asp?followid="&data(0,i)&""">添加下级栏目</a> | <a href=""companyAll.asp?Act=del&ID="&data(0,i)&""" onClick=""return confirm('删除之后,相关内容也会被删除,并且不能恢复!\n\n确定要删除吗？');"">删除</a>"
					case 3
					catetype= "单链接"
				catetype_str="<a href=""companyadd.asp?Act=edit&ID="&data(0,i)&""">修改属性</a> | <a href=""companyadd.asp?followid="&data(0,i)&""">添加下级栏目</a> | <a href=""companyAll.asp?Act=del&ID="&data(0,i)&""" onClick=""return confirm('删除之后,相关内容也会被删除,并且不能恢复!\n\n确定要删除吗？');"">删除</a>"
				end select
				class_list=class_list & "<td align=""center"" class="""&trclass&""">"&catetype&" "
				
				
					
					If data(8,i)=0 Then
				class_list=class_list &  ("<a href='companyAll.asp?Act=IsHide&s=1&id="&data(0,i)&"' title='点击显示'><font color='#A2A2A2'>隐</font></a>&nbsp;")
			Else
				class_list=class_list & ("<a href='companyAll.asp?Act=IsHide&s=0&id="&data(0,i)&"' title='点击隐藏'><font color='#999999'>显</font></a>&nbsp;")
			End If
				
				class_list=class_list &"</td>"
				
				class_list=class_list & "<td align=""left""  class="""&trclass&""" style=""padding-left:25px;"">"
				
				class_list=class_list &tempKG&catetype_str
				
				
				class_list=class_list&"</td></tr>"
				
				classlist(data(0,i))
			end if
		next
	end sub
	if isarray(data) then	
		call classlist(0)	
	end if	
response.write class_list		

%>	
</tbody>
</table>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                
            </div>
            <!-- /.container-fluid -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->

    <!-- jQuery -->
    <script src="../bower_components/jquery/dist/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="../bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="../bower_components/metisMenu/dist/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="../dist/js/sb-admin-2.js"></script>
<script type="text/javascript">
$(function(){
		
	$("tr[class^=td_southidc] img").click(function(){
		
	var tr_this = $(this).parent().parent();
	//$("tr[class^=td_southidc]").click(function(){
		//alert($(this).attr("class"));
		//$(this).nextUntil("td[class^=td_southidc").parent().toggle();
		var curClass=$(tr_this).attr("class");
		var curClassNum=parseInt(curClass.substr(11,1));
		//alert(curClassNum);
		var img1="../Images/tree_folder3.gif";		
		var img2="../Images/tree_folder4.gif";
		var isOpen=true;
		if ($(tr_this).find("img").attr("src")==img1)
		{
			$(tr_this).find("img").attr("src",img2);
			isOpen=false;
		}
		else
		{
			$(tr_this).find("img").attr("src",img1);
			isOpen=true;
		}
		
		
		//alert(subClass);
		//$(this).nextUntil("tr[class="+curClass+"]").nextUntil("tr[class!="+subClass+"]").toggle();
		var k=1;
		$(tr_this).nextUntil("tr[class="+curClass+"]").each(function(index,element){
			 if( parseInt($(element).attr("class").substr(11,1))>curClassNum && k==1 )
			 {
				 //alert($(element).attr("class").substr(11,1));
				 if($(element).is(":hidden") )
				 {
					if(isOpen){
						$(element).show();
						$(this).find("img").attr("src",img1);
					}
					else{
						$(element).hide();
						$(this).find("img").attr("src",img2);
					}
					
				 }
				 else
				 {
				 	$(element).hide();
				 }				 
			 }
			 else
			 {
				 k=2;
			 }
		});
		
		

	});
});
</script>
</body>

</html>



