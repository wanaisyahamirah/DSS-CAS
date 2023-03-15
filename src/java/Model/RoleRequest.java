/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author aisya
 */
public class RoleRequest {
    private int requestId;
    private int userId;
    private int roleId;
    private String status;
    private int managedBy;

    public RoleRequest() {
    }
    
    public RoleRequest(int requestId, int userId, int roleId, String status, int managedBy) {
        this.requestId = requestId;
        this.userId = userId;
        this.roleId = roleId;
        this.status = status;
        this.managedBy = managedBy;
    }

    public int getRequestId() {
        return requestId;
    }

    public void setRequestId(int requestId) {
        this.requestId = requestId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getManagedBy() {
        return managedBy;
    }

    public void setManagedBy(int managedBy) {
        this.managedBy = managedBy;
    }

    
}
