/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package process;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import manage.ManageRenter;
import model.Contract;
import model.Renter;

/**
 *
 * @author anst_
 */
@WebServlet(name = "RenterProcess", urlPatterns = {"/renter.do"})
public class RenterProcess extends HttpServlet {

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
            ManageRenter mRenter = new ManageRenter(conn);
            
            if(button.equals("create")) {
                Renter renter = new Renter();
                Contract contract = new Contract();
                renter.setUsername(request.getParameter("username"));
                String psw1 = request.getParameter("password1");
                String psw2 = request.getParameter("password2");
                if(psw1.equals(psw2)) {
                    renter.setPassword(psw1);
                }
                else {
                    response.sendRedirect("myemployee.jsp");
                }
                renter.setRole("ผู้เช่า");
                renter.setFname(request.getParameter("fname"));
                renter.setLname(request.getParameter("lname"));
                renter.setAge(Integer.parseInt(request.getParameter("age")));
                renter.setGender(request.getParameter("gender"));
                renter.setPhone(request.getParameter("phone"));
                renter.setCareer(request.getParameter("carreer"));
                
                contract.setRoom_no(Integer.parseInt(request.getParameter("room_no")));
                DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                Date myDate = format.parse(request.getParameter("date"));
                java.sql.Date sqlDate = new java.sql.Date(myDate.getTime());
                contract.setEnd_date(sqlDate);
                contract.setDeposit(Double.parseDouble("deposit"));
                
                if(mRenter.createRenter(renter, contract)) {
                    response.sendRedirect("managerenter.jsp");
                }
                else {
                    response.sendRedirect("myrenter.jsp");
                }
                
            }
            
        } catch (ParseException ex) {
            Logger.getLogger(RenterProcess.class.getName()).log(Level.SEVERE, null, ex);
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
