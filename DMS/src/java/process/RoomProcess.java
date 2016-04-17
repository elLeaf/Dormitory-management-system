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
import manage.ManageRoom;
import model.Dorm;
import model.Room;

/**
 *
 * @author anst_
 */
@WebServlet(name = "RoomProcess", urlPatterns = {"/room.do"})
public class RoomProcess extends HttpServlet {

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
            ManageRoom mRoom = new ManageRoom(conn);
            ManageDorm mDorm = new ManageDorm(conn);
            String button = request.getParameter("submit");
            
            if(button.equals("create")){
                Room room = new Room();
                int room_no;
                double room_charge;
                int room_floor;
                String room_status;
                int air = 0;
                int fan = 0;
                try{
                    room_no = Integer.parseInt((String) request.getParameter("room_no"));
                    room_charge = Double.parseDouble((String) request.getParameter("room_charge"));
                    room_floor = Integer.parseInt((String) request.getParameter("room_floor"));
                    room_status = "ว่าง";
                    int dorm_id = Integer.parseInt((String) request.getParameter("dorm_id"));
                    String[] t = request.getParameterValues("type");
                    for(String each: t) {
                        if(each.equals("air")) {
                            air = 1;
                        }
                        else if(each.equals("fan")){
                            fan = 1;
                        }
                    }
                    room.setNumber(room_no);
                    room.setCharge(room_charge);
                    room.setFloor(room_floor);
                    room.setStatus(room_status);
                    room.setAir(air);
                    room.setFan(fan);
                    room.setDorm_id(dorm_id);
                    if(mRoom.createRoom(room)) {
                        if(mDorm.setDorm(dorm_id)) {
                            Dorm dorm = mDorm.getDorm();
                            ArrayList<Room> rooms = mRoom.getAllRoom(dorm_id);
                            request.setAttribute("dorm", dorm);
                            request.setAttribute("rooms", rooms);
                            RequestDispatcher obj = request.getRequestDispatcher("room.jsp");
                            obj.forward(request, response);
                        }
                    }
                    else {
                        request.setAttribute("room", room);
                        RequestDispatcher obj = request.getRequestDispatcher("myroom.jsp");
                        obj.forward(request, response);
                    }
                } catch(Exception ex) {
                    Logger.getLogger(ManageDorm.class.getName()).log(Level.SEVERE, null, ex);
                    request.setAttribute("room", room);
                    RequestDispatcher obj = request.getRequestDispatcher("myroom.jsp");
                    obj.forward(request, response);
                }
            }
            else if(button.equals("edit")) {
                int dorm_id = Integer.parseInt((String) request.getParameter("dorm_id"));
                int room_no = Integer.parseInt((String) request.getParameter("room_no"));
                if(mRoom.setRoom(room_no)) {
                    Room room = mRoom.getRoom();
                    request.setAttribute("myedit", "1");
                    request.setAttribute("room", room);
                    RequestDispatcher rp = request.getRequestDispatcher("myroom.jsp");
                    rp.forward(request, response);
                }
            }
            else if(button.equals("update")) {
                Room room = new Room();
                int room_no;
                double room_charge;
                int room_floor;
                String room_status;
                int air = 0;
                int fan = 0;
                try{
                    room_no = Integer.parseInt((String) request.getParameter("room_no"));
                    room_charge = Double.parseDouble((String) request.getParameter("room_charge"));
                    room_floor = Integer.parseInt((String) request.getParameter("room_floor"));
                    room_status = "ว่าง";
                    int dorm_id = Integer.parseInt((String) request.getParameter("dorm_id"));
                    String[] t = request.getParameterValues("type");
                    for(String each: t) {
                        if(each.equals("air")) {
                            air = 1;
                        }
                        else if(each.equals("fan")){
                            fan = 1;
                        }
                    }
                    room.setNumber(room_no);
                    room.setCharge(room_charge);
                    room.setFloor(room_floor);
                    room.setStatus(room_status);
                    room.setAir(air);
                    room.setFan(fan);
                    room.setDorm_id(dorm_id);
                    if(mRoom.updateRoom(room)) {
                        if(mDorm.setDorm(dorm_id)) {
                            Dorm dorm = mDorm.getDorm();
                            ArrayList<Room> rooms = mRoom.getAllRoom(dorm_id);
                            request.setAttribute("dorm", dorm);
                            request.setAttribute("rooms", rooms);
                            RequestDispatcher obj = request.getRequestDispatcher("room.jsp");
                            obj.forward(request, response);
                        }
                    }
                    else {
                        request.setAttribute("room", room);
                        RequestDispatcher obj = request.getRequestDispatcher("myroom.jsp");
                        obj.forward(request, response);
                    }
                } catch(Exception ex) {
                    Logger.getLogger(ManageDorm.class.getName()).log(Level.SEVERE, null, ex);
                    request.setAttribute("room", room);
                    RequestDispatcher obj = request.getRequestDispatcher("myroom.jsp");
                    obj.forward(request, response);
                }
            }
            else if(button.equals("delete")) {
                try {
                    if(mRoom.deleteRoom(Integer.parseInt(request.getParameter("room_no")))) {
                        int  dorm_id = Integer.parseInt(request.getParameter("dorm_id"));
                        if(mDorm.setDorm(dorm_id)) {
                            Dorm dorm = mDorm.getDorm();
                            request.setAttribute("dorm", dorm);
                            ArrayList<Room> rooms = mRoom.getAllRoom(dorm_id);
                            request.setAttribute("rooms", rooms);
                            RequestDispatcher rp = request.getRequestDispatcher("room.jsp");
                            rp.forward(request, response);
                        }
                        
                    }
                    else {
                        int  dorm_id = Integer.parseInt(request.getParameter("dorm_id"));
                        if(mDorm.setDorm(dorm_id)) {
                            Dorm dorm = mDorm.getDorm();
                            request.setAttribute("dorm", dorm);
                            ArrayList<Room> rooms = mRoom.getAllRoom(dorm_id);
                            request.setAttribute("rooms", rooms);
                            RequestDispatcher rp = request.getRequestDispatcher("room.jsp");
                            rp.forward(request, response);
                        }
                    }
                } catch (Exception ex) {
                    Logger.getLogger(ManageDorm.class.getName()).log(Level.SEVERE, null, ex);
                    int  dorm_id = Integer.parseInt(request.getParameter("dorm_id"));
                        if(mDorm.setDorm(dorm_id)) {
                            Dorm dorm = mDorm.getDorm();
                            request.setAttribute("dorm", dorm);
                            ArrayList<Room> rooms = mRoom.getAllRoom(dorm_id);
                            request.setAttribute("rooms", rooms);
                            RequestDispatcher rp = request.getRequestDispatcher("room.jsp");
                            rp.forward(request, response);
                        }
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
