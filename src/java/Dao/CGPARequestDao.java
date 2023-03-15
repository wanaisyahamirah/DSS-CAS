/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import Model.CGPARequest;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author aisy
 */
public interface CGPARequestDao {
    
    void createRequest(CGPARequest request);
    
    List<CGPARequest> listPendingCGPARequest();
    
    void approveRequest(Integer requestId, Integer personInChargeId);
    
    void rejectRequest(Integer requestId, Integer personInChargeId);
    
    ArrayList<Integer> getAllUserIdByApprovedStatus();
    
    void updateCGPA(double cgpaValue, int userid);
    
    Integer getNumberOfRecordByUserId(int userid);
    
}
