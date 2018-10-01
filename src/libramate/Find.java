package libramate;

import java.io.BufferedReader;

import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.reflect.TypeToken;

/**
 * Servlet implementation class Find
 */
@WebServlet("/Find")
public class Find extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username = (String)request.getParameter("seeUser");
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
		HttpSession session=request.getSession(false);
		for(int i= 0;i<users.size();i++) {
			if(username.equals(users.get(i).getName())) {
				session.setAttribute("username", username);
				session.setAttribute("userfing", users.get(i).getFollowing());
				session.setAttribute("userfer", users.get(i).getFollowers());
				session.setAttribute("userread", users.get(i).library.getRead());
				session.setAttribute("userfav", users.get(i).library.getFavorite());
				session.setAttribute("user_url", users.get(i).getImageURL());
			}
		}
		String next = "/userprofile.jsp";
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(next);
    		try {
    			dispatch.forward(request,response);
    			} catch (IOException e) {
    				// TODO Auto-generated catch block
    				e.printStackTrace();
    			} catch (ServletException e) {
    				// TODO Auto-generated catch block
    				e.printStackTrace();
    			}
		
		
		
	}

}
