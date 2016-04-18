<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
	<script src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
    <script language="jscript" src="js/jsencrypt.js" runat="server"></script>
</head>
<body>

<div id="pubkey">
-----BEGIN PUBLIC KEY-----
MIGeMA0GCSqGSIb3DQEBAQUAA4GMADCBiAKBgG8jdLGEm1qXIbhdz0dHw1J14vGn
G6aPX/E9WWgWvkhmq7wjCrIjBddTQrf/1EndusLmxQlixdZUnohKybcv/3IholTc
b+m+Z0ANTWTRKlkU9Cuw3Uty1gkLGQoFr0FLvd+6E5KC8dNoNkr6NPD4NF5YtG0H
+MrUblGVABnrZaMJAgMBAAE=
-----END PUBLIC KEY-----
</div>

<div id="privkey">
	-----BEGIN RSA PRIVATE KEY-----
MIICWwIBAAKBgG8jdLGEm1qXIbhdz0dHw1J14vGnG6aPX/E9WWgWvkhmq7wjCrIj
BddTQrf/1EndusLmxQlixdZUnohKybcv/3IholTcb+m+Z0ANTWTRKlkU9Cuw3Uty
1gkLGQoFr0FLvd+6E5KC8dNoNkr6NPD4NF5YtG0H+MrUblGVABnrZaMJAgMBAAEC
gYA+iqVQgF8sS4AeUCwk4K156f0cH/3fbS+AghWeDa5m7+AUr2OFe0/+LEyPXtgH
+U7v/w1CiuLqChRsfimlfM0ymzJ6mATZsYDgmOe5pTeLNcadUT55AOuqnMTseNB1
Q6J25p9TFJFSj6L6gJ67LsELv4PvVNRkT6OZBWA7U7n4AQJBAM4NEeyqTCF/3bjO
Rfdvw2sfNY6HX45dwR0dwaJvn7SQrzLn9aV9fhXQ5ZMqa3xMd050Tihmvb64FY+/
KdNdmHkCQQCKFGNnuUabRozpCnyb28oajE4KmO6sWcUJ+P9S8ZE8Ym03YkymjwzK
hxa+t3m6kk+oS5Ft7WR2nWhFt4xU99sRAkBEgjf5dk3FvZvcvEirEm/pCAFomD3/
OdDhe2lMNszk3k5CILmeAnGPk1shaTM/qrToUudBq5de+BnDJ44ihrYRAkAieAR4
mB+wE2SJqDyDC9Lf3bZ9nr+19pLhcm8KXZNL56Yr9TX9PiiLRj2/Tj3s/Sk1cefT
8TbrBVBKVw+JBnaBAkEAt70BqvWeI/BTnfrvFRCEt4sbcV0acQV6qVTSgmpaJaxP
6qh6rS/LeAAjGGIL6LeHWiRYOCBKWLe1MXjycLF8nw==
-----END RSA PRIVATE KEY-----
</div>
	
	<script>
	var encrypt = new JSEncrypt();
          encrypt.setPublicKey($('#pubkey').html());
          var encrypted = encrypt.encrypt("ererer");
          //alert(encrypted);

          var decrypt = new JSEncrypt();
          decrypt.setPrivateKey($('#privkey').html());
          var uncrypted = decrypt.decrypt(encrypted);
          alert(uncrypted);
	</script>
</body>
</html>