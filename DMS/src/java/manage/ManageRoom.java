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
import model.Room;

/**
 *
 * @author anst_
 */
public class ManageRoom {
    
    private Connection conn;
    private Room room;
    
    public ManageRoom(Connection conn) {
        this.conn = conn;
        room = new Room();
    }
    
    public boolean setRoom(int room_no) {
        boolean result = false;
        String sql = "select * from rooms join room_detail using(room_no) where room_no=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, room_no);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                room.setNumber(room_no);
                room.setCharge(rs.getDouble("room_charge"));
                room.setFloor(rs.getInt("room_floor"));
                room.setStatus(rs.getString("room_status"));
                room.setAir(rs.getInt("air"));
                room.setFan(rs.getInt("fan"));
                room.setDorm_id(rs.getInt("dorm_id"));
                result = true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageDorm.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
    
    public ArrayList<Room> getAllRoom(int dorm_id) {
        String sql = "select * from rooms join room_detail using(room_no) where dorm_id=?";
        ArrayList<Room> rooms = new ArrayList<Room>();
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, dorm_id);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                Room r = new Room();
                r.setNumber(rs.getInt("room_no"));
                r.setCharge(rs.getDouble("room_charge"));
                r.setFloor(rs.getInt("room_floor"));
                r.setStatus(rs.getString("room_status"));
                r.setAir(rs.getInt("air"));
                r.setFan(rs.getInt("fan"));
                r.setDorm_id(dorm_id);
                rooms.add(r);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageDorm.class.getName()).log(Level.SEVERE, null, ex);
        }
        return rooms;
    }
    
    public Room getRoom() {
        return room;
    }
    
    public boolean createRoom(Room room) {
        boolean result = false;
        String sql1 = "insert into rooms values(?, ?, ?, ?, ?)";
        String sql2 =  "insert into room_detail values(?, ?, ?);";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql1);
            pstmt.setInt(1, room.getNumber());
            pstmt.setDouble(2, room.getCharge());
            pstmt.setInt(3, room.getFloor());
            pstmt.setString(4, room.getStatus());
            pstmt.setInt(5, room.getDorm_id()); 
            int check1 = pstmt.executeUpdate();
            
            pstmt = conn.prepareStatement(sql2);
            pstmt.setInt(1, room.getNumber());
            pstmt.setInt(2, room.getAir());
            pstmt.setInt(3, room.getFan());
            int check2 = pstmt.executeUpdate();
            
            if(check1 > 0 && check2 > 0) {
                result = true;
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(ManageDorm.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
    
    public boolean updateRoom(Room room) {
        boolean result = false;
        String sql1 = "update rooms"
                + " set room_charge=?, room_floor=?, room_status=?"
                + " where room_no=?";
        String sql2 = "update room_detail set air=?, fan=? where room_no=?;";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql1);
            pstmt.setDouble(1, room.getCharge());
            pstmt.setInt(2, room.getFloor());
            pstmt.setString(3,room.getStatus());
            pstmt.setInt(4,room.getNumber());
            int check1 = pstmt.executeUpdate();
            
            pstmt = conn.prepareStatement(sql2);
            pstmt.setInt(1, room.getAir());
            pstmt.setInt(2, room.getFan());
            pstmt.setInt(3, room.getNumber());
            int check2 = pstmt.executeUpdate();
            if(check1 > 0 && check2 > 0) {
                result = true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageDorm.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
    
    public boolean setStatus(String status) {
        boolean result = false;
        String sql = "update rooms set room_status=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, status);
            int check = pstmt.executeUpdate();
            if(check > 0) {
                result = true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageRoom.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
    
    public boolean deleteRoom(int room_no) {
        boolean result = false;
        String sql1 = "delete from room_detail where room_no=?";
        String sql2 = "delete from rooms where room_no=?";
        String sqlCheck = "select room_no, contract_id from dorms"
                + " join rooms"
                + " using (dorm_id)"
                + " join contract"
                + " using (room_no)"
                + " where room_no=?"
                + " and contract_status='active'";
        try {
            boolean haveContract = false;
            PreparedStatement pstmt = conn.prepareStatement(sqlCheck);
            pstmt.setInt(1, room_no);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                haveContract = false;
                break;
            }
            if(!haveContract){
                pstmt = conn.prepareStatement(sql1);
                pstmt.setInt(1, room_no);
                int check1 = pstmt.executeUpdate();
                
                pstmt = conn.prepareStatement(sql2);
                pstmt.setInt(1, room_no);
                int check2 = pstmt.executeUpdate();
                if(check1 > 0 && check2 > 0) {
                    result = true;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageDorm.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
}
