/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Dao;

import Model.Rating;

/**
 *
 * @author aisy
 */
public interface RatingDao {
    
    Integer getNumberOfRecordByUserid(Integer userId);
    
    void submitRating(Rating registerRating);
    
    Double averageRatingScore(int userid);
    
    Double getScore(int userid, int intangibleid);
}
