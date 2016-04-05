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
    
    public void addRequest(Request req, String renter_id) {
        String sql1 = "select max(req_id) as req_id from REQUESTS";
        String sql2 = "insert into REQUESTS values(?,?,?,CURDATE(),?,?,?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql1);
            ResultSet rs = pstmt.executeQuery();
            int max_id = 0;
            while(rs.next()) {
                max_id = rs.getInt("req_id");
            }
            max_id++;
            pstmt = conn.prepareStatement(sql2);
            pstmt.setInt(1, max_id);
            pstmt.setString(2, req.getReq_title());
            pstmt.setString(3, req.getReq_detail());
            pstmt.setString(4, req.getReq_status());
            pstmt.setString(5, req.getReq_type());
            pstmt.setString(6, renter_id);
            pstmt.executeUpdate();
            pstmt.close();
            rs.close();
        } catch (SQLException ex) {
            Logger.getLogger(RequestUtilities.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
}
