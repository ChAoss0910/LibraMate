<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Sign Up</title>
	<link rel="stylesheet" type="text/css" href="home.css">
	<link rel="stylesheet" type="text/css" href="user.css">
	
	<script>
			function validate(){
				var xhttp =new XMLHttpRequest();
				xhttp.open("GET", "Login?username="+document.user_signup.username.value +
						"&password=" + document.user_signup.password.value + "&imageurl=" + document.user_signup.imageurl.value, false);
				xhttp.send();
				
				//alert(xhttp.responseText);
				if(xhttp.responseText.trim().length == 18)
					return true;
				else if(xhttp.responseText.trim().length > 0){
					
					var res = new String(xhttp.responseText);
					
					if(res.indexOf("T") >= 0){
						document.getElementById("nameerr").innerHTML = "<font color = \"red \">Username Taken</font>";
						document.getElementById("nameerr").style.background ='#6BDDF7';
					}
					if(res.indexOf("1") >= 0){
						document.getElementById("nameerr").style.background ='#6BDDF7';
						document.getElementById("nameerr").innerHTML = "<font color = \"red \">Entry Cannot be Empty</font>";
					}
					else if(res.indexOf("T") < 0 && res.indexOf("1") < 0){
						document.getElementById("nameerr").innerHTML = "";
						document.getElementById("nameerr").style.background ='#05C0FC';
					}
					
						
					if(res.indexOf("2") >= 0){
						document.getElementById("pwerr").style.background ='#6BDDF7';
						document.getElementById("pwerr").innerHTML = "<font color = \"red \">Entry Cannot be Empty</font>";
					}
					else if (res.indexOf("2") < 0){
						document.getElementById("pwerr").innerHTML = "";
						document.getElementById("pwerr").style.background ='#05C0FC';
					}
						
						
					if(res.indexOf("3") >= 0){
						document.getElementById("imerr").style.background ='#6BDDF7';
						document.getElementById("imerr").innerHTML = "<font color = \"red \">Entry Cannot be Empty</font>";
					}
					else if (res.indexOf("3") < 0){
						document.getElementById("imerr").innerHTML = "";
						document.getElementById("imerr").style.background ='#05C0FC';
					}
							
					return false;
				}
				/* alert("woc");
				return true; */
			}
			
		</script>
	</head>
	<body>
		<div class = "usercontainer">
			<div class = "returnHome">
			
						<a href = "index.jsp">
						<font style="color: white ;font-weight:bold; font-family: Arial; font-size: 30pt; text-shadow: 1px 1px 0 #000,
						1px -1px 0 #000,
             			-1px 1px 0 #000, 
             			1px 1px 0 #000;">  LibraMate</font>
              		 </a>
			</div>
			<br>
			<div class = "usercontent">
				<form name = "user_signup" method ="GET" action = "search.jsp" onSubmit = "return validate()">
					<font style="color: white ;font-family: Arial; font-weight:bold; font-size: 36pt; font-border:2px;text-shadow: 1px 1px 0 #000,
						1px -1px 0 #000,
              -1px 1px 0 #000, 
              1px 1px 0 #000;">Sign Up</font>
					<div id= "userinput">
						<br><br><br>
						<div id = "un">
							<font style="color: black ;font-family: Arial; font-weight:bold; font-size: 18pt;">Username</font><br />
							<input class = "infoinput" name = "username" type = "text" placeholder=""/>
						</div>
						<div id = "nameerr"></div>
						
						<div id = "pw">
							<font style="color: black ;font-family: Arial; font-weight:bold; font-size: 18pt;">Password</font><br />
							<input class = "infoinput" name = "password" type = "text" placeholder=""/>
						</div>
						<div id = "pwerr"></div>
						
						<div id = "imgurl">
							<font style="color: black ;font-family: Arial; font-weight:bold; font-size: 18pt;">imageURL</font><br />
							<input class = "infoinput" name = "imageurl" type = "text" placeholder=""/>
						</div>
						<div id = "imerr"></div>
						
					</div>
					
					<div id = "buttons3">
						<a href = "signup.jsp"><button type ="submit" class="buttonaft">Sign Up</button></a>
						
					</div>
						
					
						
				</div>
					
					
			</form>
			</div>
		</div>
		<script src = "myscript.js"></script>
	</body>
	</html>