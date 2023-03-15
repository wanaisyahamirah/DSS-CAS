/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import Model.Participation;
import java.util.List;

/**
 *
 * @author aisy
 */
public interface ParticipationDao {
    
    void save_participation(Participation participation);
    
    List<Participation> getAllByUserId(int userid);
    
}
