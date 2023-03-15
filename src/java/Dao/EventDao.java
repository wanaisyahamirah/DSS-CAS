/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import Model.Award;
import Model.Event;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author aisy
 */
public interface EventDao {
    
    void createEvent(Event event);
    
    List<Event> getAllEvents();
    
    ArrayList<Award> getAllAwardByEventId(Integer eventid);
    
    double performDSS
        (   double meritWeightage,double cgpatWeightage, 
            double intangibleWeightage, double meritMax, double cgpaMax, 
            double intangibleMax, double meritScore,double cgpaScore, 
            double ratingScore
        );
        
    Event getLiveEvent();
    
    List<Event> getCompletedEvent();
    
    void updateEventStatusToLive(int eventid);
    
    void updateEventStatusToCompleted(int eventid);
    
    void updateEventDSSStatus(int eventid, String status);
    
    Integer getNumberOfRecordByEventStatus(String status);
    
    Integer getPercentageByColumnNameAndEventId(String columnName, Integer event_id);
    
    void updateEventWeightage(int merit_percentage, int cgpa_percentage, int intangible_percentage, int event_id);
}
