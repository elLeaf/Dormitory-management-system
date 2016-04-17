/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package manage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;

/**
 *
 * @author anst_
 */
public class ManageLogin {
    
    private Connection conn;
    
    public ManageLogin(Connection conn) {
        this.conn = conn;
    }
    
    public User Login(String id, String psw) {
        User user = null;
        String sql = "select * from users where username=? and password=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, psw);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                user = new User();
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                if(user.getRole().equals("ผู้ดูแลหอพัก") || user.getRole().equals("ผู้ดูแลด้านการเงิน")) {
                    sql = "select dorm_id, emp_id from employees where username=?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, user.getUsername());
                    rs = pstmt.executeQuery();
                    while(rs.next()) {
                        user.setDorm_id(rs.getInt("dorm_id"));
                        user.setUser_id(rs.getInt("emp_id"));
                    }
                }
                else if(user.getRole().equals("ผู้เช่า")) {
                    sql = "select dorm_id, renter_id from renters "
                            + "join contract "
                            + "using (renter_id) "
                            + "join rooms "
                            + "using(room_no) "
                            + "where username=?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, user.getUsername());
                    rs = pstmt.executeQuery();
                    while(rs.next()) {
                        user.setDorm_id(rs.getInt("dorm_id"));
                        user.setUser_id(rs.getInt("renter_id"));
                    }
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageLogin.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }
}
