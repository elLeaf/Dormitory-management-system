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
import model.Employee;

/**
 *
 * @author anst_
 */
public class ManageEmployee {
    
    private Connection conn;
    private Employee emp;
    
    public ManageEmployee(Connection conn) {
        this.conn = conn;
        emp = new Employee();
    }
    
    public boolean setEmp(int emp_id) {
        boolean result = false;
        String sql = "select * from employees where emp_id=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, emp_id);
            ResultSet rs = pstmt.executeQuery();
            while(rs.next()) {
                emp.setId(emp_id);
                emp.setFname(rs.getString("fname"));
                emp.setLname(rs.getString("lname"));
                emp.setGender(rs.getString("gender"));
                emp.setPhone(rs.getString("phone"));
                emp.setAge(rs.getInt("age"));
                emp.setSalary(rs.getDouble("salary"));
                emp.setPosition(rs.getString("position"));
                emp.setDorm_id(rs.getInt("dorm_id"));
                result = true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageEmployee.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
    
    public Employee getEmp() {
        return emp;
    }
    
    public boolean createEmployee(Employee emp) {
        boolean result = false;
        String sql1 = "insert into users values(?, ?, ?)";
        String sql2 = "insert into employees (emp_id, fname, lname, gender, age, phone, salary, position, username, dorm_id) "
                + "values(null, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql1);
            pstmt.setString(1, emp.getUsername());
            pstmt.setString(2, emp.getPassword());
            pstmt.setString(3, emp.getRole());
            int check1 = pstmt.executeUpdate();
            
            pstmt = conn.prepareStatement(sql2);
            pstmt.setString(1, emp.getFname());
            pstmt.setString(2, emp.getLname());
            pstmt.setString(3, emp.getGender());
            pstmt.setInt(4, emp.getAge());
            pstmt.setString(5, emp.getPhone());
            pstmt.setDouble(6, emp.getSalary());
            pstmt.setString(7, emp.getPosition());
            pstmt.setString(8, emp.getUsername());
            pstmt.setInt(9, emp.getDorm_id());
            int check2 = pstmt.executeUpdate();
            
            if(check1 > 0 && check2 > 0) {
                result = true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageEmployee.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
    
    public boolean updateEmployee(Employee emp) {
        boolean result = false;
        String sql = "update employees set fname=?, lname=?, gender=?, age=?, phone=?, salary=?, position=? where emp_id=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, emp.getFname());
            pstmt.setString(2, emp.getLname());
            pstmt.setString(3, emp.getGender());
            pstmt.setInt(4, emp.getAge());
            pstmt.setString(5, emp.getPhone());
            pstmt.setDouble(6, emp.getSalary());
            pstmt.setString(7, emp.getPosition());
            pstmt.setInt(8, emp.getId());
            int check = pstmt.executeUpdate();
            if(check > 0) {
                result = true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(ManageEmployee.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
    
    public boolean deleteEmployee(int emp_id) {
        boolean result = false;
        String sql = "select username from users join employees using(username) where emp_id=?";
        try {
            PreparedStatement pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, emp_id);
            ResultSet rs = pstmt.executeQuery();
            String username = "";
            while(rs.next()) {
                username = rs.getString("username");
            }
            sql = "delete from users where username=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            int check = pstmt.executeUpdate();
            if(check > 0) {
                result = true;
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(ManageEmployee.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
    }
    
}
