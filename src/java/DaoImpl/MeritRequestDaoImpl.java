/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DaoImpl;

import Dao.MeritRequestDao;
import Database.DBConnection;
import Model.MeritRequest;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.http.Part;

/**
 *
 * @author aisy
 */
public class MeritRequestDaoImpl implements MeritRequestDao {

    private final Connection connection;

    public MeritRequestDaoImpl() throws SQLException {
        connection = DBConnection.getConnection();
    }

    @Override
    public void createRequest(MeritRequest request) {
        try {
            String mySQLQuery = "insert into merit_request (requestid, userid, merit, status, evidence, managedBy) values(NULL, ?, ?, ?, ?, NULL)";

            PreparedStatement myPS = connection.prepareStatement(mySQLQuery);

            myPS.setInt(1, request.getUser_id());
            myPS.setInt(2, request.getMerit_value());
            myPS.setString(3, "PENDING");

            Part filePart = request.getEvidence();
            InputStream inputStream = null;

            if (filePart != null) {
                // obtains input stream of the upload file
                inputStream = filePart.getInputStream();
            }

            if (inputStream != null) {
                // fetches input stream of the upload file for the blob column
                myPS.setBlob(4, inputStream);
            }

            myPS.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } catch (IOException ex) {
            Logger.getLogger(MeritRequestDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(MeritRequestDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public List<MeritRequest> listPendingMeritRequest() {
        List<MeritRequest> requestList = new ArrayList<>();
        
        try {
            String sqlQuery = "SELECT * FROM `merit_request` where status='PENDING'";
            PreparedStatement stat = connection.prepareStatement(sqlQuery);
            ResultSet rs = stat.executeQuery(sqlQuery);

            while (rs.next()) {
                MeritRequest request = new MeritRequest();
                request.setRequest_id(rs.getInt(1));
                request.setUser_id(rs.getInt(2));
                request.setMerit_value(rs.getInt(3));
                request.setRequest_status(rs.getString(4));

                requestList.add(request);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        }

        return requestList;
    }

    @Override
    public void approveRequest(Integer requestId, Integer userId) {
        try {
            String myQ = "UPDATE `merit_request` SET status='APPROVED', managedBy=? WHERE requestid=?";

            PreparedStatement myPS = connection.prepareStatement(myQ);

            myPS.setInt(1, userId);
            myPS.setInt(2, requestId);

            myPS.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(MeritRequestDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public void rejectRequest(Integer requestId, Integer userId) {
        try {
            String myQ = "UPDATE `merit_request` SET status='REJECTED', managedBy=? WHERE requestid=?";

            PreparedStatement myPS = connection.prepareStatement(myQ);

            myPS.setInt(1, userId);
            myPS.setInt(2, requestId);

            myPS.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(MeritRequestDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public ArrayList<Integer> getAllUserIdByApprovedStatus() {
        ArrayList<Integer> listid = new ArrayList<>();

        try {
            String sqlQuery = "SELECT distinct userid FROM `merit_request` where status='APPROVED'";
            PreparedStatement stat = connection.prepareStatement(sqlQuery);
            ResultSet rs = stat.executeQuery(sqlQuery);

            while (rs.next()) {
                int userid = rs.getInt(1);
                listid.add(userid);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        }

        return listid;
    }

    @Override
    public void updateMerit(int meritValue, int candidateid) {
        try {
            String myQ = "UPDATE `user` SET merit=? WHERE userid=?";

            PreparedStatement myPS = connection.prepareStatement(myQ);

            myPS.setInt(1, meritValue);
            myPS.setInt(2, candidateid);

            myPS.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(MeritRequestDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public Integer getNumberOfRecordByUserId(int userid) {
        int number_of_record = 0;
        ResultSet rs = null;
        try {
            String mySQLQuery = "select count(1) from merit_request where userid=?";
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
                    Logger.getLogger(MeritRequestDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(MeritRequestDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return number_of_record;
    }

}
