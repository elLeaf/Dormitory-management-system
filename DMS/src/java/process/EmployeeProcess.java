/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package process;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import manage.ManageDorm;
import manage.ManageEmployee;
import model.Employee;

/**
 *
 * @author anst_
 */
@WebServlet(name = "EmployeeProcess", urlPatterns = {"/emp.do"})
public class EmployeeProcess extends HttpServlet {

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
            ManageEmployee mEmp = new ManageEmployee(conn);
            String button = request.getParameter("submit");
            
            if(button.equals("create")) {
                try {
                    Employee emp = new Employee();
                    emp.setUsername(request.getParameter("username"));
                    String psw1 = request.getParameter("password1");
                    String psw2 = request.getParameter("password2");
                    if(psw1.equals(psw2)) {
                        emp.setPassword(psw1);
                    }
                    else {
                        response.sendRedirect("myemployee.jsp");
                    }
                    emp.setRole(request.getParameter("role"));
                    emp.setFname(request.getParameter("fname"));
                    emp.setLname(request.getParameter("lname"));
                    emp.setGender(request.getParameter("gender"));
                    emp.setAge(Integer.parseInt(request.getParameter("age")));
                    emp.setPhone(request.getParameter("phone"));
                    emp.setPosition(request.getParameter("position"));
                    emp.setSalary(Double.parseDouble(request.getParameter("salary")));
                    emp.setDorm_id(Integer.parseInt(request.getParameter("dorm_id")));
                    if(mEmp.createEmployee(emp)) {
                        response.sendRedirect("employee.jsp");
                    }
                    else {
                        response.sendRedirect("myemployee.jsp");
                    }
                } catch (Exception ex) {
                    Logger.getLogger(ManageDorm.class.getName()).log(Level.SEVERE, null, ex);
                    response.sendRedirect("myemployee.jsp");
                }
            }
            else if(button.equals("edit")) {
                int dorm_id = Integer.parseInt(request.getParameter("dorm_id"));
                int emp_id = Integer.parseInt(request.getParameter("emp_id"));
                if(mEmp.setEmp(emp_id)) {
                    Employee emp = mEmp.getEmp();
                    request.setAttribute("myedit", "1");
                    request.setAttribute("emp", emp);
                    RequestDispatcher rp = request.getRequestDispatcher("myemployee.jsp");
                    rp.forward(request, response);
                }
                else {
                    response.sendRedirect("employee.jsp");
                }
            }
            else if(button.equals("update")) {
                try {
                    Employee emp = new Employee();
                    emp.setFname(request.getParameter("fname"));
                    emp.setLname(request.getParameter("lname"));
                    emp.setGender(request.getParameter("gender"));
                    emp.setAge(Integer.parseInt(request.getParameter("age")));
                    emp.setPhone(request.getParameter("phone"));
                    emp.setPosition(request.getParameter("position"));
                    emp.setSalary(Double.parseDouble(request.getParameter("salary")));
                    emp.setId(Integer.parseInt(request.getParameter("emp_id")));
                    if(mEmp.updateEmployee(emp)) {
                        response.sendRedirect("employee.jsp");
                    }
                    else {
                        response.sendRedirect("myemployee.jsp");
                    }
                } catch (Exception ex) {
                    Logger.getLogger(ManageDorm.class.getName()).log(Level.SEVERE, null, ex);
                    response.sendRedirect("myemployee.jsp");
                }
            }
            else if(button.equals("delete")) {
                int emp_id = Integer.parseInt(request.getParameter("emp_id"));
                if(mEmp.deleteEmployee(emp_id)) {
                    response.sendRedirect("employee.jsp");
                }
                else {
                    response.sendRedirect("employee.jsp");
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
