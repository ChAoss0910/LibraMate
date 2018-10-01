package libramate;

import java.io.IOException;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Validate
 */
@WebServlet("/Validate")
public class Validate extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//work for getting data from howe page and search page, and sending data to search page
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String iconType = (String)request.getParameter("icon_type");
		String searchInfo = (String)request.getParameter("search");
		String searchType = (String)request.getParameter("choice");
		String pageToForward  ="";
		if(searchInfo.equals("null"))
			searchInfo = "";
		if(searchInfo != null) {
			request.setAttribute("searchInfo", searchInfo);
			request.setAttribute("searchType", searchType);
			request.setAttribute("iconType", iconType);
			if(iconType == null)
				iconType = "0";
			if(iconType.equals("0")) {
				pageToForward =  "/search.jsp";
				request.setAttribute("iconType", "0");
			}
			else {
				pageToForward =  "/user_search.jsp";
				request.setAttribute("iconType", "1");
			}
		}
		else
			pageToForward = "/index.jsp";
		
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher(pageToForward);
		dispatch.forward(request, response);
	}
}
