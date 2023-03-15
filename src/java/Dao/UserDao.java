/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import Model.User;
import java.util.List;

/**
 *
 * @author aisya
 */
public interface UserDao {
    
    boolean verifyNumberExistence(String password);

    boolean verifyLowerCaseExistence(String password);

    boolean verifyUpperCasesExistence(String password);

    boolean verifyEightCharactersPassword(String password);

    boolean verifyRepeatedPassword(String password, String rePassword);
    
    void registerCandidate(User user);
    
    void registerDirectorInfo(User user);
    
    void registerLecturerInfo(User user);
    
    Integer getUserIdByUsername(String username);
    
    Integer getLastUserIdInDB();
    
    User authenticateUser(String username, String password);
    
    User authenticateUserWithID(String id, String password);
    
    User findById(Integer userId);
    
    Integer findRoleByUserId(Integer userId);
    
    String getRoleRequestStatusByUserId(Integer userId);
    
    List<Integer> findUsersByRoleId(Integer roleId);
    
    Integer getNumberOfRecordByUsername(String username);
    
    List<Integer> getAllUserIdByRoleId(Integer roleId);
    
    Integer getNumberOfRecordByYearAndGender(int roleid, int year, String gender);
    
    Integer getNumberOfRecordByProgramAndGender(int roleid, String program, String gender);
    
    Integer getNumberOfRecordByGender(int roleid, String gender);
    
    Integer getMeritByUserId(Integer userid);
    
    Double getCGPAByUserId(Integer userid);
}
