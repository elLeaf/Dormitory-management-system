/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Date;

/**
 *
 * @author anst_
 */
public class Contract {
    
    private int id;
    private int room_no;
    private int renter_id;
    private int status;
    private Date end_date;
    private double deposit;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getRoom_no() {
        return room_no;
    }

    public void setRoom_no(int room_no) {
        this.room_no = room_no;
    }

    public int getRenter_id() {
        return renter_id;
    }

    public void setRenter_id(int renter_id) {
        this.renter_id = renter_id;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Date getEnd_date() {
        return end_date;
    }

    public void setEnd_date(Date end_date) {
        this.end_date = end_date;
    }

    public double getDeposit() {
        return deposit;
    }

    public void setDeposit(double deposit) {
        this.deposit = deposit;
    }
    
    
    
}
