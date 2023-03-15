/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DaoImpl;

import Dao.EventDao;
import Database.DBConnection;
import Model.Award;
import Model.Event;
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
public class EventDaoImpl implements EventDao {

    private final Connection connection;

    public EventDaoImpl() throws SQLException {
        connection = DBConnection.getConnection();
    }

    @Override
    public void createEvent(Event event) {
        try {
            String mySQLQuery
                    = "INSERT INTO `event` (`eventName`, `eventYear`, `dueDate`, `minCGPA`, `minMerit`, `createdBy`, `status`, `dss_status`) VALUES "
                    + "(?, ?, ?, ?, ?, ?, ?, ?)";

            PreparedStatement myPS = connection.prepareStatement(mySQLQuery);

            myPS.setString(1, event.getEventName());
            myPS.setInt(2, event.getEventYear());
            myPS.setString(3, event.getEventDate());
            myPS.setDouble(4, event.getMinCgpa());
            myPS.setInt(5, event.getMinMerit());
            myPS.setInt(6, event.getCreatedBy());
            myPS.setString(7, event.getStatus());
            myPS.setString(8, event.getDss_status());

            myPS.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(EventDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public List<Event> getAllEvents() {
        List<Event> eventlist = new ArrayList<>();

        try {
            String sqlQuery = "select * from event ORDER BY eventYear";
            PreparedStatement stat = connection.prepareStatement(sqlQuery);
            ResultSet rs = stat.executeQuery(sqlQuery);

            while (rs.next()) {
                Event event = new Event();

                event.setEventid(rs.getInt(1));
                event.setEventName(rs.getString(2));
                event.setEventYear(rs.getInt(3));
                event.setEventDate(rs.getString(4));
                event.setMinCgpa(rs.getDouble(5));
                event.setMinMerit(rs.getInt(6));
                event.setStatus(rs.getString(8));
                event.setDss_status(rs.getString(9));
                eventlist.add(event);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        }
        return eventlist;
    }

    @Override
    public ArrayList<Award> getAllAwardByEventId(Integer eventid) {

        ArrayList<Award> awardlist = new ArrayList();

        try {
            String sqlQuery = "select * from award where event_id=?";
            PreparedStatement stat = connection.prepareStatement(sqlQuery);
            ResultSet rs = stat.executeQuery(sqlQuery);

            while (rs.next()) {
                Award award = new Award();

                award.setEvent_id(rs.getInt(eventid));

                awardlist.add(award);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        }
        return awardlist;

    }

    @Override
    public double performDSS(double meritWeightage, double cgpaWeightage, double intangibleWeightage, double meritMax, double cgpaMax, double intangibleMax, double meritValue, double cgpaValue, double intangibleValue) {

        double cgpa_value = cgpaValue / cgpaMax;
        double merit_value = meritValue / meritMax;
        double intangible_value = intangibleValue / intangibleMax;

        double cgpa_score = cgpa_value * cgpaWeightage;
        double merit_score = merit_value * meritWeightage;
        double intangible_score = intangible_value * intangibleWeightage;

        double final_score = cgpa_score + merit_score + intangible_score;

        return final_score * 100;
    }

    @Override
    public Event getLiveEvent() {

        Event event = new Event();

        try {
            String sqlQuery = "select * from event where status='LIVE'";
            PreparedStatement ps = connection.prepareStatement(sqlQuery);
            ResultSet rs = ps.executeQuery(sqlQuery);

            while (rs.next()) {
                event.setEventid(rs.getInt(1));
                event.setEventName(rs.getString(2));
                event.setEventYear(rs.getInt(3));
                event.setEventDate(rs.getString(4));
                event.setMinCgpa(rs.getDouble(5));
                event.setMinMerit(rs.getInt(6));
                event.setCreatedBy(rs.getInt(7));
                event.setStatus(rs.getString(8));
                event.setDss_status(rs.getString(9));
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        }
        return event;
    }

    @Override
    public void updateEventStatusToLive(int eventid) {
        try {
            String myQ = "UPDATE event SET status='LIVE' WHERE eventid=" + eventid;

            PreparedStatement myPS = connection.prepareStatement(myQ);

            myPS.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    @Override
    public void updateEventStatusToCompleted(int eventid) {
        try {
            String myQ = "UPDATE event SET status='COMPLETED' WHERE eventid=" + eventid;

            PreparedStatement myPS = connection.prepareStatement(myQ);

            myPS.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    @Override
    public void updateEventDSSStatus(int eventid, String status) {
        try {
            String myQ = "UPDATE event SET dss_status='" + status + "' WHERE eventid=" + eventid;

            PreparedStatement myPS = connection.prepareStatement(myQ);

            myPS.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    @Override
    public List<Event> getCompletedEvent() {
        List<Event> eventlist = new ArrayList<>();
        try {
            String sqlQuery = "select * from event where status='COMPLETED'";
            PreparedStatement ps = connection.prepareStatement(sqlQuery);
            ResultSet rs = ps.executeQuery(sqlQuery);

            while (rs.next()) {
                Event event = new Event();

                event.setEventid(rs.getInt(1));
                event.setEventName(rs.getString(2));
                event.setEventYear(rs.getInt(3));
                event.setEventDate(rs.getString(4));
                event.setMinCgpa(rs.getDouble(5));
                event.setMinMerit(rs.getInt(6));
                event.setStatus(rs.getString(8));
                event.setDss_status(rs.getString(9));
                eventlist.add(event);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        }
        return eventlist;
    }

    @Override
    public Integer getNumberOfRecordByEventStatus(String status) {
        int record = 0;
        ResultSet rs = null;
        try {
            String mySQLQuery = "select count(1) from event where status=?";
            PreparedStatement ps = connection.prepareStatement(mySQLQuery);

            ps.setString(1, status);
            rs = ps.executeQuery();

            while (rs.next()) {
                record = rs.getInt(1);
            }
            connection.close();

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(EventDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(EventDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return record;
    }

    @Override
    public Integer getPercentageByColumnNameAndEventId(String columnName, Integer event_id) {
        int percentage = 0;
        ResultSet rs = null;
        try {
            String mySQLQuery = "select " + columnName + " from criteria where event_id=" + event_id;
            PreparedStatement ps = connection.prepareStatement(mySQLQuery);

//            ps.setString(1, columnName);
            rs = ps.executeQuery();

            while (rs.next()) {
                percentage = rs.getInt(1);
            }
            connection.close();

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(EventDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(EventDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return percentage;
    }

    @Override
    public void updateEventWeightage(int merit_percentage, int cgpa_percentage, int intangible_percentage, int event_id) {
        try {
            String myQ = "UPDATE criteria SET merit='" + merit_percentage + "', cgpa='" + cgpa_percentage + "', intangible='" + intangible_percentage + "'  WHERE event_id=" + event_id;
            PreparedStatement myPS = connection.prepareStatement(myQ);

            myPS.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

}
