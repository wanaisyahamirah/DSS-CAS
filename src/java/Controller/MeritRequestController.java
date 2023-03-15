/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Dao.MeritRequestDao;
import DaoImpl.MeritRequestDaoImpl;
import Model.MeritRequest;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author ariffnorhadi
 */
@MultipartConfig(maxFileSize = 16177215) // upload file's size up to 16MB
public class MeritRequestController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String action = request.getParameter("action");

        if (action != null) {
            switch (action) {
                case "merit_submission":
                    merit_submission(request, response);
                    break;
                case "view_evidence":
                    view_evidence(request, response);
                    break;
                case "approveMeritRequest":
                    approveMeritRequest(request, response);
                    break;
                case "rejectMeritRequest":
                    rejectMeritRequest(request, response);
                    break;
            }
        } else {
            response.sendRedirect(request.getContextPath() + "Candidate/merit-form.jsp"); //Tukar redirect page (not sure kat mana)
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
            Logger.getLogger(MeritRequestController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(MeritRequestController.class.getName()).log(Level.SEVERE, null, ex);
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

    private void merit_submission(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, SQLException {

        // get all params
        int user_id = Integer.parseInt(request.getParameter("user_id"));
        int merit_value = Integer.parseInt(request.getParameter("merit_value"));
        Part evidence = request.getPart("evidence");

        // need to store data into Bean, so create Bean
        MeritRequest meritRequest = new MeritRequest();

        // assign params to object (MeritRequest)
        meritRequest.setUser_id(user_id);
        meritRequest.setMerit_value(merit_value);
        meritRequest.setEvidence(evidence);

        // pass stire data in the bean to DAO
        MeritRequestDao meritReqDao = new MeritRequestDaoImpl();
        meritReqDao.createRequest(meritRequest);

        HttpSession session = request.getSession();
        session.setAttribute("registered_MeritRequest", meritRequest);

        // save the bean as attribute and pass to redirect user to the right page
        response.sendRedirect("Candidate/candidate-dashboard.jsp");
    }

    private void view_evidence(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String requestid = request.getParameter("requestId");

        ServletOutputStream sos;
        Connection con = null;
        PreparedStatement pstmt = null;

        response.setContentType("application/pdf");

        response.setHeader("Content-disposition", "inline; filename=" + requestid + ".pdf");

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
            pstmt = con.prepareStatement("SELECT evidence FROM merit_request where requestid=?");
            pstmt.setString(1, requestid.trim());
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

    private void approveMeritRequest(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        // get params
        int requestid = Integer.parseInt(request.getParameter("requestId"));
        int managedBy = Integer.parseInt(request.getParameter("managedBy"));
        Integer candidateid = Integer.parseInt(request.getParameter("candidateid"));
        int meritValue = Integer.parseInt(request.getParameter("meritValue"));
        
        // execute operation
        MeritRequestDao MeritRequestDao = new MeritRequestDaoImpl();
        MeritRequestDao.approveRequest(requestid, managedBy);
        
        // update merit value here. dao.update_merit(meritValue)
        MeritRequestDao MeritRequestDao1 = new MeritRequestDaoImpl();
        MeritRequestDao1.updateMerit(meritValue, candidateid);
        
        response.sendRedirect(request.getContextPath() + "/Program-Committee/merit-request-list.jsp");
    }

    private void rejectMeritRequest(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        
        // get params
        int requestid = Integer.parseInt(request.getParameter("requestId"));
        int managedBy = Integer.parseInt(request.getParameter("managedBy"));
        
        // execute operation
        MeritRequestDao MeritRequestDao = new MeritRequestDaoImpl();
        MeritRequestDao.rejectRequest(requestid, managedBy);
        response.sendRedirect(request.getContextPath() + "/Program-Committee/merit-request-list.jsp");
    }

}
