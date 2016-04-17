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
import model.Request;

/**
 *
 * @author anst_
 */
public class ManageRequest {
    
    private Connection conn;
    private Request req;
    
    public ManageRequest(Connection conn) {
        this.conn = conn;
        req = new Request();
    }
    
    public boolean setRequest(int req_id) {
        boolean result = false;
        String sql = "select * from requests where req_id=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, req_id);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                req.setId(rs.getInt("req_id"));
                req.setTitle(rs.getString("req_title"));
                req.setDetail(rs.getString("req_detail"));
                req.setStatus(rs.getString("req_status"));
                req.setType(rs.getString("req_type"));
                req.setRenter_id(rs.getInt("renter_id"));
                result = true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageRequest.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
    
    public Request getRequest() {
        return req;
    }
    
    public boolean createRequest(Request req) {
        boolean result = false;
        String sql = "insert into requests values(null, ?, ?, ?, curdate(), ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, req.getTitle());
            pstmt.setString(2, req.getDetail());
            pstmt.setString(3, req.getType());
            pstmt.setString(4, "รอ");
            pstmt.setInt(5, req.getRenter_id());
            int check = pstmt.executeUpdate();
            if(check > 0) {
                result = true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageRequest.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
    
    public boolean updateStatus(String status) {
        boolean result = false;
        String sql = "update requests set req_status=? where req_id=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, status);
            pstmt.setInt(2, req.getId());
            int check = pstmt.executeUpdate();
            if(check > 0) {
                result = true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageRequest.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
    
    public boolean deleteRequest(int req_id) {
        boolean result = false;
        String sql = "delete from requests where req_id=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, req_id);
            int check = pstmt.executeUpdate();
            if(check > 0) {
                result = true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageRequest.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
}
