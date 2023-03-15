/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Dao.UserDao;
import DaoImpl.UserDaoImpl;
import Model.User;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author aisy
 */
public class SignInController extends HttpServlet {

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
        String command = request.getParameter("action");
        
        HttpSession session = request.getSession();
        session.removeAttribute("successful_candidate_signup_process");
        session.removeAttribute("successful_director_signup_process");
        session.removeAttribute("successful_candidate_signup_process");

        if (command != null) {
            switch (command) {
                case "sign_in":
                    sigin_process(request, response);
                    break;
                case "sign_out":
                    sigout_process(request, response);
                    break;
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/index.html");
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
            Logger.getLogger(SignInController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(SignInController.class.getName()).log(Level.SEVERE, null, ex);
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

    private void sigin_process(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        
        HttpSession session = request.getSession();
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        User user;
        UserDao userDao = new UserDaoImpl();
                    
        user = userDao.authenticateUserWithID(username, password);
        
        if (user != null) {
            session.setAttribute("logged_in_user", user);
            /*
            what to do
            1. check request from this user ( from table user request, get request by user id, check the status )
            2. check the status of the request ( get the status )
            3. redirect to correct page ( redirect to correct page if approved, else display message )
            4. display appropriate message if not yet approved
            */
            UserDao userDao2 = new UserDaoImpl();
            String requestStatus = userDao2.getRoleRequestStatusByUserId(user.getUserid());
            String message = "";
            
            session.removeAttribute("successful_candidate_signup_process");
            session.removeAttribute("logout_message");
            session.removeAttribute("signin_message");
            session.removeAttribute("authentication_failed");
            if (user.getUsername().equals("sdc")){
                response.sendRedirect("Student-Development-Committee/sdc-dashboard.jsp");
            }
            else if (requestStatus.equals("")){
                UserDao userDaoCheckRole = new UserDaoImpl();
                Integer roleId = userDaoCheckRole.findRoleByUserId(user.getUserid());
                if (null == roleId) {
                    message = "Sorry, we do not have any record on your role request in the event. Do contact us if you need assistance.";
                    session.setAttribute("signin_message", message);
                    response.sendRedirect("General-Pages/signin.jsp");
                }
                else switch (roleId) {
                    case 5:
                        response.sendRedirect("Candidate/candidate-dashboard.jsp"); // this one ganti ke candidate dashbaord
                        break;
                    case 1:
                        response.sendRedirect("Student-Development-Committee/sdc-dashboard.jsp"); // this one ganti ke sdc dashbaord
                        break;
                    default:
                        message = "Sorry, we do not have any record on your role request in the event. Do contact us if you need assistance.";
                        session.setAttribute("signin_message", message);
                        response.sendRedirect("General-Pages/signin.jsp");
                        break;
                }
            }
            else if (requestStatus.equals("PENDING")){
                message = "Sorry, your request is still pending, please try again in few more days.";
                session.setAttribute("signin_message", message);
                response.sendRedirect("General-Pages/signin.jsp");
            }
            else if (requestStatus.equals("REJECTED")){
                message = "Sorry, your request has been rejected due to some rule violations.";
                session.setAttribute("signin_message", message);
                response.sendRedirect("General-Pages/signin.jsp");
            }
            else if (requestStatus.equals("APPROVED")){
                UserDao userDao3 = new UserDaoImpl();
                Integer roleId = userDao3.findRoleByUserId(user.getUserid());
                if (null != roleId)switch (roleId) {
                    case 2:
                        response.sendRedirect("Program-Director/director-dashboard.jsp");
                        break;
                    case 3:
                        response.sendRedirect("Program-Committee/committee-dashboard.jsp");
                        break;
                    case 4:
                        response.sendRedirect("Lecturer/lecturer-dashboard.jsp");
                        break;
                    default:
                        break;
                }
            }
        }
        else{
            session.setAttribute("authentication_failed", "Bad credentials. Please try again.");
            response.sendRedirect("General-Pages/signin.jsp");
        }
    }

    private void sigout_process(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        session.removeAttribute("logged_in_user");
        session.setAttribute("logout_message", "Successfully logged out");
        response.sendRedirect("General-Pages/signin.jsp");
    }

}
