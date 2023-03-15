/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DaoImpl;

import Dao.AwardNomineeDao;
import Database.DBConnection;
import Model.AwardNominee;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author aisy
 */
public class AwardNomineeDaoImpl implements AwardNomineeDao {
    
    private final Connection connection;

    public AwardNomineeDaoImpl() throws SQLException {
        connection = DBConnection.getConnection();
    }

    @Override
    public List<AwardNominee> getAllByAwardId(int awardid) {
        List<AwardNominee> nomineeList = new ArrayList<>();

        try {
            //select * from (select nomineeid,score from award_nominee order by score desc,nomineeid asc limit 3) award_nominee order by score;
            String sqlQuery = "select nomineeid, score from award_nominee where awardid=" +awardid+ " order by score desc limit 3 ";
            PreparedStatement stat = connection.prepareStatement(sqlQuery);
            ResultSet rs = stat.executeQuery(sqlQuery);

            while (rs.next()) {
                AwardNominee nominee = new AwardNominee();
                
                nominee.setNomineeid(rs.getInt(1));
                nominee.setScore(rs.getDouble(2));

                nomineeList.add(nominee);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        }

        return nomineeList;
    }

    @Override
    public Double getScoreByAwardIdNomineeId(int awardid, int nomineeid) {
        
        double score = 0.0;
        try {
            String sqlQuery = "select score from award_nominee where awardid=" +awardid+ " AND nomineeid=" +nomineeid;
            PreparedStatement stat = connection.prepareStatement(sqlQuery);
            ResultSet rs = stat.executeQuery(sqlQuery);

            while (rs.next()) {
                score = rs.getDouble(1);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        }

        return score;
    }

    @Override
    public List<AwardNominee> getDetailsByAwardId(int awardid) {
        List<AwardNominee> nomineeList = new ArrayList<>();

        try {
            //select * from (select nomineeid,score from award_nominee order by score desc,nomineeid asc limit 3) award_nominee order by score;
            String sqlQuery = "select nomineeid,score from award_nominee where awardid=" +awardid+ " order by score desc";
            PreparedStatement stat = connection.prepareStatement(sqlQuery);
            ResultSet rs = stat.executeQuery(sqlQuery);

            while (rs.next()) {
                AwardNominee nominee = new AwardNominee();
                
                nominee.setNomineeid(rs.getInt(1));
                nominee.setScore(rs.getDouble(2));

                nomineeList.add(nominee);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        }

        return nomineeList;
    }

    @Override
    public Integer getNumberOfRecordByUserId(Integer userid) {
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
                    Logger.getLogger(UserDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(UserDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return number_of_record;
    }
    
}
