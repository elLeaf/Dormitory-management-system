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
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Dorm;

/**
 *
 * @author anst_
 */
public class ManageDorm {
    
    private Connection conn;
    private Dorm dorm;
    private ArrayList<Dorm> allDorm;
    
    public ManageDorm(Connection conn) {
        this.conn = conn;
        dorm = new Dorm();
        allDorm = new ArrayList<Dorm>();
    }
    
    public boolean setDorm(int dorm_id) {
        boolean result = false;
        String sql = "select * from dorms where dorm_id=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, dorm_id);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                dorm.setId(dorm_id);
                dorm.setName(rs.getString("dorm_name"));
                dorm.setElect_rate(rs.getDouble("elect_rate"));
                dorm.setWater_rate(rs.getDouble("water_rate"));
                dorm.setPhone(rs.getString("dorm_phone"));
                result = true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageDorm.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
    
    public Dorm getDorm() {
        return dorm;
    }
    
    public boolean createDorm(Dorm dorm) {
        boolean result = false;
        String sql = "insert into dorms(dorm_id, dorm_name, elect_rate, water_rate, dorm_phone) values(null, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dorm.getName());
            pstmt.setDouble(2, dorm.getElect_rate());
            pstmt.setDouble(3, dorm.getWater_rate());
            pstmt.setString(4, dorm.getPhone());
            int check = pstmt.executeUpdate();
            if(check > 0) {
                result = true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageDorm.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
    
    public boolean updateDorm(Dorm dorm) {
        boolean result = false;
        String sql = "update dorms"
                + " set dorm_name=?, elect_rate=?, water_rate=?, dorm_phone=?"
                + " where dorm_id=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, dorm.getName());
            pstmt.setDouble(2, dorm.getElect_rate());
            pstmt.setDouble(3, dorm.getWater_rate());
            pstmt.setString(4, dorm.getPhone());
            pstmt.setInt(5, dorm.getId());
            int check = pstmt.executeUpdate();
            if(check > 0) {
                result = true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageDorm.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
    
    public boolean deleteDorm() {
        boolean result = false;
        String sql = "select room_no, contract_id from dorms"
                + " join rooms"
                + " using (dorm_id)"
                + " join contract"
                + " using (room_no)"
                + " where dorm_id=?"
                + " and contract_status='active'";
        try {
            boolean haveContract = false;
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, dorm.getId());
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                haveContract = false;
                break;
            }
            if(!haveContract){
                sql = "delete from dorms where dorm_id=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, dorm.getId());
                int check = pstmt.executeUpdate();
                if(check > 0) {
                    result = true;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageDorm.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
    
    public ArrayList<Dorm> getDorms() {
        String sql = "select dorm_id, dorm_name, elect_rate, water_rate, dorm_phone, count(room_no) 'c' from dorms "
                + "join rooms"
                + " using(dorm_id)"
                + " group by (dorm_id)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                Dorm d = new Dorm();
                d.setId(rs.getInt("dorm_id"));
                d.setName(rs.getString("dorm_name"));
                d.setElect_rate(rs.getDouble("elect_rate"));
                d.setWater_rate(rs.getDouble("water_rate"));
                d.setPhone(rs.getString("dorm_phone"));
                d.setTotalRoom(rs.getInt("c"));
                allDorm.add(d);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageDorm.class.getName()).log(Level.SEVERE, null, ex);
        }
        return allDorm;
    }
    
}
