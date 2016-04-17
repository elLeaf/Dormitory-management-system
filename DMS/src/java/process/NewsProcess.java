/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package process;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import manage.ManageNews;
import model.News;
import model.User;

/**
 *
 * @author anst_
 */
@WebServlet(name = "NewsProcess", urlPatterns = {"/news.do"})
public class NewsProcess extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            request.setCharacterEncoding("utf-8");
            ServletContext sc = request.getServletContext();
            Connection conn = (Connection) sc.getAttribute("connection");
            ManageNews mNews = new ManageNews(conn);
            String button = request.getParameter("submit");
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");
            
            if(button.equals("create")) {
                News news = new News();
                news.setTitle(request.getParameter("news_title"));
                news.setDetail(request.getParameter("news_detail"));
                news.setEmp_id(user.getUser_id());
                if(mNews.createNews(news)) {
                    response.sendRedirect("managenews.jsp");
                }
                else {
                    response.sendRedirect("mynews.jsp");
                }
            }
            
            else if(button.equals("edit")) {
                News news = new News();
                news.setTitle(request.getParameter("news_title"));
                news.setDetail(request.getParameter("news_detail"));
                news.setId(Integer.parseInt(request.getParameter("news_id")));
                request.setAttribute("news", news);
                request.setAttribute("myedit", 1);
                RequestDispatcher obj = request.getRequestDispatcher("mynews.jsp");
                obj.forward(request, response);
            }
            
            else if(button.equals("update")) {
                News news = new News();
                news.setTitle(request.getParameter("news_title"));
                news.setDetail(request.getParameter("news_detail"));
                news.setId(Integer.parseInt(request.getParameter("news_id")));
                if(mNews.updateNews(news)) {
                    response.sendRedirect("managenews.jsp");
                }
                else {
                    response.sendRedirect("mynews.jsp");
                }
            }
            
            else if(button.equals("delete")) {
                if(mNews.deleteNews(Integer.parseInt(request.getParameter("news_id")))) {
                    response.sendRedirect("managenews.jsp");
                }
                else {
                    response.sendRedirect("managenews.jsp");
                }
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
