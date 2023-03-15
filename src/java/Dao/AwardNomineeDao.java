/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import Model.AwardNominee;
import java.util.List;

/**
 *
 * @author aisy
 */
public interface AwardNomineeDao {
    
    List<AwardNominee> getAllByAwardId(int awardid);
    
    Double getScoreByAwardIdNomineeId(int awardid, int nomineeid);
    
    List<AwardNominee> getDetailsByAwardId(int awardid);
    
    Integer getNumberOfRecordByUserId(Integer userid);
}
