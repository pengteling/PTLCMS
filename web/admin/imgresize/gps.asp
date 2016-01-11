<%
'//////////// GPS锛欸et Picture Size //////////////
'//////////////鍒╃敤ADODB.stream銮峰彇锲剧墖灏哄//////////////
'/////////Cited By Leon锛埚绩鏅达级 2005骞?链?1镞?/////////

Class GPS
Dim aso

Private Sub Class_Initialize
Set aso=CreateObject("Adodb.Stream")
aso.Mode=3 
aso.Type=1 
aso.Open 
End Sub

Private Sub Class_Terminate
set aso=nothing
End Sub

Private Function Bin2Str(Bin)
Dim I, Str
For I=1 to LenB(Bin)
clow=MidB(Bin,I,1)
if AscB(clow)<128 then
Str = Str & Chr(ASCB(clow))
Else
I=I+1
if I <= LenB(Bin) then Str = Str & Chr(ASCW(MidB(Bin,I,1)&clow))
end If
Next 
Bin2Str = Str
End Function

Private Function Num2Str(num,base,lens)
'GPS (2005-8-11)
dim ret
ret = ""
while(num>=base)
ret = (num mod base) & ret
num = (num - num mod base)/base
wend
Num2Str = right(string(lens,"0") & num & ret,lens)
End Function

Private Function Str2Num(str,base)
'GPS (2005-8-11)
dim ret
ret = 0
for i=1 to len(str)
ret = ret *base + cint(mid(str,i,1))
next
Str2Num=ret
End Function

Private Function BinVal(bin)
'GPS (2002-8-11)
dim ret
ret = 0
for i = lenb(bin) to 1 step -1
ret = ret *256 + ascb(midb(bin,i,1))
next
BinVal=ret
End Function

Private Function BinVal2(bin)
'GPS (2002-8-11)
dim ret
ret = 0
for i = 1 to lenb(bin)
ret = ret *256 + ascb(midb(bin,i,1))
next
BinVal2=ret
End Function

'///浠ヤ笅鏄皟鐢ㄤ唬镰?//
Function getImageSize(filespec) 
'GPS (2002-8-11)
dim ret(3)
aso.LoadFromFile(filespec)
bFlag=aso.read(3)
select case hex(binVal(bFlag))
case "4E5089":
aso.read(15)
ret(0)="PNG"
ret(1)=BinVal2(aso.read(2))
aso.read(2)
ret(2)=BinVal2(aso.read(2))
case "464947":
aso.read(3)
ret(0)="GIF"
ret(1)=BinVal(aso.read(2))
ret(2)=BinVal(aso.read(2))
case "535746":
aso.read(5)
binData=aso.Read(1)
sConv=Num2Str(ascb(binData),2 ,8)
nBits=Str2Num(left(sConv,5),2)
sConv=mid(sConv,6)
while(len(sConv)<nBits*4)
binData=aso.Read(1)
sConv=sConv&Num2Str(ascb(binData),2 ,8)
wend
ret(0)="SWF"
ret(1)=int(abs(Str2Num(mid(sConv,1*nBits+1,nBits),2)-Str2Num(mid(sConv,0*nBits+1,nBits),2))/20)
ret(2)=int(abs(Str2Num(mid(sConv,3*nBits+1,nBits),2)-Str2Num(mid(sConv,2*nBits+1,nBits),2))/20)
case "FFD8FF":
do 
do: p1=binVal(aso.Read(1)): loop while p1=255 and not aso.EOS
if p1>191 and p1<196 then exit do else aso.read(binval2(aso.Read(2))-2)
do:p1=binVal(aso.Read(1)):loop while p1<255 and not aso.EOS
loop while true
aso.Read(3)
ret(0)="JPG"
ret(2)=binval2(aso.Read(2))
ret(1)=binval2(aso.Read(2))
case else:
if left(Bin2Str(bFlag),2)="BM" then
aso.Read(15)
ret(0)="BMP"
ret(1)=binval(aso.Read(4))
ret(2)=binval(aso.Read(4))
else
ret(0)=""
end if
end select
ret(3)="width=""" & ret(1) &""" height=""" & ret(2) &""""
getimagesize=ret
End Function
End Class
%>