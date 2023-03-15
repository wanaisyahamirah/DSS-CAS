/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Dao.AwardDao;
import Dao.CGPARequestDao;
import Dao.EventDao;
import Dao.MeritRequestDao;
import Dao.RatingDao;
import Dao.UserDao;
import DaoImpl.AwardDaoImpl;
import DaoImpl.CGPARequestDaoImpl;
import DaoImpl.EventDaoImpl;
import DaoImpl.MeritRequestDaoImpl;
import DaoImpl.RatingDaoImpl;
import DaoImpl.UserDaoImpl;
import Model.Award;
import Model.Event;
import Model.User;
import java.io.IOException;
import java.math.RoundingMode;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
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
public class EventController extends HttpServlet {

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
            throws ServletException, IOException, SQLException, ParseException {
        response.setContentType("text/html;charset=UTF-8");
        String command = request.getParameter("action");

        if (command != null) {
            switch (command) {
                case "registerEvent": // not sure if this method is being used
                    createEventByDirector(request, response);
                    break;
                case "triggerdss":
                    triggerDSS(request, response);
                    break;
                case "publish_event":
                    publish_event(request, response);
                    break;
                case "launch_event":
                    launch_event(request, response);
                    break;
                case "edit_weightage":
                    edit_weightage(request, response);
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
            Logger.getLogger(EventController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(EventController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(EventController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(EventController.class.getName()).log(Level.SEVERE, null, ex);
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

    private void createEventByDirector(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, ParseException {
        EventDao eventDao = new EventDaoImpl();
        HttpSession session = request.getSession();

        // get all params
        String eventName = request.getParameter("eventName");
        String sEventDueDate = request.getParameter("eventDueDate");
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM/dd/yyyy", Locale.ENGLISH);
        DateTimeFormatter final_formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd", Locale.ENGLISH);
        LocalDate eventDueDate = LocalDate.parse(sEventDueDate, formatter);
        String date = final_formatter.format(eventDueDate);

        String minCgpa = request.getParameter("minCgpa");
        String minMerit = request.getParameter("minMerit");
        String createdBy = request.getParameter("createdBy");

        // assign attributes to object ( Event )
        Event event = new Event();
        event.setEventName(eventName);
        event.setEventDate(date);
        event.setMinCgpa(Double.parseDouble(minCgpa));
        event.setMinMerit(Integer.parseInt(minMerit));
        event.setCreatedBy(Integer.parseInt(createdBy));
        event.setStatus("INACTIVE");
        event.setDss_status("not_yet");

        // set event year
        String year = date.substring(0, 4);
        event.setEventYear(Integer.parseInt(year));
        eventDao.createEvent(event);
        String message = "Event created!";
        session.setAttribute("successful_created_event_message", message);
        response.sendRedirect(request.getContextPath() + "/Program-Director/event-list.jsp");
    }

    private void triggerDSS(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {

        Integer eventid = Integer.parseInt(request.getParameter("eventid"));

        MeritRequestDao meritDao = new MeritRequestDaoImpl();
        CGPARequestDao cgpaDao = new CGPARequestDaoImpl();

        ArrayList<Integer> listUserIdOfApprovedCGPA = cgpaDao.getAllUserIdByApprovedStatus();
        ArrayList<Integer> listUserIdofApprovedMerit = meritDao.getAllUserIdByApprovedStatus();

        listUserIdOfApprovedCGPA.retainAll(listUserIdofApprovedMerit);

        AwardDao awarDao = new AwardDaoImpl();

        List<Award> awardlist = awarDao.find_awards_by_event_id(eventid);

        EventDao merit_dao = new EventDaoImpl();
        int merit_percentage = merit_dao.getPercentageByColumnNameAndEventId("merit", eventid);
        EventDao cgpa_dao = new EventDaoImpl();
        int cgpa_percentage = cgpa_dao.getPercentageByColumnNameAndEventId("cgpa", eventid);
        EventDao intangible_dao = new EventDaoImpl();
        int intangible_percentage = intangible_dao.getPercentageByColumnNameAndEventId("intangible", eventid);
        double merit_weightage = Math.round(merit_percentage * 100.0) / 100.0;
        double cgpa_weightage = Math.round(cgpa_percentage * 100.0) / 100.0;
        double intangible_weightage = Math.round(intangible_percentage * 100.0) / 100.0;

        for (Award award : awardlist) {

            double maxCGPA = 0, maxMerit = 0, maxIntangible = 0;

            String year = award.getYear_criteria();
            String gender = award.getGender_criteria();
            String program = award.getProgram_criteria();

            for (Integer userid : listUserIdOfApprovedCGPA) {
                UserDao userdao = new UserDaoImpl();
                User candidate = userdao.findById(userid);

                String candidateYear = "";

                if (candidate.getYearStudy() == 3) {
                    candidateYear = "year_3";
                } else {
                    candidateYear = "year_1_and_2";
                }

                if (candidateYear.equals(year) || year.equals("all")) {
                    if (gender.equals("all") || candidate.getGender().equals(gender)) {
                        if (program.equals("all") || candidate.getProgram().equals(program)) {

                            if (maxCGPA <= candidate.getCgpa()) {
                                maxCGPA = candidate.getCgpa();
                            }

                            if (maxMerit <= candidate.getMerit()) {
                                maxMerit = candidate.getMerit();
                            }

                            RatingDao ratingDao = new RatingDaoImpl();
                            double candidateRatingScore = ratingDao.averageRatingScore(candidate.getUserid());

                            if (maxIntangible <= candidateRatingScore) {
                                maxIntangible = candidateRatingScore;
                            }
                        }
                    }
                }
            }

            for (Integer userid : listUserIdOfApprovedCGPA) {
                UserDao userdao = new UserDaoImpl();
                User candidate = userdao.findById(userid);

                String candidateYear = "";

                if (candidate.getYearStudy() == 3) {
                    candidateYear = "year_3";
                } else {
                    candidateYear = "year_1_and_2";
                }

                if (candidateYear.equals(year) || year.equals("all")) {
                    if (gender.equals("all") || candidate.getGender().equals(gender)) {
                        if (program.equals("all") || candidate.getProgram().equals(program)) {

                            double merit = candidate.getMerit();
                            double cgpa = candidate.getCgpa();

                            RatingDao ratingDao = new RatingDaoImpl();

                            double rating = ratingDao.averageRatingScore(candidate.getUserid());

                            EventDao eventDao1 = new EventDaoImpl();

                            //(double meritWeightage, double cgpaWeightage, double intangibleWeightage, double meritMax, double cgpaMax, double intangibleMax, double meritValue, double cgpaValue, double intangibleValue)
                            double candidate_final_score = eventDao1.performDSS(merit_weightage, cgpa_weightage, intangible_weightage, maxMerit, maxCGPA, maxIntangible, merit, cgpa, rating);
                            candidate_final_score = candidate_final_score / 100.0;

                            AwardDao awardDao = new AwardDaoImpl();

                            DecimalFormat df = new DecimalFormat("#.##");
                            df.setRoundingMode(RoundingMode.CEILING);
                            String final_score_formatted = df.format(candidate_final_score);
                            double final_score = Double.parseDouble(final_score_formatted);

                            awardDao.saveDSS(award.getAward_id(), candidate.getUserid(), final_score);
                        }
                    }
                }

            }
        }

        EventDao eventDao44 = new EventDaoImpl();
        eventDao44.updateEventDSSStatus(eventid, "done");

        response.sendRedirect(request.getContextPath() + "/Program-Director/director-dashboard.jsp");

    }

    private void publish_event(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        Integer eventid = Integer.parseInt(request.getParameter("eventid"));

        EventDao eventDao = new EventDaoImpl();
        eventDao.updateEventStatusToCompleted(eventid);

        response.sendRedirect(request.getContextPath() + "/Program-Director/event-list.jsp");
    }

    private void launch_event(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        HttpSession session = request.getSession();
        Integer eventid = Integer.parseInt(request.getParameter("eventid"));

        EventDao eventDao = new EventDaoImpl();
        EventDao eventDao1 = new EventDaoImpl();

        session.removeAttribute("duplicate_live_event_message");
        if (eventDao1.getNumberOfRecordByEventStatus("LIVE") > 0) {
            session.setAttribute("duplicate_live_event_message", "There is an event that is ongoing currently. Launch failed.");
        } else {
            eventDao.updateEventStatusToLive(eventid);
        }

        response.sendRedirect(request.getContextPath() + "/Program-Director/event-list.jsp");
    }

    private void edit_weightage(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
        HttpSession session = request.getSession();
        Integer eventid = Integer.parseInt(request.getParameter("event_id"));
        Integer cgpa_percentage = Integer.parseInt(request.getParameter("cgpa_percentage"));
        Integer merit_percentage = Integer.parseInt(request.getParameter("merit_percentage"));
        Integer intangible_percentage = Integer.parseInt(request.getParameter("intangible_percentage"));

        int total_weightage = cgpa_percentage + merit_percentage + intangible_percentage;

        EventDao eventDao = new EventDaoImpl();

        session.removeAttribute("wrong_total_percentage");
        if (total_weightage != 100) {
            session.setAttribute("wrong_total_percentage", "Please make sure that total weightage is 100%");
            response.sendRedirect(request.getContextPath() + "/Program-Director/edit_weightage.jsp?event_id=" + eventid);
        } else {
            eventDao.updateEventWeightage(merit_percentage, cgpa_percentage, intangible_percentage, eventid);
            response.sendRedirect(request.getContextPath() + "/Program-Director/customize-weightage-form.jsp?eventid=" + eventid);
        }
    }
}
