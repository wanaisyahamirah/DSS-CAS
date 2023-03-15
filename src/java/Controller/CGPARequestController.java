/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Dao.CGPARequestDao;
import Dao.UserDao;
import DaoImpl.CGPARequestDaoImpl;
import DaoImpl.UserDaoImpl;
import Model.CGPARequest;
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
 * @author aisy
 */
@MultipartConfig(maxFileSize = 16177215) // upload file's size up to 16MB
public class CGPARequestController extends HttpServlet {

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
                case "cgpa_submission":
                    cgpa_submission(request, response);
                    break;
                case "view_evidence":
                    view_evidence(request, response);
                    break;
                case "approveCGPARequest":
                    approveCGPARequest(request, response);
                    break;
                case "rejectCGPARequest":
                    rejectCGPARequest(request, response);
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
            Logger.getLogger(CGPARequestController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(CGPARequestController.class.getName()).log(Level.SEVERE, null, ex);
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

    private void cgpa_submission(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, SQLException {

        // get all params
        int user_id = Integer.parseInt(request.getParameter("user_id"));
        double cgpa = Double.parseDouble(request.getParameter("cgpa"));
        Part evidence = request.getPart("evidence");

        // need to store data into Bean, so create Bean
        CGPARequest cgpaRequest = new CGPARequest();

        // assign params to object (MeritRequest)
        cgpaRequest.setUser_id(user_id);
        cgpaRequest.setCgpa(cgpa);
        cgpaRequest.setEvidence(evidence);

        // pass stire data in the bean to DAO
        CGPARequestDao cgpaRequestDao = new CGPARequestDaoImpl();
        cgpaRequestDao.createRequest(cgpaRequest);

        HttpSession session = request.getSession();
        session.setAttribute("registered_CGPARequest", cgpaRequest);

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
            pstmt = con.prepareStatement("SELECT evidence FROM cgpa_request where requestid=?");
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

    private void approveCGPARequest(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        // get params
        Integer requestid = Integer.parseInt(request.getParameter("requestId"));
        Integer current_user_id = Integer.parseInt(request.getParameter("current_user_id"));
        Integer candidateid = Integer.parseInt(request.getParameter("candidateid"));
        Double cgpa_value = Double.parseDouble(request.getParameter("cgpa_value"));

        // execute operation
        CGPARequestDao CGPARequestDao = new CGPARequestDaoImpl();
        CGPARequestDao.approveRequest(requestid, current_user_id);
        
        // update cgpa value here. dao.update_cgpa(cgpa_value)
        CGPARequestDao CGPARequestDao1 = new CGPARequestDaoImpl();
        CGPARequestDao1.updateCGPA(cgpa_value, candidateid);
        
        response.sendRedirect(request.getContextPath() + "/Student-Development-Committee/cgpa-request-list.jsp");
    }

    private void rejectCGPARequest(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        // get params
        String stringRequestId = request.getParameter("requestId");
        Integer requestId = Integer.parseInt(stringRequestId);
        String stringUserId = request.getParameter("current_user_id");
        Integer current_user_id = Integer.parseInt(stringUserId);

        // execute operation
        CGPARequestDao CGPARequestDao = new CGPARequestDaoImpl();
        CGPARequestDao.rejectRequest(requestId, current_user_id);
        response.sendRedirect(request.getContextPath() + "/Student-Development-Committee/cgpa-request-list.jsp");
    }

}
