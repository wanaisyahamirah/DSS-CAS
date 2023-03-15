/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Dao.EventDao;
import Dao.RoleRequestDao;
import Dao.UserDao;
import Dao.UserRoleDao;
import DaoImpl.EventDaoImpl;
import DaoImpl.RoleRequestDaoImpl;
import DaoImpl.UserDaoImpl;
import DaoImpl.UserRoleDaoImpl;
import Model.Event;
import Model.RoleRequest;
import Model.User;
import Model.UserRole;
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
 * @author aisya
 */
public class SignUpController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     * @throws java.lang.InterruptedException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException, InterruptedException {
        String action = request.getParameter("action");

        HttpSession session = request.getSession();
        session.removeAttribute("successful_candidate_signup_process");
        session.removeAttribute("logout_message");
        session.removeAttribute("signin_message");
        session.removeAttribute("authentication_failed");

        if (action != null) {
            switch (action) {
                case "check_cgpa_merit":
                    check_cgpa_merit(request, response);
                    break;

                case "registerCandidate":
                    register_candidate(request, response);
                    break;

                case "register_director":
                    register_director(request, response);
                    break;

                case "register_committee":
                    register_committee(request, response);
                    break;

                case "register_lecturer":
                    register_lecturer(request, response);
                    break;
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
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
            Logger.getLogger(SignUpController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InterruptedException ex) {
            Logger.getLogger(SignUpController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(SignUpController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InterruptedException ex) {
            Logger.getLogger(SignUpController.class.getName()).log(Level.SEVERE, null, ex);
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

    private void check_cgpa_merit(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        // get all params
        String cgpa = request.getParameter("cgpa");
        String merit = request.getParameter("merit");

        double CGPA = Double.parseDouble(cgpa);
        int MERIT = Integer.parseInt(merit);

        HttpSession session = request.getSession();
        session.removeAttribute("cgpa_merit_not_eligible");

        EventDao eventDao = new EventDaoImpl();
        Event event = eventDao.getLiveEvent();
        if (CGPA >= event.getMinCgpa() && (event.getMinMerit() <= MERIT)) {
            session.setAttribute("CGPA", CGPA);
            session.setAttribute("MERIT", MERIT);
            response.sendRedirect(request.getContextPath() + "/Candidate/candidate-signup-verified.jsp");
        } else {
            String message = "Your cgpa or merit is not sufficient to participate in the event";
            session.setAttribute("cgpa_merit_not_eligible", message);
            response.sendRedirect(request.getContextPath() + "/index.jsp");
        }
    }

    private void register_candidate(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException, InterruptedException {
        UserDao userDao = new UserDaoImpl();
        UserRoleDao userRoleDao = new UserRoleDaoImpl();
        HttpSession session = request.getSession();

        // get merit and cgpa from previous form to be included in current form to save their details
        double CGPA = (double) session.getAttribute("CGPA");
        int MERIT = (int) session.getAttribute("MERIT");

        // get all params
        String gender = request.getParameter("gender");
        String fullName = request.getParameter("fullName");
        String icNumber = request.getParameter("icNumber");
        String username = request.getParameter("username");
        String mentorName = request.getParameter("mentorName");
        String program = request.getParameter("program");
        Integer yearOfStudy = Integer.parseInt(request.getParameter("yearOfStudy"));
        String email = username + "@ocean.umt.edu.my";
        String password = request.getParameter("password");
        String rePassword = request.getParameter("rePassword");
        String position = request.getParameter("position");

        // assign params to object (User) ( for candidate )
        User candidate = new User();
        candidate.setCgpa(CGPA);
        candidate.setMerit(MERIT);
        candidate.setGender(gender);
        candidate.setName(fullName);
        candidate.setNric(icNumber);
        candidate.setUsername(username);
        candidate.setMentorName(mentorName);
        candidate.setProgram(program);
        candidate.setYearStudy(yearOfStudy);
        candidate.setEmail(email);
        candidate.setPosition(position);

        // why we remove these attributes first, bcos if we resubmit the form, then we dun clear the attribute, it will keep appearing on the page
        // so we remove the attribute for every form submission, 
        // then if the same error happens again, then we give value again to the atrribute to display the message
        session.removeAttribute("passwords_do_not_match");
        session.removeAttribute("user_signing_up");
        Boolean verifyNumberExistence = userDao.verifyNumberExistence(password);
        Boolean verifyLowerCaseExistence = userDao.verifyLowerCaseExistence(password);
        Boolean verifyUpperCasesExistence = userDao.verifyUpperCasesExistence(password);
        Boolean verifyEightCharactersPassword = userDao.verifyEightCharactersPassword(password);
        Boolean verifyRepeatedPassword = userDao.verifyRepeatedPassword(password, rePassword);

        UserDao userDao2 = new UserDaoImpl();
        int number_of_record = userDao2.getNumberOfRecordByUsername(username);
        session.removeAttribute("gender");
        session.removeAttribute("fullName");
        session.removeAttribute("icNumber");
        session.removeAttribute("username");
        session.removeAttribute("mentorName");
        session.removeAttribute("program");
        session.removeAttribute("yearOfStudy");
        session.removeAttribute("email");
        session.removeAttribute("position");

        if (!verifyNumberExistence || !verifyLowerCaseExistence || !verifyUpperCasesExistence
                || !verifyEightCharactersPassword || !verifyRepeatedPassword || number_of_record > 0) {
            /*
            Check if password not valid, then only check one by one which is not fulfilled,
            then, give attribute for the error, 
            TODO: put these attributes on jsp
             */
            if (!verifyNumberExistence) {
                session.setAttribute("numberExistenceError", "Please include at least one digit in your password.");
            }
            if (!verifyLowerCaseExistence) {
                session.setAttribute("lowerCaseError", "Please include at least one lowercase character in your password.");
            }
            if (!verifyUpperCasesExistence) {
                session.setAttribute("uppercaseError", "Please include at least uppercase character in your password.");
            }
            if (!verifyEightCharactersPassword) {
                session.setAttribute("eightCharacterError", "Your password length should be at least 8 characters.");
            }
            if (!verifyRepeatedPassword) {
                session.setAttribute("repeatPasswordError", "Passwords do not match.");
            }
            if (number_of_record > 0) {
                session.setAttribute("record_exists", "User already exists.");
            }

            session.setAttribute("gender", gender);
            session.setAttribute("fullName", fullName);
            session.setAttribute("icNumber", icNumber);
            session.setAttribute("username", username);
            session.setAttribute("mentorName", mentorName);
            session.setAttribute("program", program);
            session.setAttribute("yearOfStudy", yearOfStudy);
            session.setAttribute("email", email);
            session.setAttribute("position", position);

            response.sendRedirect(request.getContextPath() + "/Candidate/candidate-signup-verified.jsp");

        } else {
            candidate.setPassword(password);
            userDao.registerCandidate(candidate);
            int user_id = userDao.getLastUserIdInDB();
            int role_id = 5;
            UserRole userRole = new UserRole();
            userRole.setUserId(user_id);
            userRole.setRoleId(role_id);
            userRoleDao.saveRole(userRole);
            String message = "Your sign up has been successful. Please login to proceed and we wish you all the best for the competition!";
            session.setAttribute("successful_candidate_signup_process", message);
            response.sendRedirect(request.getContextPath() + "/General-Pages/signin.jsp");
        }

    }

    private void register_director(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {

        // get all params
        String gender = request.getParameter("gender");
        String fullName = request.getParameter("fullName");
        String icNumber = request.getParameter("icNumber");
        String username = request.getParameter("username");
        String mentorName = request.getParameter("mentorName");
        String program = request.getParameter("program");
        Integer yearOfStudy = Integer.parseInt(request.getParameter("yearOfStudy"));
        String email = username + "@ocean.umt.edu.my";
        String password = request.getParameter("password");
        String rePassword = request.getParameter("rePassword");
        String position = request.getParameter("position");

        // assign params to object (User) ( for director )
        User director = new User();
        director.setGender(gender);
        director.setName(fullName);
        director.setNric(icNumber);
        director.setUsername(username);
        director.setMentorName(mentorName);
        director.setProgram(program);
        director.setYearStudy(yearOfStudy);
        director.setEmail(email);
        director.setPosition(position);

        HttpSession session = request.getSession();
        UserDao userDao = new UserDaoImpl();

        // why we remove these attributes first, bcos if we resubmit the form, then we dun clear the attribute, it will keep appearing on the page
        // so we remove the attribute for every form submission, 
        // then if the same error happens again, then we give value again to the atrribute to display the message
        session.removeAttribute("passwords_do_not_match");
        session.removeAttribute("user_signing_up");
        Boolean verifyNumberExistence = userDao.verifyNumberExistence(password);
        Boolean verifyLowerCaseExistence = userDao.verifyLowerCaseExistence(password);
        Boolean verifyUpperCasesExistence = userDao.verifyUpperCasesExistence(password);
        Boolean verifyEightCharactersPassword = userDao.verifyEightCharactersPassword(password);
        Boolean verifyRepeatedPassword = userDao.verifyRepeatedPassword(password, rePassword);
        UserDao userDao2 = new UserDaoImpl();
        int number_of_record = userDao2.getNumberOfRecordByUsername(username);
        if (!verifyNumberExistence || !verifyLowerCaseExistence || !verifyUpperCasesExistence
                || !verifyEightCharactersPassword || !verifyRepeatedPassword || number_of_record > 0) {
            /*
            Check if password not valid, then only check one by one which is not fulfilled,
            then, give attribute for the error, 
            TODO: put these attributes on jsp
             */
            if (!verifyNumberExistence) {
                session.setAttribute("numberExistenceError", "Please include at least one digit in your password.");
            }
            if (!verifyLowerCaseExistence) {
                session.setAttribute("lowerCaseError", "Please include at least one lowercase character in your password.");
            }
            if (!verifyUpperCasesExistence) {
                session.setAttribute("uppercaseError", "Please include at least uppercase character in your password.");
            }
            if (!verifyEightCharactersPassword) {
                session.setAttribute("eightCharacterError", "Your password length should be at least 8 characters.");
            }
            if (!verifyRepeatedPassword) {
                session.setAttribute("repeatPasswordError", "Passwords do not match.");
            }
            if (number_of_record > 0) {
                session.setAttribute("record_exists", "User already exists.");
            }

            response.sendRedirect(request.getContextPath() + "/Program-Director/director-signup.jsp");

        } else {
            director.setPassword(password);
            userDao.registerDirectorInfo(director);
            //set default status role request to Pending
            RoleRequest roleRequest = new RoleRequest();
            int director_id = userDao.getLastUserIdInDB();
            int role_id = 2; // director
            String status = "PENDING";
            roleRequest.setUserId(director_id);
            roleRequest.setRoleId(role_id);
            roleRequest.setStatus(status);
            RoleRequestDao roleRequestDao = new RoleRequestDaoImpl();
            roleRequestDao.saveRoleRequest(roleRequest);

            String message = "Your sign up has been successful. Your request will be "
                    + "processed within few working days. You can try to login anytime "
                    + "to check the status of your request";
            session.setAttribute("successful_director_signup_process", message);
            response.sendRedirect(request.getContextPath() + "/General-Pages/signin.jsp");
        }

    }

    private void register_committee(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        // get all params
        String gender = request.getParameter("gender");
        String fullName = request.getParameter("fullName");
        String icNumber = request.getParameter("icNumber");
        String username = request.getParameter("username");
        String mentorName = request.getParameter("mentorName");
        String program = request.getParameter("program");
        Integer yearOfStudy = Integer.parseInt(request.getParameter("yearOfStudy"));
        String email = username + "@ocean.umt.edu.my";
        String password = request.getParameter("password");
        String rePassword = request.getParameter("rePassword");
        String position = request.getParameter("position");

        // assign params to object (User) ( for committee )
        User committee = new User();
        committee.setGender(gender);
        committee.setName(fullName);
        committee.setNric(icNumber);
        committee.setUsername(username);
        committee.setMentorName(mentorName);
        committee.setProgram(program);
        committee.setYearStudy(yearOfStudy);
        committee.setEmail(email);
        committee.setPosition(position);

        HttpSession session = request.getSession();
        UserDao userDao = new UserDaoImpl();

        // why we remove these attributes first, bcos if we resubmit the form, then we dun clear the attribute, it will keep appearing on the page
        // so we remove the attribute for every form submission, 
        // then if the same error happens again, then we give value again to the atrribute to display the message
        session.removeAttribute("passwords_do_not_match");
        session.removeAttribute("user_signing_up");
        Boolean verifyNumberExistence = userDao.verifyNumberExistence(password);
        Boolean verifyLowerCaseExistence = userDao.verifyLowerCaseExistence(password);
        Boolean verifyUpperCasesExistence = userDao.verifyUpperCasesExistence(password);
        Boolean verifyEightCharactersPassword = userDao.verifyEightCharactersPassword(password);
        Boolean verifyRepeatedPassword = userDao.verifyRepeatedPassword(password, rePassword);
        UserDao userDao2 = new UserDaoImpl();
        int number_of_record = userDao2.getNumberOfRecordByUsername(username);
        if (!verifyNumberExistence || !verifyLowerCaseExistence || !verifyUpperCasesExistence
                || !verifyEightCharactersPassword || !verifyRepeatedPassword || number_of_record > 0) {
            /*
            Check if password not valid, then only check one by one which is not fulfilled,
            then, give attribute for the error, 
            TODO: put these attributes on jsp
             */
            if (!verifyNumberExistence) {
                session.setAttribute("numberExistenceError", "Please include at least one digit in your password.");
            }
            if (!verifyLowerCaseExistence) {
                session.setAttribute("lowerCaseError", "Please include at least one lowercase character in your password.");
            }
            if (!verifyUpperCasesExistence) {
                session.setAttribute("uppercaseError", "Please include at least uppercase character in your password.");
            }
            if (!verifyEightCharactersPassword) {
                session.setAttribute("eightCharacterError", "Your password length should be at least 8 characters.");
            }
            if (!verifyRepeatedPassword) {
                session.setAttribute("repeatPasswordError", "Passwords do not match.");
            }
            if (number_of_record > 0) {
                session.setAttribute("record_exists", "User already exists.");
            }

            response.sendRedirect(request.getContextPath() + "/Program-Committee/committee-signup.jsp");

        } else {
            committee.setPassword(password);
            userDao.registerDirectorInfo(committee);
            //set default status role request to Pending
            RoleRequest roleRequest = new RoleRequest();
            int committee_id = userDao.getLastUserIdInDB();
            int role_id = 3; // committee
            String status = "PENDING";
            roleRequest.setUserId(committee_id);
            roleRequest.setRoleId(role_id);
            roleRequest.setStatus(status);
            RoleRequestDao roleRequestDao = new RoleRequestDaoImpl();
            roleRequestDao.saveRoleRequest(roleRequest);

            String message = "Your sign up has been successful. Your request will be "
                    + "processed within few working days. You can try to login anytime "
                    + "to check the status of your request";
            session.setAttribute("successful_director_signup_process", message);
            response.sendRedirect(request.getContextPath() + "/General-Pages/signin.jsp");
        }
    }

    private void register_lecturer(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        // get all params
        String gender = request.getParameter("gender");
        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rePassword = request.getParameter("rePassword");

        // assign params to object (User) ( for director )
        User lecturer = new User();
        lecturer.setGender(gender);
        lecturer.setName(fullName); // todo: finish lecturer sign up
        lecturer.setUsername(username);

        HttpSession session = request.getSession();
        UserDao userDao = new UserDaoImpl();

        // why we remove these attributes first, bcos if we resubmit the form, then we dun clear the attribute, it will keep appearing on the page
        // so we remove the attribute for every form submission, 
        // then if the same error happens again, then we give value again to the atrribute to display the message
        session.removeAttribute("passwords_do_not_match");
        session.removeAttribute("user_signing_up");
        Boolean verifyNumberExistence = userDao.verifyNumberExistence(password);
        Boolean verifyLowerCaseExistence = userDao.verifyLowerCaseExistence(password);
        Boolean verifyUpperCasesExistence = userDao.verifyUpperCasesExistence(password);
        Boolean verifyEightCharactersPassword = userDao.verifyEightCharactersPassword(password);
        Boolean verifyRepeatedPassword = userDao.verifyRepeatedPassword(password, rePassword);
        UserDao userDao2 = new UserDaoImpl();
        int number_of_record = userDao2.getNumberOfRecordByUsername(username);
        if (!verifyNumberExistence || !verifyLowerCaseExistence || !verifyUpperCasesExistence
                || !verifyEightCharactersPassword || !verifyRepeatedPassword || number_of_record > 0) {
            /*
            Check if password not valid, then only check one by one which is not fulfilled,
            then, give attribute for the error, 
            TODO: put these attributes on jsp
             */
            if (!verifyNumberExistence) {
                session.setAttribute("numberExistenceError", "Please include at least one digit in your password.");
            }
            if (!verifyLowerCaseExistence) {
                session.setAttribute("lowerCaseError", "Please include at least one lowercase character in your password.");
            }
            if (!verifyUpperCasesExistence) {
                session.setAttribute("uppercaseError", "Please include at least uppercase character in your password.");
            }
            if (!verifyEightCharactersPassword) {
                session.setAttribute("eightCharacterError", "Your password length should be at least 8 characters.");
            }
            if (!verifyRepeatedPassword) {
                session.setAttribute("repeatPasswordError", "Passwords do not match.");
            }
            if (number_of_record > 0) {
                session.setAttribute("record_exists", "User already exists.");
            }

            response.sendRedirect(request.getContextPath() + "/Lecturer/lecturer-signup.jsp");

        } else {
            lecturer.setPassword(password);
            userDao.registerLecturerInfo(lecturer);
            //set default status role request to Pending
            RoleRequest roleRequest = new RoleRequest();
            int lecturer_id = userDao.getLastUserIdInDB();
            int role_id = 4; // lecturer
            String status = "PENDING";
            roleRequest.setUserId(lecturer_id);
            roleRequest.setRoleId(role_id);
            roleRequest.setStatus(status);
            RoleRequestDao roleRequestDao = new RoleRequestDaoImpl();
            roleRequestDao.saveRoleRequest(roleRequest);

            String message = "Your sign up has been successful. Your request will be "
                    + "processed within few working days. You can try to login anytime "
                    + "to check the status of your request";
            session.setAttribute("successful_director_signup_process", message);
            response.sendRedirect(request.getContextPath() + "/General-Pages/signin.jsp");
        }

    }

}
