
<html>
<meta charset="utf-8"/>


    <head>

       
        <script language="JavaScript" runat="server"  type="text/javascript" src="js/cryptico.js"></script>

<%
 privateKey="pengteling"
         MattsRSAkey = cryptico.generateRSAKey(privateKey, 512)

         MattsPublicKeyString = cryptico.publicKeyString(MattsRSAkey)
         response.write MattsPublicKeyString
%>
        <script>

        function print(string)
        {
            document.write(string + "\n\n");
        }

        var privateKey="pengteling";  //服务器定义私钥 不传递
        var MattsRSAkey = cryptico.generateRSAKey(privateKey, 1024);

        var MattsPublicKeyString = cryptico.publicKeyString(MattsRSAkey);  //公钥

        print(MattsPublicKeyString); //得到公钥
        // var sign = cryptico.publicKeyID(cryptico.publicKeyString(MattsRSAkey));
        // print("签名:"+sign);

        //将公钥 传输到客户端


        //客户端  接收公钥 MattsPublicKeyString  加密

        var password ="123456";//待加密的密码
        var EncryptionResult = cryptico.encrypt(password, MattsPublicKeyString); //只需要公钥
        print(EncryptionResult.cipher);

        var EncryptStr = EncryptionResult.cipher;
        //回传服务器 加密后的          





        MattsRSAkey = cryptico.generateRSAKey(privateKey, 1024); //服务器 私钥产生的对象 重新生成
        var DecryptionResult = cryptico.decrypt(EncryptStr, MattsRSAkey); // 服务器接收 加密数据EncryptStr  解密
        
        //print("The decrypted message:");
        print(DecryptionResult.plaintext); 



        
            
        </script>

    </head>
    
    <body style="font-family: monospace; white-space:pre;">

    </body>
    
</html>

































