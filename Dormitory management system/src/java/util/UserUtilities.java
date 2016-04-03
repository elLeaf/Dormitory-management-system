/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package util;

import bean.User;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
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
    public Connection getConnection() {
        return conn;
    }
    
}
