/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import Model.MeritRequest;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author aisy
 */
public interface MeritRequestDao {
    
    void createRequest(MeritRequest request);
    
    List<MeritRequest> listPendingMeritRequest();
    
    void approveRequest(Integer requestId, Integer personInChargeId);
    
    void rejectRequest(Integer requestId, Integer personInChargeId);
    
    ArrayList<Integer> getAllUserIdByApprovedStatus();
    
    void updateMerit(int meritValue, int userid);
    
    Integer getNumberOfRecordByUserId(int userid);
}
