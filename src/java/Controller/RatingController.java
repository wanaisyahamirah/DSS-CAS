/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Dao.RatingDao;
import DaoImpl.RatingDaoImpl;
import Model.Rating;
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
public class RatingController extends HttpServlet {

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
                case "rate_student": // not sure if this method is being used
                    rate_student(request, response);
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
            Logger.getLogger(RatingController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(RatingController.class.getName()).log(Level.SEVERE, null, ex);
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

    private void rate_student(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {

        Integer candidate_id = Integer.parseInt(request.getParameter("candidate_id"));
        Integer lecturer_id = Integer.parseInt(request.getParameter("lecturer_id"));
        Integer responsibility_score = Integer.parseInt(request.getParameter("responsibility"));
        Integer leadership_score = Integer.parseInt(request.getParameter("leadership"));
        Integer discipline_score = Integer.parseInt(request.getParameter("discipline"));
        Integer personality_score = Integer.parseInt(request.getParameter("personality"));

        Rating rating = new Rating();

        rating.setCandidate_id(candidate_id);
        rating.setLecturer_id(lecturer_id);
        rating.setIntangible_id(1);
        rating.setScore(responsibility_score);

        RatingDao ratingDao4 = new RatingDaoImpl();
        ratingDao4.submitRating(rating);

        Rating rating1 = new Rating();

        rating1.setCandidate_id(candidate_id);
        rating1.setLecturer_id(lecturer_id);
        rating1.setIntangible_id(2);
        rating1.setScore(leadership_score);

        RatingDao ratingDao = new RatingDaoImpl();
        ratingDao.submitRating(rating1);

        Rating rating2 = new Rating();

        rating2.setCandidate_id(candidate_id);
        rating2.setLecturer_id(lecturer_id);
        rating2.setIntangible_id(3);
        rating2.setScore(discipline_score);

        RatingDao ratingDao2 = new RatingDaoImpl();
        ratingDao2.submitRating(rating2);

        Rating rating3 = new Rating();

        rating3.setCandidate_id(candidate_id);
        rating3.setLecturer_id(lecturer_id);
        rating3.setIntangible_id(4);
        rating3.setScore(personality_score);
        
        RatingDao ratingDao3 = new RatingDaoImpl();
        ratingDao3.submitRating(rating3);

        response.sendRedirect(request.getContextPath() + "/Lecturer/award-candidate.jsp");
    }

}
