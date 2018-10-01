/**
 * 
 */
	
	 function Transition(searchInfo, searchType, iconType){

		 var temp = new String(searchInfo); 
		 //alert(temp);
		 //clear the data of the last search
		 sessionStorage.clear();
		 var type = '';
		 myStorage = window.sessionStorage;
		 //save the radio option after showing the search results in search page.
		 var radios = document.getElementsByName("choice");
		 for(i = 0; i < radios.length;i++){
			 if(radios[i].value == searchType)
				 radios[i].checked = true;
		 }
		 
		 //if do not enter anything.
		 if(searchInfo ==""){
			 alert("Please enter something");			 
		 }
		 if(temp == "null"){
			 //alert(document.getElementsByName("search").value);
			 $("#s").val("");
			 seachInfo = "";
			 
			 
		 }
		 var cb1 = document.getElementById("choice1");
		 var cb2 = document.getElementById("choice2");
		 if(iconType == "null"){
			
			 document.getElementById("sb").className='fas fa-book';
				cb1.style.display = "block";
				cb2.style.display = "block";
				$("#itype").val("0");
		 }
		 //alert(iconType);
		 if(iconType == "")
			 iconType = "1";
		if(iconType == "1")	 {
			document.getElementById("sb").className='far fa-user';
			cb1.style.display = "none";
			cb2.style.display = "none";
					
		}
		if (iconType == "0"){
			document.getElementById("sb").className='fas fa-book';
			cb1.style.display = "block";
			cb2.style.display = "block";
			$("#itype").val("0");
		}
		if(temp != "null" && iconType == "0" && searchInfo != ""){
			 
			 var url = '';
			 if(searchType == "author") type = "inauthor";
			 else if(searchType == "title") type = "intitle";
			 else if(searchType == "isbn") type = "isbn";
			 else if(searchType == "genre") type = "subject";
			 //Using jQuery get THE JSON object from the google book search API
			 $.get("https://www.googleapis.com/books/v1/volumes?q=" + searchInfo +"+"+ type + ":" + searchInfo+ "&maxResults=12", function(response){
				 console.log(response);
				 for(i=0;i< response.items.length;i++){
					 //catch the TypeError for the thumbnail
					 try{
						 myStorage.setItem('url'+i, response.items[i].volumeInfo.imageLinks.thumbnail);
						 url = response.items[i].volumeInfo.imageLinks.thumbnail;
					 	}catch(err){
					 		myStorage.setItem('url'+i, "https://vignette.wikia.nocookie.net/janethevirgin/images/4/42/Image-not-available_1.jpg/revision/latest?cb=2015072110231");
					 		url = "https://vignette.wikia.nocookie.net/janethevirgin/images/4/42/Image-not-available_1.jpg/revision/latest?cb=20150721102313";
					 	}
					 	//save the info of each book in sessionStorage
					 	myStorage.setItem('title'+i, response.items[i].volumeInfo.title);
						 myStorage.setItem('author'+i, response.items[i].volumeInfo.authors);
						 myStorage.setItem('publisher'+i, response.items[i].volumeInfo.publisher);
						 myStorage.setItem('description'+i, response.items[i].volumeInfo.description);
						 //check if there is a rating for that book.
						 if(response.items[i].volumeInfo.averageRating == null){
							 myStorage.setItem('rating'+i, 0.0);
						 }else
							 myStorage.setItem('rating'+i, response.items[i].volumeInfo.averageRating);
						 
						 //add the 12 books into three rows.
						 if(i<4){
							 $("#result1").append('<div class = "eachDiv">'+'<img id = "dynamic" src = '+url+' >'+'<br><br>'+'<a onclick = "return Description('+ i + ');"><h5 class = "title">' + 
									 response.items[i].volumeInfo.title + '</h5></a>'+'<h5 class = "author">' + "by " + response.items[i].volumeInfo.authors + '</h5>'+'</div>');
						 }
						 else if(i<8){
							 $("#result2").append('<div class = "eachDiv">'+'<img id = "dynamic" src = '+url+' >'+'<br><br>'+'<a onclick = "return Description('+ i + ');"><h5 class = "title">' + 
									 response.items[i].volumeInfo.title + '</h5></a>'+'<h5 class = "author">' + "by " + response.items[i].volumeInfo.authors + '</h5>'+'</div>');
						 }
						 else if(i<12){
							 $("#result3").append('<div class = "eachDiv">'+'<img id = "dynamic" src = '+url+' >'+'<br><br>'+'<a onclick = "return Description('+ i + ');"><h5 class = "title">' + 
									 response.items[i].volumeInfo.title + '</h5></a>'+'<h5 class = "author">' + "by " + response.items[i].volumeInfo.authors + '</h5>'+'</div>');
						 }
						 
					
				 }	 
			 });
		 }	
	 };
	 
	 //submit the hidden form in search page to /Link
	 function Description(i){
		 $("#im").val(myStorage.getItem('url'+i));
		 $("#ti").val(myStorage.getItem('title'+i));
		 $("#au").val(myStorage.getItem('author'+i));
		 $("#pu").val(myStorage.getItem('publisher'+i));
		 $("#de").val(myStorage.getItem('description'+i));
		 $("#ra").val(myStorage.getItem('rating'+i)); 
		 document.getElementById("description").submit();
		 return true;
	 };
	 
	 function Description(i){
		 $("#im").val(myStorage.getItem('url'+i));
		 $("#ti").val(myStorage.getItem('title'+i));
		 $("#au").val(myStorage.getItem('author'+i));
		 $("#pu").val(myStorage.getItem('publisher'+i));
		 $("#de").val(myStorage.getItem('description'+i));
		 $("#ra").val(myStorage.getItem('rating'+i)); 
		 document.getElementById("description").submit();
		 return true;
	 };
	 
	 //save the radio option after showing the search results in info page.
	 function Check(type){
		 //alert(type);
		 var radios = document.getElementsByName("choice");
		 for(i = 0; i < radios.length;i++){
			 //alert("sb");
			 //radios.checked = false;
			 if(radios[i].value == type)
				 radios[i].checked = true;
		 }
	 };
	 function addRead(title){
			var xhttp =new XMLHttpRequest();
			xhttp.open("GET", "Adding?booktitle="+title+"&booktype=1", false);
//			alert("wtf");
			xhttp.send();
			
		};
		function addFavorite(title){
			var xhttp =new XMLHttpRequest();
			xhttp.open("GET", "Adding?booktitle="+title+"&booktype=2", false);
			//alert("wtf");
			xhttp.send();
		};
		
	function getBookimg(bookString){
		//alert("xjbc");
		var read = document.getElementById("fop");
		var fav = document.getElementById("rop");
		fav.style.backgroundColor = "#4682b4";
		read.style.backgroundColor =  "#0EBDE7";
		var readresult = document.getElementById("lib_read");
		var favresult = document.getElementById("lib_fav");
		favresult.style.display = "none";
		readresult.style.display = "block";
		document.getElementById('lib_read').innerHTML="";
		var books = bookString.split(',');
		//alert(books.length);
		for(i=0; i< books.length-1;i++){
			$.get("https://www.googleapis.com/books/v1/volumes?q=" + books[i] +"+"+ "intitle"+ ":" +books[i] + "&maxResults=12", function(response){
				 console.log(response);
				 url = response.items[0].volumeInfo.imageLinks.thumbnail;
				 $("#lib_read").append('<div class = "eachbook">'+'<img id = "mid" src = '+url+' >'+'<p class = "author"><strong>' + response.items[0].volumeInfo.title + '<strong></p>'+'<p class = "author"><strong>' + "by " + response.items[0].volumeInfo.authors + '</strong></p>'+'</div>');
				 
			 });
		}
	};
	function getfavBookimg(bookString){
		//alert("xjbc");
		var read = document.getElementById("fop");
		var fav = document.getElementById("rop");
		fav.style.backgroundColor = "#0EBDE7";
		read.style.backgroundColor = "#4682b4";
		var readresult = document.getElementById("lib_read");
		var favresult = document.getElementById("lib_fav");
		favresult.style.display = "block";
		readresult.style.display = "none";
		document.getElementById('lib_fav').innerHTML="";
		var books = bookString.split(',');
		//alert(books.length);
		for(i=0; i< books.length-1;i++){
			$.get("https://www.googleapis.com/books/v1/volumes?q=" + books[i] +"+"+ "intitle"+ ":" +books[i] + "&maxResults=12", function(response){
				 console.log(response);
				 url = response.items[0].volumeInfo.imageLinks.thumbnail;
				 $("#lib_fav").append('<div class = "eachbook">'+'<img id = "mid" src = '+url+' >'+'<p class = "author"><strong>' + response.items[0].volumeInfo.title + '<strong></p>'+'<p class = "author"><strong>' + "by " + response.items[0].volumeInfo.authors + '</p>'+'</strong></div>');
				 
			 });
		}
	};
	function getfavBookimg2(bookString){
		//alert("xjbc");
		var fav = document.getElementById("fop");
		fav.style.backgroundColor = "#4682b4";
		var readresult = document.getElementById("lib_read");
		var favresult = document.getElementById("lib_fav");
		favresult.style.display = "block";
		readresult.style.display = "none";
		document.getElementById('lib_fav').innerHTML="";
		var books = bookString.split(',');
		//alert(books.length);
		for(i=0; i< books.length-1;i++){
			$.get("https://www.googleapis.com/books/v1/volumes?q=" + books[i] +"+"+ "intitle"+ ":" +books[i] + "&maxResults=12", function(response){
				 console.log(response);
				 url = response.items[0].volumeInfo.imageLinks.thumbnail;
				 $("#lib_fav").append('<div class = "eachbook">'+'<img id = "mid" src = '+url+' >'+'<p class = "author"><strong>' + response.items[0].volumeInfo.title + '</strong></p>'+'<p class = "author"><strong>' + "by " + response.items[0].volumeInfo.authors + '</strong></p>'+'</div>');
				 
			 });
		}
	};
	function seeProfile(username){
		//alert("tianyan");
		 $("#user_name").val(username);
		 
		 document.getElementById("su").submit();
		 return true;
	 };
	 
	 function follow(username,name){
		 var xhttp =new XMLHttpRequest();
		 if(name !=""){
			 if(document.getElementById("followed").innerHTML == "Follow"){
				
					xhttp.open("GET", "Follow?sp_user="+username, false);
					xhttp.send();
					document.getElementById("followed").innerHTML = "Unfollow";
			 }
			 else{
				
					xhttp.open("GET", "Unfollow?sp_user="+username, false);
					xhttp.send();
					document.getElementById("followed").innerHTML = "Follow";
			 }
			
		 }
		 
		
	 };
	 function notLogin(){
		 document.getElementById("circle").style.display = "none";
		 document.getElementById("followed").style.display = "none";
	 }
	

	
	
	

		 
	 