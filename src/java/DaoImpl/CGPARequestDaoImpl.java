/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DaoImpl;

import Dao.CGPARequestDao;
import Database.DBConnection;
import Model.CGPARequest;
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
public class CGPARequestDaoImpl implements CGPARequestDao {

    private final Connection connection;

    public CGPARequestDaoImpl() throws SQLException {
        connection = DBConnection.getConnection();
    }

    @Override
    public void createRequest(CGPARequest request) {
        try {
            String mySQLQuery = "insert into cgpa_request (requestid, userid, cgpa, status, evidence, managedBy) values(NULL, ?, ?, ?, ?, NULL)";

            PreparedStatement myPS = connection.prepareStatement(mySQLQuery);

            myPS.setInt(1, request.getUser_id());
            myPS.setDouble(2, request.getCgpa());
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
            Logger.getLogger(CGPARequestDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(CGPARequestDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public List<CGPARequest> listPendingCGPARequest() {
        List<CGPARequest> requestList = new ArrayList<>();

        try {
            String sqlQuery = "SELECT * FROM `cgpa_request` where status='PENDING'";
            PreparedStatement stat = connection.prepareStatement(sqlQuery);
            ResultSet rs = stat.executeQuery(sqlQuery);

            while (rs.next()) {
                CGPARequest request = new CGPARequest();
                request.setRequest_id(rs.getInt(1));
                request.setUser_id(rs.getInt(2));
                request.setCgpa(rs.getDouble(3));
                request.setStatus(rs.getString(4));

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
            String myQ = "UPDATE `cgpa_request` SET status='APPROVED', managedBy=? WHERE requestid=?";

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
                Logger.getLogger(CGPARequestDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public void rejectRequest(Integer requestId, Integer userId) {
        try {
            String myQ = "UPDATE `cgpa_request` SET status='REJECTED', managedBy=? WHERE requestid=?";

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
                Logger.getLogger(CGPARequestDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public ArrayList<Integer> getAllUserIdByApprovedStatus() {
        ArrayList<Integer> listid = new ArrayList<>();

        try {
            String sqlQuery = "SELECT distinct userid FROM `cgpa_request` where status='APPROVED'";
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
    public void updateCGPA(double cgpaValue, int userid) {
        
        try {
            String myQ = "UPDATE `user` SET cgpa=? WHERE userid=?";

            PreparedStatement myPS = connection.prepareStatement(myQ);

            myPS.setDouble(1, cgpaValue);
            myPS.setInt(2, userid);

            myPS.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(CGPARequestDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public Integer getNumberOfRecordByUserId(int userid) {
        int number_of_record = 0;
        ResultSet rs = null;
        try {
            String mySQLQuery = "select count(1) from cgpa_request where userid=?";
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
                    Logger.getLogger(CGPARequestDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(CGPARequestDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return number_of_record;
    }

}
