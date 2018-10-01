package libramate;

import java.io.BufferedReader;

import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.NotSerializableException;
import java.io.Serializable;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;




/**
 * Servlet implementation class Link
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	//work for getting data from search page and sending data to info page
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
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
			User user = gson.fromJson(it, new TypeToken<User>() {}.getType());
			users.add(user);
		}
		//Data data = new Data(users);
		HttpSession session=request.getSession();
		//HttpServletRequest request = ServletActionContext.getRequest();
		PrintWriter out =  response.getWriter();
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String imageurl = request.getParameter("imageurl");
		
		String pw_login = request.getParameter("pw_login");
		boolean exist = false;
		boolean ex = false;
		boolean pwCorrect = false;
		for(int i = 0; i < users.size();i++) {
			if(username.equalsIgnoreCase(users.get(i).getName()) )
				out.println("<font color = \"red \">Username Taken</font>");
		}
		for(int i = 0; i < users.size();i++) {			
			if(username.equals(users.get(i).getName()) ) {
				session.setAttribute("login_imageurl",users.get(i).getImageURL());
				session.setAttribute("login_name", users.get(i).getName());
				exist = true;
				if(!(pw_login == null || pw_login.trim().length() == 0)) {
					if((!pw_login.equals("")) && pw_login.equals(users.get(i).getPassword()))
						pwCorrect = true;
				}
			}
		}
		if(!exist)
			out.println("nonexist");
		if(!pwCorrect)
			out.println("pwwrong");
		if(username == null || username.trim().length() == 0)
			out.print("1");
		if(password == null || password.trim().length() == 0)
			out.print("2");
		if(imageurl == null || imageurl.trim().length() == 0)
			out.print("3");
		if(pw_login == null || pw_login.trim().length() == 0)
			out.print("4");
		
		//Sign up (adding new users)
		if(!exist && username != null && username.trim().length() != 0 && password != null && password.trim().length() != 0 && 
				imageurl != null && imageurl.trim().length() != 0) {
			User newUser = new User(username, password, imageurl);
			users.add(newUser);
			session.setAttribute("login_imageurl",newUser.getImageURL());
			session.setAttribute("login_name", newUser.getName());
		}
		session.setAttribute("userlist", users);

        gson = new GsonBuilder().setPrettyPrinting().create();
        //Make the whole arraylist as an object named after with "students"
        Data data = new Data(users);
        String jsonString = gson.toJson(data);
        FileWriter fileWriter = new FileWriter(getServletContext().getRealPath("/Sample.json"));
        fileWriter.write(jsonString);
        fileWriter.close();
        session.setAttribute("data", jsonString);
    			
		out.flush();
		out.close();
	}
		catch(IOException e)
		{
				e.printStackTrace();
		}
		
	}

	
}
