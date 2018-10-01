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
 * Servlet implementation class Adding
 */
@WebServlet("/Adding")
public class Adding extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
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
		
		String title = request.getParameter("booktitle");
		String option = request.getParameter("booktype");
		String name = (String)session.getAttribute("login_name");
		
		if(option.equals("1")) {
			for(int i = 0;i < users.size();i++) {
				if(name.equals(users.get(i).getName())){
					if(users.get(i).library.getRead().size() == 0) {						users.get(i).library.getRead().add(title);
					}
						
					else {
						boolean exist = false;
						for(int j=0; j< users.get(i).library.getRead().size();j++) {
							if(users.get(i).library.getRead().get(j).equals(title))
								exist = true;
							
						}
						if(!exist)
							users.get(i).library.getRead().add(title);
					}
				}
			}
		}
		else if(option.equals("2")) {
			for(int i = 0;i < users.size();i++) {
				if(name.equals(users.get(i).getName())){
					if(users.get(i).library.getFavorite().size() == 0) {
						users.get(i).library.getFavorite().add(title);
						System.out.println("zhuzhu");
					}
					else {
						boolean ex = false;
						for(int j=0; j< users.get(i).library.getFavorite().size();j++){
							if(users.get(i).library.getFavorite().get(j).equals(title))
								ex = true;
						}
						if(!ex)
							users.get(i).library.getFavorite().add(title);
					}
				}
			}
		}
		PrintWriter out =  response.getWriter();
		try {
			gson = new GsonBuilder().setPrettyPrinting().create();
			//Make the whole arraylist as an object named after with "students"
			Data data = new Data(users);
			String jsonString = gson.toJson(data);
            FileWriter fileWriter = new FileWriter(getServletContext().getRealPath("/Sample.json"));
            fileWriter.write(jsonString);
            fileWriter.close();
            request.getSession().setAttribute("userlist", users);
    			
		
		
	}
		
		catch(IOException e)
		{
            e.printStackTrace();
		}
	}

}
