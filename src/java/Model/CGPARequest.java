/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import javax.servlet.http.Part;

/**
 *
 * @author aisy
 */
public class CGPARequest {
    
    private int request_id;
    private int user_id;
    private double cgpa;
    private String status;
    private Part evidence;
    private int managed_by;

    public CGPARequest() {
    }

    public CGPARequest(int request_id, int user_id, double cgpa, String status, Part evidence, int managed_by) {
        this.request_id = request_id;
        this.user_id = user_id;
        this.cgpa = cgpa;
        this.status = status;
        this.evidence = evidence;
        this.managed_by = managed_by;
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

    public double getCgpa() {
        return cgpa;
    }

    public void setCgpa(double cgpa) {
        this.cgpa = cgpa;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
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
