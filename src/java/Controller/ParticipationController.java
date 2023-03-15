/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Dao.ParticipationDao;
import DaoImpl.ParticipationDaoImpl;
import Model.Participation;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 *
 * @author aisy
 */
@MultipartConfig(maxFileSize = 16177215) // upload file's size up to 16MB
public class ParticipationController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "submit_comtech_participation":
                    submit_comtech_participation(request, response);
                    break;
                case "view_evidence":
                    view_evidence(request, response);
                    break;
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/Candidate/cgpa-form.jsp"); //Tukar redirect page (not sure kat mana)
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ParticipationController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ParticipationController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void submit_comtech_participation(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, SQLException {
        // get all params
        int user_id = Integer.parseInt(request.getParameter("user_id"));
        Part evidence = request.getPart("evidence");
        String program_name = request.getParameter("program_name");

        // set date
        String sEventDate = request.getParameter("eventDate");
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd/yyyy", Locale.ENGLISH);
        DateTimeFormatter final_formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd", Locale.ENGLISH);
        LocalDate eventDate = LocalDate.parse(sEventDate, formatter);
        String date = final_formatter.format(eventDate);

        String participation_level = request.getParameter("level");
        String position = request.getParameter("position");

        // need to store data into Bean, so create Bean
        Participation participation = new Participation();

        participation.setUserid(user_id);
        participation.setEvidence(evidence);
        participation.setProgramName(program_name);
        participation.setProgramDate(date);
        participation.setParticipationLevel(participation_level);
        participation.setPosition(position);

        ParticipationDao pDao = new ParticipationDaoImpl();
        pDao.save_participation(participation);

        // save the bean as attribute and pass to redirect user to the right page
        response.sendRedirect("Candidate/involvement-form.jsp");
    }

    private void view_evidence(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String participationid = request.getParameter("participationid");

        ServletOutputStream sos;
        Connection con = null;
        PreparedStatement pstmt = null;

        response.setContentType("application/pdf");

        response.setHeader("Content-disposition", "inline; filename=" + participationid + ".pdf");

        sos = response.getOutputStream();

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/dss-cas", "root", "");
        } catch (Exception e) {
            System.out.println(e);
            System.exit(0);
        }

        ResultSet rset = null;
        try {
            pstmt = con.prepareStatement("SELECT evidence FROM comtech_participation where participationid=?");
            pstmt.setString(1, participationid.trim());
            rset = pstmt.executeQuery();
            if (rset.next()) {
                sos.write(rset.getBytes("evidence"));
            } else {
                return;
            }

        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        sos.flush();
        sos.close();
    }

}
