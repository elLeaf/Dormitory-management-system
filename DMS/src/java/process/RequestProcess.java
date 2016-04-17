/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package process;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import manage.ManageRequest;
import model.Request;

/**
 *
 * @author anst_
 */
@WebServlet(name = "RequestProcess", urlPatterns = {"/request.do"})
public class RequestProcess extends HttpServlet {

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
            String button = request.getParameter("submit");
            ManageRequest mReq = new ManageRequest(conn);
            
            if(button.equals("create")) {
                Request req = new Request();
                req.setRenter_id(Integer.parseInt(request.getParameter("renter_id")));
                req.setTitle(request.getParameter("req_title"));
                req.setDetail(request.getParameter("req_detail"));
                req.setType(request.getParameter("req_type"));
                if(mReq.createRequest(req)) {
                    response.sendRedirect("myrequest.jsp");
                }
                else {
                    response.sendRedirect("myrequest.jsp");
                }
            }
            
            else if(button.equals("update")) {
                int req_id = Integer.parseInt(request.getParameter("req_id"));
                if(mReq.setRequest(req_id)) {
                    if(mReq.updateStatus("รับทราบ")) {
                        response.sendRedirect("requestbox.jsp");
                    }
                    else {
                        response.sendRedirect("request.box.jsp");
                    }
                }
                else {
                    response.sendRedirect("requestbox.jsp");
                }
            }
            
            else if(button.equals("delete")) {
                int req_id = Integer.parseInt(request.getParameter("req_id"));
                if(mReq.deleteRequest(req_id)) {
                    response.sendRedirect("requestbox.jsp");
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
