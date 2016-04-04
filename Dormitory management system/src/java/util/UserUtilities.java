/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package util;

import model.User;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Renter;
/**
 *
 * @author adisorn
 */
public class UserUtilities {
    
    private Connection conn;
    private User user = null;
    
    public UserUtilities(Connection conn) {
        this.conn = conn;
    }
    
    public User getUser(String username, String psw) {
        String sql = "SELECT * FROM USERS WHERE username=?;";
        try {
            PreparedStatement pstmt = this.conn.prepareStatement(sql);
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                if(rs.getString("username").equals(username) && rs.getString("password").equals(psw)) {
                    user = new User();
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role"));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserUtilities.class.getName()).log(Level.SEVERE, null, ex);
        }
        return user;
    }
    
    public Renter getRenter(String username) {
        Renter renter = null;
        String sql = "SELECT * FROM RENTERS JOIN USERS USING(username) where username=?";
        try {
            PreparedStatement pstmt = this.conn.prepareStatement(sql);
            pstmt.setString(1, username);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                renter = new Renter();
                renter.setRenter_id(rs.getString("renter_id"));
                renter.setRenter_fname(rs.getString("renter_fname"));
                renter.setRenter_lname(rs.getString("renter_lname"));
                renter.setRenter_gender(rs.getString("renter_gender"));
                renter.setRenter_age(rs.getString("renter_age"));
                renter.setRenter_phone("0"+rs.getString("renter_phone"));
                return renter;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserUtilities.class.getName()).log(Level.SEVERE, null, ex);
        }
        return renter;
    }
    
}
