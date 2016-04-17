/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author anst_
 */
public class Room {
    
    private int number;
    private double charge;
    private int floor;
    private String status;
    private int dorm_id;
    private int air;
    private int fan;

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        this.number = number;
    }

    public double getCharge() {
        return charge;
    }

    public void setCharge(double charge) {
        this.charge = charge;
    }

    public int getFloor() {
        return floor;
    }

    public void setFloor(int floor) {
        this.floor = floor;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getDorm_id() {
        return dorm_id;
    }

    public void setDorm_id(int dorm_id) {
        this.dorm_id = dorm_id;
    }
    
    public int getAir() {
        return air;
    }

    public void setAir(int air) {
        this.air = air;
    }

    public int getFan() {
        return fan;
    }

    public void setFan(int fan) {
        this.fan = fan;
    }
    
}
