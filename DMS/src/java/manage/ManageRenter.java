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
import model.Contract;
import model.Renter;

/**
 *
 * @author anst_
 */
public class ManageRenter {
    
    private Connection conn;
    private Renter renter;
    
    public ManageRenter(Connection conn) {
        this.conn = conn;
        renter = new Renter();
    }
    
    public boolean setRenter(int renter_id) {
        boolean result = false;
        String sql = "select * from renters where renter_id=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, renter_id);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                renter.setId(renter_id);
                renter.setFname(rs.getString("fname"));
                renter.setLname(rs.getString("lname"));
                renter.setGender(rs.getString("gender"));
                renter.setAge(rs.getInt("age"));
                renter.setCareer(rs.getString("carreer"));
                renter.setPhone(rs.getString("phone"));
                renter.setUsername(rs.getString("username"));
                sql = "select * from users where username=?";
                pstmt = conn.prepareStatement(sql);
                rs = pstmt.executeQuery();
                while(rs.next()) {
                    renter.setPassword(rs.getString("password"));
                    renter.setRole(rs.getString("role"));
                }
                result = true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageRenter.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        return result;
    }
    
    public Renter getRenter() {
        return renter;
    }
    
    public boolean createRenter(Renter renter, Contract  contract) {
        boolean result = false;
        String sql1 = "insert into users values(?, ?, ?)";
        String sql2 = "insert into renters values(null, ?, ?, ?, ?, ?, ?, ?)";
        String sql3 = "insert into contract values(null, ?, ?, curdate(), ?, 'เช่า', ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql1);
            pstmt.setString(1, renter.getUsername());
            pstmt.setString(2, renter.getPassword());
            pstmt.setString(3, renter.getRole());
            int check1 = pstmt.executeUpdate();
            
            pstmt = conn.prepareStatement(sql2);
            pstmt.setString(1, renter.getFname());
            pstmt.setString(2, renter.getLname());
            pstmt.setString(3, renter.getGender());
            pstmt.setInt(4, renter.getAge());
            pstmt.setString(5, renter.getPhone());
            pstmt.setString(6, renter.getCareer());
            pstmt.setString(7, renter.getUsername());
            int check2 = pstmt.executeUpdate();
            
            pstmt = conn.prepareStatement(sql3);
            pstmt.setInt(1, contract.getRoom_no());
            pstmt.setInt(2, contract.getRenter_id());
            pstmt.setDate(3, contract.getEnd_date());
            pstmt.setDouble(4, contract.getDeposit());
            int check3 = pstmt.executeUpdate();
            
            if(check1 > 0 && check2 > 0 && check3 > 0) {
                result = true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageRenter.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
    
}
