/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DaoImpl;

import Dao.AwardDao;
import Database.DBConnection;
import Model.Award;
import Model.AwardWinner;
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
 * @author ariffnorhadi
 */
public class AwardDaoImpl implements AwardDao {

    private final Connection connection;

    public AwardDaoImpl() throws SQLException {
        connection = DBConnection.getConnection();
    }

    @Override
    public void createAward(Award award) {
        try {
            String mySQLQuery
                    = "INSERT INTO `award` (`award_name`, `year_criteria`, `program_criteria`, `gender_criteria`, `event_id`, `created_by`) VALUES "
                    + "(?, ?, ?, ?, ?, ?)";

            PreparedStatement myPS = connection.prepareStatement(mySQLQuery);

            myPS.setString(1, award.getAward_name());
            myPS.setString(2, award.getYear_criteria());
            myPS.setString(3, award.getProgram_criteria());
            myPS.setString(4, award.getGender_criteria());
            myPS.setInt(5, award.getEvent_id());
            myPS.setInt(6, award.getCreated_by());

            myPS.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(AwardDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public List<Award> find_awards_by_event_id(Integer event_id) {
        List<Award> awardList = new ArrayList<>();

        try {
            String sqlQuery = "select * from award where event_id =" + event_id;
            PreparedStatement stat = connection.prepareStatement(sqlQuery);
            ResultSet rs = stat.executeQuery(sqlQuery);

            while (rs.next()) {
                Award award = new Award();

                award.setAward_id(rs.getInt(1));
                award.setAward_name(rs.getString(2));
                award.setYear_criteria(rs.getString(3));
                award.setProgram_criteria(rs.getString(4));
                award.setGender_criteria(rs.getString(5));
                award.setCreated_by(rs.getInt(7));
                award.setLast_updated_by(rs.getInt(8));

                awardList.add(award);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        }
        return awardList;
    }

    @Override
    public void saveDSS(int awardid, int candidateid, double score) {
        try {
            String mySQLQuery
                    = "INSERT INTO `award_nominee` (`awardid`, `nomineeid`, `score`) VALUES "
                    + "(?, ?, ?)";

            PreparedStatement myPS = connection.prepareStatement(mySQLQuery);

            myPS.setInt(1, awardid);
            myPS.setInt(2, candidateid);
            myPS.setDouble(3, score);

            myPS.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(AwardDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public Award getById(int awardid) {
        
        Award award = new Award();
        
        try {    
            String sqlQuery = "select * from award where award_id =" + awardid;
            PreparedStatement stat = connection.prepareStatement(sqlQuery);
            ResultSet rs = stat.executeQuery(sqlQuery);

            while (rs.next()) {
                award.setAward_id(rs.getInt(1));
                award.setAward_name(rs.getString(2));
                award.setYear_criteria(rs.getString(3));
                award.setProgram_criteria(rs.getString(4));
                award.setGender_criteria(rs.getString(5));
                award.setCreated_by(rs.getInt(7));
                award.setLast_updated_by(rs.getInt(8));
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        }
        
        return award;
    }

    @Override
    public void saveWinner(int awardid, int candidateid) {
        try {
            String mySQLQuery
                    = "INSERT INTO `award_winner` (`awardid`, `candidateid`) VALUES "
                    + "(?, ?)";

            PreparedStatement myPS = connection.prepareStatement(mySQLQuery);

            myPS.setInt(1, awardid);
            myPS.setInt(2, candidateid);

            myPS.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(AwardDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public Integer checkRecordExistByAwardId(int awardid) {
        int number_of_record = 0;
        ResultSet rs = null;
        try {
            String mySQLQuery = "select count(1) from award_winner where awardid=?";
            PreparedStatement ps = connection.prepareStatement(mySQLQuery);

            ps.setInt(1, awardid);
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
                    Logger.getLogger(AwardDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(AwardDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return number_of_record;
    }

    @Override
    public Integer getWinnerIdByAwardId(int awardid) {
        
        int winnerid = 0;
        try {
            String sqlQuery = "select candidateid from award_winner where awardid =" + awardid;
            PreparedStatement stat = connection.prepareStatement(sqlQuery);
            ResultSet rs = stat.executeQuery(sqlQuery);

            while (rs.next()) {
                winnerid = rs.getInt(1);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        }
        return winnerid;
    }

}
