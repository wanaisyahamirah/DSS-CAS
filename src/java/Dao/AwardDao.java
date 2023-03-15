/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import Model.Award;
import Model.AwardWinner;
import java.util.List;

/**
 *
 * @author ariffnorhadi
 */
public interface AwardDao {
    
    void createAward(Award event);
    
    List<Award> find_awards_by_event_id(Integer event_id);
    
    void saveDSS(int awardid, int candidateid, double score);
    
    Award getById(int awarid);
    
    void saveWinner(int awardid, int candidateid);
    
    Integer checkRecordExistByAwardId(int awardid);
    
    Integer getWinnerIdByAwardId(int awardid);
}
