/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Dao.RoleRequestDao;
import Dao.UserDao;
import DaoImpl.RoleRequestDaoImpl;
import DaoImpl.UserDaoImpl;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author aisy
 */
public class RoleRequestController extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        String command = request.getParameter("action");

        if (command != null) {
            switch (command) {
                case "approveSignUpRequest": // not sure if this method is being used
                    processApprove(request, response);
                    break;
                case "rejectSignUpRequest": // not sure if this method is being used
                    processReject(request, response);
                    break;
                case "approveDirectorRequest":
                    approveDirectorRequest(request, response);
                    break;
                case "rejectDirectorRequest":
                    rejectDirectorRequest(request, response);
                    break;
                case "approveCommitteeRequest":
                    approveCommitteeRequest(request, response);
                    break;
                case "rejectCommitteeRequest":
                    rejectCommitteeRequest(request, response);
                    break;
                case "approveLecturerRequest":
                    approveLecturerRequest(request, response);
                    break;
                case "rejectLecturerRequest":
                    rejectLecturerRequest(request, response);
                    break;
            }
        } else {
            response.sendRedirect(request.getContextPath() + "index.html");
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
            Logger.getLogger(RoleRequestController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(RoleRequestController.class.getName()).log(Level.SEVERE, null, ex);
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

    private void processApprove(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        String stringRequestId = request.getParameter("requestId");
        String stringUserId = request.getParameter("approvedBy");
        Integer requestId = Integer.parseInt(stringRequestId);
        Integer userId = Integer.parseInt(stringUserId);

        RoleRequestDao roleRequestDao = new RoleRequestDaoImpl();
        roleRequestDao.approveRequest(requestId, userId);
        response.sendRedirect(request.getContextPath() + "/Student-Development-Committee/request-list.jsp");
    }

    private void processReject(HttpServletRequest request, HttpServletResponse response) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    private void approveDirectorRequest(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        // get params
        String stringRequestId = request.getParameter("requestId");
        Integer requestId = Integer.parseInt(stringRequestId);
        String stringUserId = request.getParameter("userId");
        Integer userId = Integer.parseInt(stringUserId);
        UserDao userDao = new UserDaoImpl();
        int sdcId = userDao.getUserIdByUsername("sdc");

        // execute operation
        RoleRequestDao roleRequestDao = new RoleRequestDaoImpl();
        roleRequestDao.approveRequest(requestId, sdcId);
        RoleRequestDao roleRequestDao2 = new RoleRequestDaoImpl();
        roleRequestDao2.assignDirector(userId);
        response.sendRedirect(request.getContextPath() + "/Student-Development-Committee/request-list.jsp");
    }

    private void rejectDirectorRequest(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
         // get params
        String stringRequestId = request.getParameter("requestId");
        Integer requestId = Integer.parseInt(stringRequestId);
        UserDao userDao = new UserDaoImpl();
        int sdcId = userDao.getUserIdByUsername("sdc");

        // execute operation
        RoleRequestDao roleRequestDao = new RoleRequestDaoImpl();
        roleRequestDao.rejectRequest(requestId, sdcId);
        response.sendRedirect(request.getContextPath() + "/Student-Development-Committee/request-list.jsp");
    }

    private void approveCommitteeRequest(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
         // get params
        String stringRequestId = request.getParameter("requestId");
        Integer requestId = Integer.parseInt(stringRequestId);
        String stringUserId = request.getParameter("userId");
        Integer userId = Integer.parseInt(stringUserId);
        UserDao userDao = new UserDaoImpl();
        int sdcId = userDao.getUserIdByUsername("sdc");

        // execute operation
        RoleRequestDao roleRequestDao = new RoleRequestDaoImpl();
        roleRequestDao.approveRequest(requestId, sdcId);
        RoleRequestDao roleRequestDao2 = new RoleRequestDaoImpl();
        roleRequestDao2.assignCommittee(userId);
        response.sendRedirect(request.getContextPath() + "/Student-Development-Committee/request-list.jsp");
    }

    private void rejectCommitteeRequest(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
         // get params
        String stringRequestId = request.getParameter("requestId");
        Integer requestId = Integer.parseInt(stringRequestId);
        UserDao userDao = new UserDaoImpl();
        int sdcId = userDao.getUserIdByUsername("sdc");

        // execute operation
        RoleRequestDao roleRequestDao = new RoleRequestDaoImpl();
        roleRequestDao.rejectRequest(requestId, sdcId);
        response.sendRedirect(request.getContextPath() + "/Student-Development-Committee/request-list.jsp");
    }

    private void approveLecturerRequest(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
         // get params
        String stringRequestId = request.getParameter("requestId");
        Integer requestId = Integer.parseInt(stringRequestId);
        String stringUserId = request.getParameter("userId");
        Integer userId = Integer.parseInt(stringUserId);
        UserDao userDao = new UserDaoImpl();
        int sdcId = userDao.getUserIdByUsername("sdc");

        // execute operation
        RoleRequestDao roleRequestDao = new RoleRequestDaoImpl();
        roleRequestDao.approveRequest(requestId, sdcId);
        RoleRequestDao roleRequestDao2 = new RoleRequestDaoImpl();
        roleRequestDao2.assignLecturer(userId);
        response.sendRedirect(request.getContextPath() + "/Student-Development-Committee/request-list.jsp");
    }

    private void rejectLecturerRequest(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
         // get params
        String stringRequestId = request.getParameter("requestId");
        Integer requestId = Integer.parseInt(stringRequestId);
        UserDao userDao = new UserDaoImpl();
        int sdcId = userDao.getUserIdByUsername("sdc");

        // execute operation
        RoleRequestDao roleRequestDao = new RoleRequestDaoImpl();
        roleRequestDao.rejectRequest(requestId, sdcId);
        response.sendRedirect(request.getContextPath() + "/Student-Development-Committee/request-list.jsp");
    }

}
