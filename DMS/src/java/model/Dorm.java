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
public class Dorm {
    
    private int id;
    private String name;
    private double elect_rate;
    private double water_rate;
    private String phone;
    private int totalRoom;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getElect_rate() {
        return elect_rate;
    }

    public void setElect_rate(double elect_rate) {
        this.elect_rate = elect_rate;
    }

    public double getWater_rate() {
        return water_rate;
    }

    public void setWater_rate(double water_rate) {
        this.water_rate = water_rate;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getTotalRoom() {
        return totalRoom;
    }

    public void setTotalRoom(int totalRoom) {
        this.totalRoom = totalRoom;
    }
    
    
}
