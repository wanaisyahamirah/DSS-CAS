/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DaoImpl;

import Dao.UserRoleDao;
import Database.DBConnection;
import Model.UserRole;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author aisy
 */
public class UserRoleDaoImpl implements UserRoleDao {

    private final Connection connection;

    public UserRoleDaoImpl() throws SQLException {
        connection = DBConnection.getConnection();
    }

    /**
     *
     * @param userRole
     */
    @Override
    public void saveRole(UserRole userRole) {
        try {
            /*
            INSERT INTO `users_roles` (`user_id`, `role_id`) VALUES ('11', '4');
             */
            String mySQLQuery = "INSERT INTO users_roles (user_id, role_id) VALUES (?, ?)";

            PreparedStatement myPS = connection.prepareStatement(mySQLQuery);

            myPS.setInt(1, userRole.getUserId());
            myPS.setInt(2, userRole.getRoleId());

            myPS.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(UserRoleDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

}
