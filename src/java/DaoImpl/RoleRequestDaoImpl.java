/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DaoImpl;

import Database.DBConnection;
import Dao.RoleRequestDao;
import Model.RoleRequest;
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
public class RoleRequestDaoImpl implements RoleRequestDao {

    private final Connection connection;

    public RoleRequestDaoImpl() throws SQLException {
        connection = DBConnection.getConnection();
    }

    @Override
    public void saveRoleRequest(RoleRequest request) {

        //Create model here, then save to database
        try {
            String mySQLQuery = "INSERT INTO `role_request` (`requestid`, `userid`, `roleid`, `status`, `managedBy`) VALUES (NULL, ?, ?, ?, NULL)";

            PreparedStatement myPS = connection.prepareStatement(mySQLQuery);

            myPS.setInt(1, request.getUserId());
            myPS.setInt(2, request.getRoleId());
            myPS.setString(3, request.getStatus());

            myPS.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(RoleRequestDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public List<RoleRequest> findByRoleId(Integer roleId) {
        List<RoleRequest> requestList = new ArrayList<>();

        try {
            String sqlQuery = "SELECT * FROM `role_request` where roleid=" + roleId + " and status='PENDING'";
            PreparedStatement stat = connection.prepareStatement(sqlQuery);
            ResultSet rs = stat.executeQuery(sqlQuery);

            while (rs.next()) {
                RoleRequest request = new RoleRequest();

                request.setRequestId(rs.getInt(1));
                request.setUserId(rs.getInt(2));
                request.setRoleId(rs.getInt(3));
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
            String myQ = "UPDATE `role_request` SET status='APPROVED', managedBy=? WHERE requestid=?";

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
                Logger.getLogger(RoleRequestDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public void rejectRequest(Integer requestId, Integer userId) {
        try {
            String myQ = "UPDATE `role_request` SET status='REJECTED', managedBy=? WHERE requestid=?";

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
                Logger.getLogger(RoleRequestDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public String findStatusByUserId(Integer userId) {

        String status = "";
        RoleRequest roleRequest;
        ResultSet rs = null;
        try {
            String mySQLQuery = "select status from role_request where userid=?";
            PreparedStatement ps = connection.prepareStatement(mySQLQuery);

            ps.setInt(1, userId);

            rs = ps.executeQuery();

            while (rs.next()) {
                roleRequest = new RoleRequest();
                roleRequest.setUserId(userId);
                status = rs.getString(4);
            }
            connection.close();

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    Logger.getLogger(RoleRequestDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(RoleRequestDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return status;
    }

    @Override
    public void assignDirector(Integer user_id) {
        try {
            String mySQLQuery = "INSERT INTO `users_roles` (`user_id`, `role_id`) VALUES (?, ?)";

            PreparedStatement myPS = connection.prepareStatement(mySQLQuery);

            myPS.setInt(1, user_id);
            myPS.setInt(2, 2);

            myPS.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(RoleRequestDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public void assignCommittee(Integer user_id) {
        try {
            String mySQLQuery = "INSERT INTO users_roles (`user_id`, `role_id`) VALUES (?, ?)";

            PreparedStatement myPS = connection.prepareStatement(mySQLQuery);

            myPS.setInt(1, user_id);
            myPS.setInt(2, 3);

            myPS.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(RoleRequestDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public void assignLecturer(Integer user_id) {
        try {
            String mySQLQuery = "INSERT INTO users_roles (`user_id`, `role_id`) VALUES (?, ?)";

            PreparedStatement myPS = connection.prepareStatement(mySQLQuery);

            myPS.setInt(1, user_id);
            myPS.setInt(2, 4);

            myPS.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(RoleRequestDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

}
