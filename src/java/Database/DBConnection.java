/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author aisyah
 */
public class DBConnection implements java.io.Serializable {
    
    private static Connection con;
    
    public static Connection getConnection() throws SQLException{
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/dss-cas";
            
            con = DriverManager.getConnection(url, "root", "");
        } catch (ClassNotFoundException | SQLException e){
            e.getMessage();
        }
        return con;
    }
    
    public void closeConnection(){
        try {
            con.close();
        } catch (SQLException e){
            e.getMessage();
        }
    }
}