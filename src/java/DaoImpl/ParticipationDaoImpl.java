/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DaoImpl;

import Dao.ParticipationDao;
import Database.DBConnection;
import Model.Participation;
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
public class ParticipationDaoImpl implements ParticipationDao {

    private final Connection connection;

    public ParticipationDaoImpl() throws SQLException {
        connection = DBConnection.getConnection();
    }

    @Override
    public void save_participation(Participation participation) {
        try {
            String mySQLQuery = "insert into comtech_participation (participationid, userid, programName, participationLevel, position, evidence, programDate) values(NULL, ?, ?, ?, ?, ?, ?)";

            PreparedStatement myPS = connection.prepareStatement(mySQLQuery);

            myPS.setInt(1, participation.getUserid());
            myPS.setString(2, participation.getProgramName());
            myPS.setString(3, participation.getParticipationLevel());
            myPS.setString(4, participation.getPosition());

            Part filePart = participation.getEvidence();
            InputStream inputStream = null;

            if (filePart != null) {
                // obtains input stream of the upload file
                inputStream = filePart.getInputStream();
            }

            if (inputStream != null) {
                // fetches input stream of the upload file for the blob column
                myPS.setBlob(5, inputStream);
            }

            myPS.setString(6, participation.getProgramDate());

            myPS.executeUpdate();
        } catch (SQLException | IOException ex) {
            Logger.getLogger(ParticipationDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public List<Participation> getAllByUserId(int userid) {
        List<Participation> participationList = new ArrayList<>();

        try {
            String sqlQuery = "select * from comtech_participation where userid =" + userid;
            PreparedStatement stat = connection.prepareStatement(sqlQuery);
            ResultSet rs = stat.executeQuery(sqlQuery);

            while (rs.next()) {
                Participation Participation = new Participation();

                Participation.setParticipationid(rs.getInt(1));
                Participation.setUserid(userid);
                Participation.setProgramName(rs.getString(3));
                Participation.setParticipationLevel(rs.getString(4));
                Participation.setPosition(rs.getString(5));

                Part filePart = Participation.getEvidence();
                InputStream inputStream = null;

                if (filePart != null) {
                    // obtains input stream of the upload file
                    inputStream = filePart.getInputStream();
                }

                if (inputStream != null) {
                    // fetches input stream of the upload file for the blob column
                    stat.setBlob(6, inputStream);
                }

                Participation.setProgramDate(rs.getString(7));

                participationList.add(Participation);
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        } catch (IOException ex) {
            Logger.getLogger(ParticipationDaoImpl.class.getName()).log(Level.SEVERE, null, ex);
        }
        return participationList;
    }

}
