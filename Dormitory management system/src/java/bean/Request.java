/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package bean;

/**
 *
 * @author adisorn
 */
public class Request {
    
    private String req_id;
    private String req_title;
    private String req_detail;
    private String req_date;
    private String req_status;
    private String req_type;

    public String getReq_id() {
        return req_id;
    }

    public void setReq_id(String req_id) {
        this.req_id = req_id;
    }
    
    public String getReq_title() {
        return req_title;
    }

    public void setReq_title(String req_title) {
        this.req_title = req_title;
    }

    public String getReq_detail() {
        return req_detail;
    }

    public void setReq_detail(String req_detail) {
        this.req_detail = req_detail;
    }

    public String getReq_date() {
        return req_date;
    }

    public void setReq_date(String req_date) {
        this.req_date = req_date;
    }

    public String getReq_status() {
        return req_status;
    }

    public void setReq_status(String req_status) {
        this.req_status = req_status;
    }

    public String getReq_type() {
        return req_type;
    }

    public void setReq_type(String req_type) {
        this.req_type = req_type;
    }
    
}
