<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
	<%	
		String searchInfo = (String)request.getAttribute("searchInfo");
		String searchType = (String)request.getAttribute("searchType");
		String url = (String)request.getAttribute("url");
		String title = (String)request.getAttribute("title");
		String author = (String)request.getAttribute("author");
		String publisher = (String)request.getAttribute("publisher");
		String description = (String)request.getAttribute("description");
		String rating  = (String)request.getAttribute("rating");
		
		String name =  (String)session.getAttribute("login_name");
		String iurl= (String)session.getAttribute("login_imageurl"); 
	
	%>
	
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link href="https://use.fontawesome.com/releases/v5.0.7/css/all.css" rel="stylesheet">
	
	
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Info Page</title>
		<link rel="stylesheet" type="text/css" href="home.css">
		<link rel="stylesheet" type="text/css" href="user.css">
		<link rel="stylesheet" type="text/css" href="star.css">
		<link rel="stylesheet" type="text/css" href="addBook.css">

	</head>
	
	
	<body onload = "Check('<%=searchType%>');">
	
		<div class = "container2">
			<div class = "topnav">
				<form id = "book_search2" method = "GET" action ="Validate">
					<div class = "titleName"> 
					<a href = "index.jsp">
						<font style="color: white ;font-weight:bold; font-family: Arial;font-size: 24pt; text-shadow: 1px 1px 0 #000,
						1px -1px 0 #000,
              -1px 1px 0 #000, 
              1px 1px 0 #000;"> LibraMate</font>
              </a>
					</div>
					
					<div class= "search-container">
						<input name = "search" type = "text" placeholder="Search" value = "<%=searchInfo%>">
						<button type="submit"><i class="fas fa-book"></i></button>
					</div>				
						<div class = "c1-after">
							<input type = "radio" name = "choice" id = "searchtype" value = "title"/> <strong>Title </strong>
							<br><br>       
							<input type = "radio" name = "choice" id = "searchtype" value = "author" /> <strong>Author</strong>
						</div>
						
						<div class = "c2-after">
							
							<input type = "radio" name = "choice" id = "searchtype" value = "isbn"/> <strong>ISBN</strong>
							<br><br>
							<input type = "radio" name = "choice" id = "searchtype" value = "genre" /> <strong>Genre</strong><br>
						</div>
		
				</form>
				<a href = "profile.jsp">
				<% 
								if(!name.equals("")){%>
									<div id = "circle" style = 'background:url(<%=iurl%>)'>
										<img id ="cirimg" src = <%=iurl%>>
									</div>
								
								<%}%>
		
			</div>
			</a>
			
		<div id = "descript"><!-- show the description -->
			
			<div id = "image"><!-- large image -->
				<img src = "<%=url%>" id = "i">
				<br>
				<% 
								if(!name.equals("")){%>
									<div class="dropdown" >
  										<div class="dropbtn" >Add to Library</div>
  					
  										<div class="dropdown-content" >
    										<a onclick="addRead('<%=title%>');"><strong>Read</strong></a>
    										<a onclick="addFavorite('<%=title%>');"><strong>Favorite</strong></a>
    						
  									</div>
								</div>
								
								<%}%>
				
				<!-- <div id="down"><button id="triangle-down"></button></div> -->
			</div> 
			<div id = "des"><!--  -->
				
				<font style="color: white ;font-weight:bold; font-size: 36pt; text-shadow: 2px 2px 0 #000,
						2px -2px 0 #000,
              -2px 2px 0 #000, 
              2px 2px 0 #000;"> <%=title%></font><br><br>
              
				<font style="color: white ;font-weight:bold; font-size: 28pt; text-shadow: 2px 2px 0 #000,
						2px -2px 0 #000,
              -2px 2px 0 #000, 
              2px 2px 0 #000;">by <%=author%></font><br><br>
              <font style="color: white ;font-weight:bold; font-size: 22pt; text-shadow: 2px 2px 0 #000,
						2px -2px 0 #000,
              -2px 2px 0 #000, 
              2px 2px 0 #000;">Publisher: </font>
              
				<font style = "font-weight: bold; font-size: 18pt;">     <%=publisher%></font><br><br>
				<font style="color: white ;font-weight:bold; font-size: 22pt; text-shadow: 2px 2px 0 #000,
						2px -2px 0 #000,
              -2px 2px 0 #000, 
              2px 2px 0 #000;">Description:</font><br><br>
				<font style = "font-weight: bold; font-size: 16pt;"><%=description%></font><br><br>
				<font style="color: white ;font-weight:bold; font-size: 22pt; text-shadow: 2px 2px 0 #000,
						2px -2px 0 #000,
              -2px 2px 0 #000, 
              2px 2px 0 #000;">Rating: </font><br />
				<div id = "rate">
					<div class="star-ratings-css">
  						<div class="star-ratings-css-top" style="width: <%=rating%>%;"><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span></div>
  						<div class="star-ratings-css-bottom"><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span></div>
					</div><br>
					
				</div>
				
			 </div>
			 <div class = "force-overflow"></div>
		</div>	
			
		</div>
		
		
		<script src = "https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
		<script src = "https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
		<script src = "myscript.js"></script>
		
	</body>
</html>