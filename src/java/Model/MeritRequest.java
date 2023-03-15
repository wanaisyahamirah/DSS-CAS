/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import javax.servlet.http.Part;

/**
 *
 * @author ariffnorhadi
 */
public class MeritRequest {

    private int request_id;
    private int user_id;
    private int merit_value;
    private String request_status;
    private Part evidence;
    private int managed_by;

    public MeritRequest() {
    }

    public int getRequest_id() {
        return request_id;
    }

    public void setRequest_id(int request_id) {
        this.request_id = request_id;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public int getMerit_value() {
        return merit_value;
    }

    public void setMerit_value(int merit_value) {
        this.merit_value = merit_value;
    }

    public String getRequest_status() {
        return request_status;
    }

    public void setRequest_status(String request_status) {
        this.request_status = request_status;
    }

    public Part getEvidence() {
        return evidence;
    }

    public void setEvidence(Part evidence) {
        this.evidence = evidence;
    }

    public int getManaged_by() {
        return managed_by;
    }

    public void setManaged_by(int managed_by) {
        this.managed_by = managed_by;
    }

}
