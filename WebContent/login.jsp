<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Login</title>
		<link rel="stylesheet" type="text/css" href="home.css">
		<link rel="stylesheet" type="text/css" href="user.css">
		
		<script>
			function validate(){
				var xhttp =new XMLHttpRequest();
				xhttp.open("GET", "Login?username="+document.user_login.username.value +
						"&pw_login=" + document.user_login.pw_login.value, false);
				xhttp.send();
				userStorage = window.sessionStorage;
				/* if(xhttp.responseText.trim().equals("<font color = \"red \">Username Taken</font>")){
					document.getElementById("nameerr").innerHTML = xhttp.responseText;
					return false;
				} */
				//alert(xhttp.responseText);
				if(xhttp.responseText.trim().length == 45){
					/* userStorage.setItem("imgurl", ) */
					return true;
				}
			
				if(xhttp.responseText.trim().length > 0){
					
					var res = new String(xhttp.responseText);
					
					if(res.indexOf("exist") >= 0){
						document.getElementById("nameerr").innerHTML = "<font color = \"red \">Username Incorrect</font>";
						document.getElementById("nameerr").style.background ='#6BDDF7';
					}
					if(res.indexOf("1") >= 0){
						document.getElementById("nameerr").style.background ='#6BDDF7';
						document.getElementById("nameerr").innerHTML = "<font color = \"red \">Entry Cannot be Empty</font>";
					}
					else if(res.indexOf("exist") < 0 && res.indexOf("1") < 0){
						document.getElementById("nameerr").innerHTML = "";
						document.getElementById("nameerr").style.background ='#05C0FC';
					}
					
					if(res.indexOf("pwwrong") >= 0){
						/* alert("woc"); */
						document.getElementById("pwerr").style.background ='#6BDDF7';
						document.getElementById("pwerr").innerHTML = "<font color = \"red \">Password Incorrect</font>";
					}
					else if(res.indexOf("pwwrong") < 0){
						document.getElementById("pwerr").innerHTML = "";
						document.getElementById("pwerr").style.background ='#05C0FC';
					}
						
					if(res.indexOf("4") >= 0){
						document.getElementById("pwerr").style.background ='#6BDDF7';
						document.getElementById("pwerr").innerHTML = "<font color = \"red \">Entry Cannot be Empty</font>";
					}
					else if(res.indexOf("4") < 0 && res.indexOf("pwwrong") < 0){
						document.getElementById("pwerr").innerHTML = "";
						document.getElementById("pwerr").style.background ='#05C0FC';
					}
						
						
					return false;
				}
				
				/* return true; */
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
				<form name = "user_login" method ="GET" action = "search.jsp" onSubmit = "return validate()">
					<font style="color: white ;font-family: Arial; font-weight:bold; font-size: 36pt; font-border:2px;text-shadow: 1px 1px 0 #000,
						1px -1px 0 #000,
              -1px 1px 0 #000, 
              1px 1px 0 #000;">Login</font>
					<div id= "userinput">
						<br><br><br>
						<div id = "un">
							<font style="color: black ;font-family: Arial; font-weight:bold; font-size: 18pt;">Username</font><br />
							<input class = "infoinput" name = "username" type = "text" placeholder=""/>
							
						</div>
						<div id = "nameerr"></div>
						<div id = "pw">
							<font style="color: black ;font-family: Arial; font-weight:bold; font-size: 18pt;">Password</font><br />
							<input class = "infoinput" name = "pw_login" type = "text" placeholder=""/>
						</div>
						<div id = "pwerr"></div>
						
					</div>
					
					<div id = "buttons3">
						<a href = "login.jsp"><button class="buttonaft">Login</button></a>
					</div>
						
					
						
				</div>
					
					
				</form>
			</div>
		</div>
		<script src = "myscript.js"></script>
	</body>
</html>