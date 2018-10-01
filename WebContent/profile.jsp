<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Your Profile</title>
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
		String name = (String)session.getAttribute("login_name");
		
		
		ArrayList<String> following = null;
		ArrayList<String> follower = null;
		ArrayList<String> read = null;
		ArrayList<String> fav = null;
		ArrayList<User> userList = (ArrayList<User>)request.getSession().getAttribute("userlist");
		for(int i = 0; i< userList.size();i++){
			if(name.equals(userList.get(i).getName())){
				following = (ArrayList<String>)userList.get(i).getFollowing();
				follower = (ArrayList<String>)userList.get(i).getFollowers();
				read = (ArrayList<String>)userList.get(i).library.getRead();
				fav = (ArrayList<String>)userList.get(i).library.getFavorite();
			}
		}
		
		String readString  ="";
		for(int i = 0;i < read.size();i++){
			readString += read.get(i)+",";
		}
		String favString ="";
		for(int i = 0;i < fav.size();i++){
			favString += fav.get(i)+",";
		}
		//String jj = userList.get(2).getName();
		
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
			
			 window.location.href="index.jsp?backurl="+window.location.href;    
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
						<input id = "s" name = "search" type = "text" placeholder="Search" >
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
				<div id = "circle" style = 'background:url(<%=iurl%>)'>
							<img id ="cirimg" src = <%=iurl%>>
						</div>
				
				
			</div>
			</a>
			<div id = "result"> 
					<div id="info">
						<div id ="bigicon">
							<img id = "big_photo" src =  <%=iurl%>>
						</div>
						<div id = "follow">
							<div id = "myname">@<%=name %></div>
							<div id ="follow_option">
								<div id ="following" onclick='document.getElementById("following").style.backgroundColor="#4682b4";document.getElementById("follower").style.backgroundColor= "#0EBDE7";document.getElementById("follow_result1").style.display = "block";document.getElementById("follow_result1").style.display = "block";document.getElementById("follow_result2").style.display = "none";document.getElementById("follow_result2").style.display = "none";'>
									
									Following
								</div>
								<div id ="follower" onclick= 'document.getElementById("follower").style.backgroundColor="#4682b4";document.getElementById("following").style.backgroundColor= "#0EBDE7";document.getElementById("follow_result1").style.display = "none";document.getElementById("follow_result1").style.display = "none";document.getElementById("follow_result2").style.display = "block";document.getElementById("follow_result2").style.display = "block";'>
									Followers
								</div>
							</div>
							
								<div id = "follow_result1">
							<% 
								if(following.size() != 0){%>
									
								<% for(int i = 0;i< following.size();i++){%>	
									<div class = "following_name">@<%=following.get(i)%></div>
						
								<%}%>
								<%}%>
							</div>
							<div id = "follow_result2">
								<% 
								if(follower.size() != 0){%>
									
								<% for(int i = 0;i< follower.size();i++){%>	
									<div class = "following_name">@<%=follower.get(i)%></div>
						
								<%}%>
								<%}%>
							</div>
							
							
							
						</div>
					</div>
					
					<div class = "lib_top">
						<div class = "lib">Your Library</div>
						<a href = "index.jsp"><div class = "back">Logout</div></a>
						
					</div>
					
						<a onclick = "getBookimg('<%=readString%>');"><div id = "rop" class = "read_op">Read</div></a>
						<a onclick = "getfavBookimg('<%=favString%>');"><div id = "fop" class = "fav_op">Favorites</div></a>
						<div id = "lib_read" class = "lib_result1">
							<%-- <% 
								if(read.size() != 0){%>
									
								<% for(int i = 0;i< read.size();i++){%>	
									<div class = "booksname"><%=read.get(i)%></div>
									
								<%}%>
							<%}%> --%>
						</div>
						<div id = "lib_fav" class = "lib_result2">
							<%-- <% 
								if(fav.size() != 0){%>
									
								<% for(int i = 0;i< fav.size();i++){%>	
									<div class = "booksname"><%=fav.get(i)%></div>
						
								<%}%>
								<%}%> --%>
						</div>
					
					<!-- <div class = "force-overflow"></div> -->
			</div>
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