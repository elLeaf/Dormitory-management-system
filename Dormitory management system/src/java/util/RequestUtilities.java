/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Request;

/**
 *
 * @author adisorn
 */
public class RequestUtilities {
    
    private Connection conn;
    
    public RequestUtilities(Connection conn) {
        this.conn = conn;
    }
    
    private String generateId(String s) {
        String s1 = "r";
        String[] s2 = s.split("r");
        int num = Integer.parseInt(s2[1]) + 1;
        s1 += String.valueOf(num);
        return s1;
    }
    
    public void addRequest(Request req, String renter_id) {
        String sql1 = "select req_id from REQUESTS";
        String sql2 = "insert into REQUESTS values(?,?,?,CURDATE(),?,?,?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql1);
            ResultSet rs = pstmt.executeQuery();
            String ss = null;
            while(rs.next()) {
                ss = rs.getString("req_id");
            }
            String s = generateId(ss);
            
            pstmt = conn.prepareStatement(sql2);
            pstmt.setString(1, s);
            pstmt.setString(2, req.getReq_title());
            pstmt.setString(3, req.getReq_detail());
            pstmt.setString(4, "waiting");
            pstmt.setString(5, req.getReq_type());
            pstmt.setString(6, renter_id);
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(RequestUtilities.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
