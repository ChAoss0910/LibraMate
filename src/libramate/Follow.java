package libramate;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
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
 * Servlet implementation class Follow
 */
@WebServlet("/Follow")
public class Follow extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username = (String)request.getParameter("sp_user");
		HttpSession session=request.getSession();
		String login_name = (String)session.getAttribute("login_name");
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
		boolean added = false;
		for(int i = 0; i<users.size();i++) {
			if(login_name.equals(users.get(i).getName())) {
				if(users.get(i).getFollowing().size() == 0) {
					users.get(i).getFollowing().add(username);
					request.getSession().setAttribute("follow", "Unfollow");
					added = true;
				}
					
				else {
					boolean exist = false;
					for(int j =0; j < users.get(i).getFollowing().size();j++) {
						if(username.equals(users.get(i).getFollowing().get(j))) {
							exist = true;
						}
					}
					if(!exist) {
						users.get(i).getFollowing().add(username);
						request.getSession().setAttribute("follow", "Unfollow");
						added = true;
					}
						
				}
			}
		}
		for(int i = 0; i<users.size();i++) {
			if(username.equals(users.get(i).getName())) {
				if(added) {
					boolean ex = false;
					for(int j =0; j <users.get(i).getFollowers().size();j++ ) {
						if(login_name.equals(users.get(i).getFollowers().get(j)))
							ex = true;
					}
					if(!ex)
						users.get(i).getFollowers().add(login_name);
				}
					
			}
		}
		
		
		//PrintWriter out =  response.getWriter();
		//out.println(users.get(0).library.getRead());
		try {
			gson = new GsonBuilder().setPrettyPrinting().create();
			//Make the whole arraylist as an object named after with "students"
			Data data = new Data(users);
			String jsonString = gson.toJson(data);
    			FileWriter fileWriter = new FileWriter(getServletContext().getRealPath("/Sample.json"));
    			fileWriter.write(jsonString);
    			fileWriter.close();
    			//System.out.println(users.get(0).library.getRead());
    			request.getSession().setAttribute("userlist", users);
    			//System.out.println(jsonString);
		
		
	}
		
		catch(IOException e)
		{
			//System.out.println("wawawawawa");
				e.printStackTrace();
		}
	}

}
