<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>User Search</title>
</head>
	<head>
	<%@ page import= "java.util.*"%>
	<%@ page import= "libramate.Data"%>
	<%@ page import= "libramate.User"%>
	<%	
		String searchInfo = (String)request.getAttribute("searchInfo");
		String searchType = (String)request.getAttribute("searchType");
		String iconType = (String)request.getAttribute("iconType");
		
		String iurl= (String)session.getAttribute("login_imageurl");
		ArrayList<User> userList = (ArrayList<User>)request.getSession().getAttribute("userlist");
		ArrayList<User> userSearch  = new ArrayList<User>();
		for(int i = 0;i < userList.size();i++){
			if(userList.get(i).getName().indexOf(searchInfo) == 0){
				userSearch.add(userList.get(i));
			}
		}
		String name =  (String)session.getAttribute("login_name");
		String jsonString = (String)session.getAttribute("data");
		//String jj = (String)userList.get(2).getName();
	%>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link href="https://use.fontawesome.com/releases/v5.0.7/css/all.css" rel="stylesheet">
	<link href="https://use.fontawesome.com/releases/v5.0.7/css/all.css" rel="stylesheet">

	<script>
	  
		function changeIcon(){
			var cb1 = document.getElementById("choice1");
			var cb2 = document.getElementById("choice2");
			if(document.getElementById("sb").className == null){
				document.getElementById("sb").className='fas fa-book';
				cb1.style.display = "block";
				cb2.style.display = "block";
				$("#itype").val("0");
			}
				
			else if(document.getElementById("sb").className == 'fas fa-book'){
				document.getElementById("sb").className='far fa-user';
				
				cb1.style.display = "none";
				cb2.style.display = "none";
				$("#itype").val("1");
			}
				
			else{
				document.getElementById("sb").className='fas fa-book';
				cb1.style.display = "block";
				cb2.style.display = "block";
				$("#itype").val("0");
			}
				
		}
		function clearStorage(){
			
			 window.location.href="home.html?backurl="+window.location.href;    
		}
		function userIconReset(){
			var cb1 = document.getElementById("choice1");
			var cb2 = document.getElementById("choice2");
			document.getElementById("sb").className='far fa-user';
			cb1.style.display = "none";
			cb2.style.display = "none";
			$("#itype").val("1");
			document.getElementsByName("icon_type").value ='1';
		}
		
	</script>
	
		<link rel="stylesheet" type="text/css" href="home.css">
		<link rel="stylesheet" type="text/css" href="user.css">
		
	</head>
	
	<body onload = "userIconReset();">
		<div class = "container2">
			<div class = "topnav">
				<form id = "book_search2" method = "GET" action ="Validate">
					<div class = "titleName"> 
						<a href = "index.jsp" >
						<font style="color: white ;font-weight:bold; font-family: Arial; font-size: 24pt; text-shadow: 1px 1px 0 #000,
						1px -1px 0 #000,
             			-1px 1px 0 #000, 
             			1px 1px 0 #000;">LibraMate</font>
              		 </a>
					</div>
					
					<div class= "search-container">
						<input id = "s" name = "search" type = "text" placeholder="Search" value = "<%=searchInfo%>">
						<button type = "button" onclick = "changeIcon()"><i id = "sb" ></i></button>
					</div>
						<div class = "c1-after" id = "choice1">
							<input type = "radio" name = "choice" id = "searchtype" value = "title" checked/> <strong>Title </strong>
							<br><br>       
							<input type = "radio" name = "choice" id = "searchtype" value = "author" /> <strong>Author</strong>
						</div>
						
						<div class = "c2-after" id = "choice2">
							
							<input type = "radio" name = "choice" id = "searchtype" value = "isbn" /> <strong>ISBN</strong>
							<br><br>
							<input type = "radio" name = "choice" id = "searchtype" value = "genre"/> <strong>Genre</strong><br>
						</div>
						<input name = "icon_type" id = "itype" type = "hidden">
				</form>
				<a href = "profile.jsp">
					<% 
								if(!name.equals("")){%>
									<div id = "circle" style = 'background:url(<%=iurl%>)'>
										<img id ="cirimg" src = <%=iurl%>>
									</div>
								
								<%}%>
				</a>
				
				
				
			</div>
			<div id = "result"> <!-- display the result of 12 books in three rows-->
					<!-- <div id = "result1"> -->
					<% 
						if(userSearch.size() == 0){%>
							<p id = "nuf">No User Found!</hp><%}%>
					<% for(int i = 0;i< userSearch.size();i++){%>
						
						<div class = "otheruser">
							<a onclick = "seeProfile('<%=userSearch.get(i).getName() %>');"><img class = "otheruser_photo" src ="<%=userSearch.get(i).getImageURL() %>"></a><br>
							<div class = "usersearchname">@<%=userSearch.get(i).getName() %></div>
						</div>
					<%}%>
					<!-- </div>
					<div id = "result2">
					</div>
					<div id = "result3">
					</div> -->
					<!-- <div class = "force-overflow"></div> -->
			</div>
			<form id = "su" method = "GET" action = "Find">
				<input name = "seeUser" id = "user_name" type = "hidden">
			</form>
			<form id = "description" method = "GET" action = "Link">
				
				<input name = "st" id = "st" type = "hidden" value = "<%=searchType%>">
				<input name = "si" id = "si" type = "hidden" value = "<%=searchInfo%>">
				<input name = "sp_img" id = "im" type = "hidden">
				<input name ="sp_title" id = "ti" type = "hidden">	
				<input name ="sp_author" id = "au" type = "hidden">
				<input name ="sp_publisher" id = "pu" type = "hidden">
				<input name ="sp_description" id = "de" type = "hidden">
				<input name = "sp_rating" id = "ra" type = "hidden">
			</form>
			
		</div>
		
		<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<script src = "https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
		<script src = "myscript.js"></script>
	</body>
</html>