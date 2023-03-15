/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;
import Model.RoleRequest;
import java.util.List;

/**
 *
 * @author aisy
 */
public interface RoleRequestDao {
    
    void saveRoleRequest(RoleRequest roleRequest);
    
    List<RoleRequest> findByRoleId(Integer roleId);
    
    void approveRequest(Integer requestId, Integer personInChargeId);
    
    void assignDirector(Integer userId);
    
    void assignCommittee(Integer userId);
    
    void assignLecturer(Integer userId);
    
    void rejectRequest(Integer requestId, Integer personInChargeId);
    
    String findStatusByUserId(Integer userId);
    
}
