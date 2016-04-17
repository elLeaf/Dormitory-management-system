/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package process;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import manage.ManageDorm;
import manage.ManageRoom;
import model.Dorm;
import model.Room;

/**
 *
 * @author anst_
 */
@WebServlet(name = "DormProcess", urlPatterns = {"/dorm.do"})
public class DormProcess extends HttpServlet {

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
            ManageDorm mDorm = new ManageDorm(conn);
            String button = request.getParameter("submit");
            
            if(button.equals("create")){
                Dorm dorm = new Dorm();
                String dorm_name;
                double elect_rate;
                double water_rate;
                String dorm_phone;
                try{
                    dorm_name = request.getParameter("dorm_name");
                    elect_rate = Double.parseDouble((String) request.getParameter("elect_rate"));
                    water_rate = Double.parseDouble((String) request.getParameter("water_rate"));
                    dorm_phone = request.getParameter("dorm_phone");
                    dorm.setName(dorm_name);
                    dorm.setElect_rate(elect_rate);
                    dorm.setWater_rate(water_rate);
                    dorm.setPhone(dorm_phone);
                    if(mDorm.createDorm(dorm)) {
                        response.sendRedirect("dorm.jsp");
                    }
                    else {
                        request.setAttribute("dorm", dorm);
                        RequestDispatcher obj = request.getRequestDispatcher("mydorm.jsp");
                        obj.forward(request, response);
                    }
                } catch(Exception ex) {
                    request.setAttribute("dorm", dorm);
                    RequestDispatcher obj = request.getRequestDispatcher("mydorm.jsp");
                    obj.forward(request, response);
                }
            }
            else if(button.equals("delete")) {
                if(mDorm.setDorm(Integer.parseInt(request.getParameter("dorm_id")))) {
                    if(mDorm.deleteDorm()) {
                        response.sendRedirect("dorm.jsp");
                    }
                    else {
                        response.sendRedirect("dorm.jsp");
                    }
                }
            }
            else if(button.equals("view")) {
                int  dorm_id = Integer.parseInt(request.getParameter("dorm_id"));
                ManageRoom mRoom = new ManageRoom(conn);
                if(mDorm.setDorm(dorm_id)) {
                    Dorm dorm = mDorm.getDorm();
                    request.setAttribute("dorm", dorm);
                    ArrayList<Room> rooms = mRoom.getAllRoom(dorm_id);
                    request.setAttribute("rooms", rooms);
                    RequestDispatcher rp = request.getRequestDispatcher("room.jsp");
                    rp.forward(request, response);
                }
                else {
                    response.sendRedirect("dorm.jsp");
                }          
            }
            else if(button.equals("edit")) {
                int  dorm_id = Integer.parseInt(request.getParameter("dorm_id"));
                if(mDorm.setDorm(dorm_id)) {
                    Dorm dorm = mDorm.getDorm();
                    request.setAttribute("dorm", dorm);
                    request.setAttribute("myedit", "1");
                    RequestDispatcher rp = request.getRequestDispatcher("mydorm.jsp");
                    rp.forward(request, response);
                }
                else {
                    response.sendRedirect("dorm.jsp");
                }          
            }
            else if(button.equals("update")) {
                Dorm dorm = new Dorm();
                int dorm_id;
                String dorm_name;
                double elect_rate;
                double water_rate;
                String dorm_phone;
                try{
                    dorm_id = Integer.parseInt(request.getParameter("dorm_id"));
                    dorm_name = request.getParameter("dorm_name");
                    elect_rate = Double.parseDouble((String) request.getParameter("elect_rate"));
                    water_rate = Double.parseDouble((String) request.getParameter("water_rate"));
                    dorm_phone = request.getParameter("dorm_phone");
                    dorm.setId(dorm_id);
                    dorm.setName(dorm_name);
                    dorm.setElect_rate(elect_rate);
                    dorm.setWater_rate(water_rate);
                    dorm.setPhone(dorm_phone);
                    if(mDorm.updateDorm(dorm)) {
                        response.sendRedirect("dorm.jsp");
                    }
                    else {
                        request.setAttribute("dorm", dorm);
                        request.setAttribute("myedit", "1");
                        RequestDispatcher rp = request.getRequestDispatcher("mydorm.jsp");
                        rp.forward(request, response);
                    }
                } catch(Exception ex) {
                    response.sendRedirect("mydorm.jsp");
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
