package libramate;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Link
 */
@WebServlet("/Link")
public class Link extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#service(HttpServletRequest request, HttpServletResponse response)
	 */
	//work for getting data from search page and sending data to info page
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String searchInfo = request.getParameter("si");
		String searchType = request.getParameter("st");
		String url = request.getParameter("sp_img");
		String title = request.getParameter("sp_title");
		String author = request.getParameter("sp_author");
		String publisher = request.getParameter("sp_publisher");
		String description = request.getParameter("sp_description");
		String rating = request.getParameter("sp_rating");
		request.setAttribute("searchInfo", searchInfo);
		request.setAttribute("searchType", searchType);
		request.setAttribute("url", url);
		request.setAttribute("title", title);
		request.setAttribute("author", author);
		request.setAttribute("publisher",publisher);
		request.setAttribute("description",description);
		request.setAttribute("rating", rating+"0");
		String next = "/info.jsp";
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
