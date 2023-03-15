/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Dao.AwardDao;
import DaoImpl.AwardDaoImpl;
import Model.Award;
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
 * @author ariffnorhadi
 */
public class AwardController extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        String command = request.getParameter("action");

        if (command != null) {
            switch (command) {
                case "registerAward": // not sure if this method is being used
                    createAwardByCommittee(request, response);
                    break;
                case "saveWinner": // not sure if this method is being used
                    saveWinner(request, response);
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
            Logger.getLogger(AwardController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(AwardController.class.getName()).log(Level.SEVERE, null, ex);
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

    private void createAwardByCommittee(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        AwardDao awardDao = new AwardDaoImpl();
        HttpSession session = request.getSession();

        // get all params
        String award_name = request.getParameter("award_name");
        String year_criteria = request.getParameter("year_criteria");
        String program_criteria = request.getParameter("program_criteria");
        String gender_criteria = request.getParameter("gender_criteria");
        Integer event_id = Integer.parseInt(request.getParameter("event_id"));        
        Integer created_by = Integer.parseInt(request.getParameter("created_by"));

        // assign attributes to object ( Award )
        Award award = new Award();
        award.setAward_name(award_name);
        award.setYear_criteria(year_criteria);
        award.setProgram_criteria(program_criteria);
        award.setGender_criteria(gender_criteria);
        award.setEvent_id(event_id);
        award.setCreated_by(created_by);
        
        // perform operation
        awardDao.createAward(award);

        // set attributes
        String message = "Award created!";
        session.setAttribute("successful_created_award_message", message);
        response.sendRedirect(request.getContextPath() + "/Program-Committee/committee-dashboard.jsp");
    }

    private void saveWinner(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        AwardDao awardDao = new AwardDaoImpl();
        HttpSession session = request.getSession();

        // get all params
        int candidateid = Integer.parseInt(request.getParameter("candidateid"));
        int awardid = Integer.parseInt(request.getParameter("awardid"));
        
        // perform operation
        awardDao.saveWinner(awardid, candidateid);

        // redirect to the right page
        response.sendRedirect(request.getContextPath() + "/Student-Development-Committee/award-candidate.jsp?awardid="+awardid);
    }

}
