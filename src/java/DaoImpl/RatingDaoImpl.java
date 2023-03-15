/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DaoImpl;

import Dao.RatingDao;
import Database.DBConnection;
import Model.Rating;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author aisy
 */
public class RatingDaoImpl implements RatingDao {
    
    private final Connection connection;

    public RatingDaoImpl() throws SQLException {
        connection = DBConnection.getConnection();
    }

    @Override
    public Integer getNumberOfRecordByUserid(Integer userid) {
        int number_of_record = 0;
        ResultSet rs = null;
        try {
            String mySQLQuery = "select count(1) from rating where candidate_id=?";
            PreparedStatement ps = connection.prepareStatement(mySQLQuery);

            ps.setInt(1, userid);
            rs = ps.executeQuery();

            while (rs.next()) {
                number_of_record = rs.getInt(1);
            }
            connection.close();

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RatingDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(RatingDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return number_of_record;
    }

    @Override
    public void submitRating(Rating registerRating) {
        
        try {
            
            String mySQLQuery
                    = "INSERT INTO `rating` (`candidate_id`, `lecturer_id`, `intangible_id`, `score`) VALUES "
                    + "(?, ?, ?, ?)";

            PreparedStatement myPS = connection.prepareStatement(mySQLQuery);

            
            myPS.setInt(1, registerRating.getCandidate_id());
            myPS.setInt(2, registerRating.getLecturer_id());
            myPS.setInt(3, registerRating.getIntangible_id());
            myPS.setInt(4, registerRating.getScore());

            myPS.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(RatingDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public Double averageRatingScore(int userid) {
        
        double score=0.0;
        ResultSet rs = null;
        try {
            String mySQLQuery = "SELECT AVG(score) from rating where candidate_id=?";
            PreparedStatement ps = connection.prepareStatement(mySQLQuery);

            ps.setInt(1, userid);
            rs = ps.executeQuery();

            while (rs.next()) {
                score = rs.getInt(1);
            }
            connection.close();

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RatingDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(RatingDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return score;
    }

    @Override
    public Double getScore(int intagible_id, int candidate_id) {
        double score=0.0;
        ResultSet rs = null;
        try {
            String mySQLQuery = "SELECT AVG(score) from rating where candidate_id=" +candidate_id+ " AND intangible_id=" +intagible_id ;
            PreparedStatement ps = connection.prepareStatement(mySQLQuery);

            rs = ps.executeQuery();

            while (rs.next()) {
                score = rs.getInt(1);
            }
            connection.close();

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RatingDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(RatingDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return score;
    }

    
    
}
