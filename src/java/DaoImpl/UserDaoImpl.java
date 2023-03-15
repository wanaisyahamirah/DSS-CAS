/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DaoImpl;

import Model.User;
import Dao.UserDao;
import Database.DBConnection;
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
public class UserDaoImpl implements UserDao {

    private final Connection connection;

    public UserDaoImpl() throws SQLException {
        connection = DBConnection.getConnection();
    }

    @Override
    public void registerCandidate(User user) {
        try {
            String mySQLQuery
                    = "INSERT INTO `user` (`userid`, `cgpa`, `merit`, `gender`, `name`, `nric`, `username`, `mentorName`, `program`, `yearStudy`, `email`, `password`, `position`, `profilePic`) VALUES "
                    + "(NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NULL)";

            PreparedStatement myPS = connection.prepareStatement(mySQLQuery);

            myPS.setDouble(1, user.getCgpa());
            myPS.setInt(2, user.getMerit());
            myPS.setString(3, user.getGender());
            myPS.setString(4, user.getName());
            myPS.setString(5, user.getNric());
            myPS.setString(6, user.getUsername());
            myPS.setString(7, user.getMentorName());
            myPS.setString(8, user.getProgram());
            myPS.setInt(9, user.getYearStudy());
            myPS.setString(10, user.getEmail());
            myPS.setString(11, user.getPassword());
            myPS.setString(12, user.getPosition());

            myPS.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(UserDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public Integer getLastUserIdInDB() {
        int id = 1;

        try {
            PreparedStatement myPS = DBConnection.getConnection()
                    .prepareStatement("SELECT userid FROM user WHERE userid=(SELECT max(userid) FROM user)");

            ResultSet rs = myPS.executeQuery();

            if (rs.next()) {
                id = rs.getInt("userid");
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(UserDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return id;
    }

    @Override
    public User authenticateUser(String username, String password) {
        User user = null;
        ResultSet rs = null;
        try {
            String mySQLQuery = "select * from user where username=? and password=?";
            PreparedStatement ps = connection.prepareStatement(mySQLQuery);

            ps.setString(1, username);
            ps.setString(2, password);

            rs = ps.executeQuery();

            while (rs.next()) {
                user = new User();
                user.setUsername(username);
                user.setPassword(password);
                user.setUserid(rs.getInt(1));
                user.setCgpa(rs.getDouble(2));
                user.setMerit(rs.getInt(3));
                user.setGender(rs.getString(4));
                user.setName(rs.getString(5));
                user.setNric(rs.getString(6));
                user.setMentorName(rs.getString(8));
                user.setProgram(rs.getString(9));
                user.setYearStudy(rs.getInt(10));
                user.setEmail(rs.getString(11));
                user.setPosition(rs.getString(13));
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
        return user;
    }

    @Override
    public User findById(Integer userId) {
        User user = new User();
        ResultSet rs = null;
        try {
            String mySQLQuery = "select * from user where userid=?";
            PreparedStatement ps = connection.prepareStatement(mySQLQuery);

            ps.setInt(1, userId);

            rs = ps.executeQuery();

            while (rs.next()) {
                user = new User();

                user.setUserid(rs.getInt(1));
                user.setCgpa(rs.getDouble(2));
                user.setMerit(rs.getInt(3));
                user.setGender(rs.getString(4));
                user.setName(rs.getString(5));
                user.setNric(rs.getString(6));
                user.setUsername(rs.getString(7));
                user.setMentorName(rs.getString(8));
                user.setProgram(rs.getString(9));
                user.setYearStudy(rs.getInt(10));
                user.setEmail(rs.getString(11));
                user.setPassword(rs.getString(12));
                user.setPosition(rs.getString(13));
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
        return user;
    }

    @Override
    public Integer findRoleByUserId(Integer userId) {
        Integer id = 0;
        ResultSet rs = null;
        try {
            String mySQLQuery = "select * from users_roles where user_id=? limit 1";
            PreparedStatement ps = connection.prepareStatement(mySQLQuery);

            ps.setInt(1, userId);

            rs = ps.executeQuery();

            while (rs.next()) {
                id = rs.getInt(2);
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
        return id;
    }

    @Override
    public void registerDirectorInfo(User user) {
        try {
            String mySQLQuery
                    = "INSERT INTO `user` (`userid`, `gender`, `name`, `nric`, `username`, `mentorName`, `program`, `yearStudy`, `email`, `password`, `position`, `profilePic`) VALUES "
                    + "(NULL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NULL)";

            PreparedStatement myPS = connection.prepareStatement(mySQLQuery);

            myPS.setString(1, user.getGender());
            myPS.setString(2, user.getName());
            myPS.setString(3, user.getNric());
            myPS.setString(4, user.getUsername());
            myPS.setString(5, user.getMentorName());
            myPS.setString(6, user.getProgram());
            myPS.setInt(7, user.getYearStudy());
            myPS.setString(8, user.getEmail());
            myPS.setString(9, user.getPassword());
            myPS.setString(10, user.getPosition());

            myPS.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(UserDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public Integer getUserIdByUsername(String username) {
        int id = 32;
        ResultSet rs = null;
        try {
            String mySQLQuery = "SELECT * FROM `user` WHERE username = ?";
            PreparedStatement ps = connection.prepareStatement(mySQLQuery);

            ps.setString(1, username);

            rs = ps.executeQuery();

            if (rs.next()) {
                id = rs.getInt(1);
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
        return id;
    }

    @Override
    public void registerLecturerInfo(User user) {
        try {
            String mySQLQuery
                    = "INSERT INTO `user` (`userid`, `gender`, `name`, `nric`, `username`, `mentorName`, `program`, `yearStudy`, `email`, `password`, `position`, `profilePic`) VALUES "
                    + "(NULL, ?, ?, NULL, ?, NULL, NULL, NULL, NULL, ?, NULL, NULL)";

            PreparedStatement myPS = connection.prepareStatement(mySQLQuery);

            myPS.setString(1, user.getGender());
            myPS.setString(2, user.getName());
            myPS.setString(3, user.getUsername());
            myPS.setString(4, user.getPassword());

            myPS.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(UserDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    @Override
    public String getRoleRequestStatusByUserId(Integer userId) {
        String status = "";
        ResultSet rs = null;
        try {
            String mySQLQuery = "SELECT status FROM `role_request` WHERE userid = ?";
            PreparedStatement ps = connection.prepareStatement(mySQLQuery);

            ps.setInt(1, userId);

            rs = ps.executeQuery();

            if (rs.next()) {
                status = rs.getString(1);
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
        return status;
    }

    @Override
    public List<Integer> findUsersByRoleId(Integer role_id) {
        List<Integer> userList = new ArrayList<>();

        try {
            String sqlQuery = "select * from users_roles where role_id =" + role_id;
            PreparedStatement stat = connection.prepareStatement(sqlQuery);
            ResultSet rs = stat.executeQuery(sqlQuery);

            while (rs.next()) {
                userList.add(rs.getInt(1));
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        }
        return userList;
    }

    @Override
    public User authenticateUserWithID(String id, String password) {
        User user = null;
        ResultSet rs = null;
        try {
            String mySQLQuery = "select * from user where username=? and password=?";
            PreparedStatement ps = connection.prepareStatement(mySQLQuery);

            ps.setString(1, id);
            ps.setString(2, password);

            rs = ps.executeQuery();

            while (rs.next()) {
                user = new User();
                user.setUsername(rs.getString(7));
                user.setPassword(password);
                user.setUserid(rs.getInt(1));
                user.setCgpa(rs.getDouble(2));
                user.setMerit(rs.getInt(3));
                user.setGender(rs.getString(4));
                user.setName(rs.getString(5));
                user.setNric(rs.getString(6));
                user.setMentorName(rs.getString(8));
                user.setProgram(rs.getString(9));
                user.setYearStudy(rs.getInt(10));
                user.setEmail(rs.getString(12));
                user.setPosition(rs.getString(13));
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
        return user;
    }

    @Override
    public boolean verifyNumberExistence(String password) {
        int count = 0;

        // check digits from 0 to 9
        for (int i = 0; i <= 9; i++) {

            // to convert int to string
            String str1 = Integer.toString(i);

            if (password.contains(str1)) {
                count = 1;
            }
        }
        return count != 0;
    }

    @Override
    public boolean verifyLowerCaseExistence(String password) {
        int count = 0;

        // checking small letters
        for (int i = 90; i <= 122; i++) {

            // type casting
            char c = (char) i;
            String str1 = Character.toString(c);

            if (password.contains(str1)) {
                count = 1;
            }
        }
        return count != 0;
    }

    @Override
    public boolean verifyUpperCasesExistence(String password) {
        int count = 0;

        // checking capital letters
        for (int i = 65; i <= 90; i++) {

            // type casting
            char c = (char) i;

            String str1 = Character.toString(c);
            if (password.contains(str1)) {
                count = 1;
            }
        }
        return count != 0;
    }

    @Override
    public boolean verifyEightCharactersPassword(String password) {
        return (password.length() >= 8);
    }

    @Override
    public boolean verifyRepeatedPassword(String password, String rePassword) {
        return password.equals(rePassword);
    }

    @Override
    public Integer getNumberOfRecordByUsername(String username) {
        int number_of_record = 0;
        ResultSet rs = null;
        try {
            String mySQLQuery = "select count(1) from user where username=?";
            PreparedStatement ps = connection.prepareStatement(mySQLQuery);

            ps.setString(1, username);
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

    @Override
    public List<Integer> getAllUserIdByRoleId(Integer roleid) {
        List<Integer> userList = new ArrayList<>();

        try {
            String sqlQuery = "select user_id from users_roles where role_id =" + roleid;
            PreparedStatement stat = connection.prepareStatement(sqlQuery);
            ResultSet rs = stat.executeQuery(sqlQuery);

            while (rs.next()) {
                userList.add(rs.getInt(1));
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        }
        return userList;
    }

    @Override
    public Integer getNumberOfRecordByYearAndGender(int roleid, int year, String gender) {
        int number_of_record = 0;
        ResultSet rs = null;
        try {
            //select count(1) from user INNER join users_roles on users_roles.user_id = user.userid WHERE users_roles.role_id = 5 and user.gender = 'male';
            String mySQLQuery = "select count(1) from user INNER join users_roles on users_roles.user_id = user.userid WHERE users_roles.role_id = ? and user.yearStudy = ? and user.gender = ?";
            PreparedStatement ps = connection.prepareStatement(mySQLQuery);

            ps.setInt(1, roleid);
            ps.setInt(2, year);
            ps.setString(3, gender);
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

    @Override
    public Integer getNumberOfRecordByProgramAndGender(int roleid, String program, String gender) {
        int number_of_record = 0;
        ResultSet rs = null;
        try {
            //select count(1) from user INNER join users_roles on users_roles.user_id = user.userid WHERE users_roles.role_id = 5 and user.gender = 'male';
            String mySQLQuery = "select count(1) from user INNER join users_roles on users_roles.user_id = user.userid WHERE users_roles.role_id = ? and user.program = ? and user.gender = ?";
            PreparedStatement ps = connection.prepareStatement(mySQLQuery);

            ps.setInt(1, roleid);
            ps.setString(2, program);
            ps.setString(3, gender);
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

    @Override
    public Integer getNumberOfRecordByGender(int roleid, String gender) {
        int number_of_record = 0;
        ResultSet rs = null;
        try {
            //select count(1) from user INNER join users_roles on users_roles.user_id = user.userid WHERE users_roles.role_id = 5 and user.gender = 'male';
            String mySQLQuery = "select count(1) from user INNER join users_roles on users_roles.user_id = user.userid WHERE users_roles.role_id = ? and user.gender = ?";
            PreparedStatement ps = connection.prepareStatement(mySQLQuery);

            ps.setInt(1, roleid);
            ps.setString(2, gender);
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

    @Override
    public Integer getMeritByUserId(Integer userid) {
        int merit = 0;

        try {
            PreparedStatement myPS = DBConnection.getConnection()
                    .prepareStatement("SELECT merit FROM user WHERE userid=" + userid);

            ResultSet rs = myPS.executeQuery();

            if (rs.next()) {
                merit = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(UserDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return merit;
    }

    @Override
    public Double getCGPAByUserId(Integer userid) {
         double cgpa = 0.0;

        try {
            PreparedStatement myPS = DBConnection.getConnection()
                    .prepareStatement("SELECT cgpa FROM user WHERE userid=" + userid);

            ResultSet rs = myPS.executeQuery();

            if (rs.next()) {
                cgpa = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } finally {
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(UserDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return cgpa;
    }

}
