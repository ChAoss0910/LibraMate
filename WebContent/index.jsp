<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>

	<%@ page import= "com.google.gson.*" %>
	<%@ page import= "java.io.*"%>
	<%@ page import= "java.util.*"%>
	<%@ page import= "libramate.Data"%>
	<%@ page import= "libramate.User"%>
	<% 
	
		request.getSession().invalidate(); 
		request.getSession().setAttribute("login_imageurl", "https://travellersrestplantation.org/wp-content/uploads/2017/08/person-icon-8.png");
	%>
	<%
		
			
			File file = new File(getServletContext().getRealPath("/Sample.json"));  
	    		BufferedReader reader = null;  
	   		String jsonStr = "";  
	   
	    		reader = new BufferedReader(new FileReader(file));  
	   	 	String tempString = null;  
	   		 while ((tempString = reader.readLine()) != null) {  
	    			jsonStr = jsonStr + "\n"+tempString;  
	   	 	}  
	    		reader.close();  
	    		JsonObject jsonObject = null;
			;
		//get the json object with name "students" and transfer it into json array.
			jsonObject = new JsonParser().parse(jsonStr).getAsJsonObject();
			JsonArray jsonArray = jsonObject.getAsJsonArray("users");

			Gson gson = new Gson();
			ArrayList<User> users = new ArrayList<>();
		//Deserialize each of item in json array into student object.
			for (JsonElement it : jsonArray) {
				User user = gson.fromJson(it, User.class);
				users.add(user);
			} 
			
			//ArrayList<User> userlist = (ArrayList<User>)request.getSession().getAttribute("userlist");
			request.getSession().setAttribute("login_name", "");
			request.getSession().setAttribute("userlist", users);
			ArrayList<User> userlist = (ArrayList<User>)request.getSession().getAttribute("userlist");
			
			%>
		
		
	
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<meta charset="UTF-8">
		<title>Home Page</title>
		<link rel="stylesheet" type="text/css" href="home.css">
		<link rel="stylesheet" type="text/css" href="user.css">
	</head>
	<body>
		<div class = "container">
			<div class = "content">
				<form name = "book_search" method ="GET" action = "Validate">
					<font style="color: white ;font-family: Arial; font-weight:bold; font-size: 36pt; font-border:2px;text-shadow: 1px 1px 0 #000,
						1px -1px 0 #000,
              -1px 1px 0 #000, 
              1px 1px 0 #000;"> LibraMate</font>
					<div class= "search-container">
						<input name = "search" type = "text" placeholder="Search"/>
						<a onclick = "notLogin();">
							<button type="submit"><i class="fa fa-search"></i></button>
						</a>
					</div>
					
					<div id = "choice">
						<div class = "c1">
							<input type = "radio" name = "choice" id = "searchtype" value = "title" checked/> <strong>Title</strong>
							<br><br>       
							<input type = "radio" name = "choice" id = "searchtype" value = "author" /> <strong>Author</strong>
						</div>
						
						<div class = "c2">
							
							<input type = "radio" name = "choice" id = "searchtype" value = "isbn"/> <strong>ISBN</strong>
							<br><br>
							<input type = "radio" name = "choice" id = "searchtype" value = "genre" /> <strong>Genre</strong><br>
						</div>

					</div>
					
					
				</form>
				<div id = "buttons1">
						<a href = "signup.jsp"><button class="button">Sign Up</button></a>
				</div>
				<div id = "buttons2">
						<a href = "login.jsp"><button class="button">Login</button></a>
				</div>
			</div>
		</div>
		<script src = "myscript.js"></script>
	</body>
</html>