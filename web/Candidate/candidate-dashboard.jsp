<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Objects"%>
<%@page import="DaoImpl.CGPARequestDaoImpl"%>
<%@page import="Dao.CGPARequestDao"%>
<%@page import="DaoImpl.MeritRequestDaoImpl"%>
<%@page import="Dao.MeritRequestDao"%>
<%@page import="Dao.AwardNomineeDao"%>
<%@page import="DaoImpl.AwardNomineeDaoImpl"%>
<%@page import="Model.Event"%>
<%@page import="DaoImpl.EventDaoImpl"%>
<%@page import="Dao.EventDao"%>
<%@page import="Model.Award"%>
<%@page import="DaoImpl.AwardDaoImpl"%>
<%@page import="Dao.AwardDao"%>
<%@page import="Model.User"%>
<%@page import="java.util.List"%>
<%@page import="Dao.UserDao"%>
<%@page import="DaoImpl.UserDaoImpl"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta name="theme-color" content="#000000" />
        <link rel="icon" sizes="76x76" href="../assets/img/logo-comtech.png" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.css" />
        <link rel="stylesheet" href="../assets/vendor/@fortawesome/fontawesome-free/css/all.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.1.1/tailwind.min.css" integrity="sha512-BAK6UB671tmfzrkeH1CacTvgHQ3aLAFnT2KsigdATsc5X7+3u42tb5vjmAoDiqtxphP5dNZ3cDygivTsGEJhGw==" crossorigin="anonymous" />
        <link rel="stylesheet" href="../assets/styles/tailwind.css" />
        <title>DSS CAS | Candidate Dashboard</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    </head>

    <body class="text-blueGray-700 antialiased">
        <%
            User logged_in_user = (User) request.getSession().getAttribute("logged_in_user");

            int eventid = 0;

            EventDao eventDao = new EventDaoImpl();
            EventDao eventDao1 = new EventDaoImpl();
            EventDao eventDao2 = new EventDaoImpl();

            Event currentEvent = new Event();
            List<Event> completedEventList = new ArrayList<>();

            if (Objects.isNull(eventDao.getLiveEvent().getStatus())) {
                completedEventList = eventDao1.getCompletedEvent();
            } else {
                currentEvent = eventDao2.getLiveEvent();
                eventid = currentEvent.getEventid();
            }
        %>
        <script src="https://unpkg.com/flowbite@1.4.7/dist/flowbite.js"></script>
        <div id="root">
            <nav class="md:left-0 md:block md:fixed md:top-0 md:bottom-0 md:overflow-y-auto md:flex-row md:flex-nowrap md:overflow-hidden shadow-xl bg-white flex flex-wrap items-center justify-between relative md:w-64 z-10 py-4 px-6">
                <div class="md:flex-col md:items-stretch md:min-h-full md:flex-nowrap px-0 flex flex-wrap items-center justify-between w-full mx-auto">
                    <button
                        class="cursor-pointer text-black opacity-50 md:hidden px-3 py-1 text-xl leading-none bg-transparent rounded border border-solid border-transparent"
                        type="button" onclick="toggleNavbar('example-collapse-sidebar')">
                        <i class="fas fa-bars"></i>
                    </button>
                    <a class="md:block text-left md:pb-2 text-blueGray-600 mr-0 inline-block whitespace-nowrap text-sm uppercase font-bold p-4 px-0"
                       href="../index.jsp">
                        <div class="flex-shrink-0 flex items-center px-4">
                            <img class="h-auto w-auto" src="../Images/Logo-DSS-CAS.png" alt="Application Logo"/>
                        </div>
                    </a>
                    <ul class="md:hidden items-center flex flex-wrap list-none">
                        <li class="inline-block relative">
                            <a class="text-blueGray-500 block py-1 px-3" href="#pablo"
                               onclick="openDropdown(event, 'notification-dropdown')"><i class="fas fa-bell"></i></a>
                            <div class="hidden bg-white text-base z-50 float-left py-2 list-none text-left rounded shadow-lg min-w-48" id="notification-dropdown">
                                <a href="#pablo"
                                   class="text-sm py-2 px-4 font-normal block w-full whitespace-nowrap bg-transparent text-blueGray-700">Action</a><a
                                   href="#pablo"
                                   class="text-sm py-2 px-4 font-normal block w-full whitespace-nowrap bg-transparent text-blueGray-700">Another
                                    action</a><a href="#pablo"
                                             class="text-sm py-2 px-4 font-normal block w-full whitespace-nowrap bg-transparent text-blueGray-700">Something
                                    else here</a>
                                <div class="h-0 my-2 border border-solid border-blueGray-100"></div>
                                <a href="#pablo"
                                   class="text-sm py-2 px-4 font-normal block w-full whitespace-nowrap bg-transparent text-blueGray-700">Seprated
                                    link</a>
                            </div>
                        </li>
                        <li class="inline-block relative">
                            <a class="text-blueGray-500 block" href="#pablo" onclick="openDropdown(event, 'user-responsive-dropdown')">
                                <div class="items-center flex">
                                    <span
                                        class="w-12 h-12 text-sm text-white bg-blueGray-200 inline-flex items-center justify-center rounded-full"><img
                                            alt="..." class="w-full rounded-full align-middle border-none shadow-lg"
                                            src="../assets/img/profile-picture.png" /></span>
                                </div>
                            </a>
                            <form method="post"  action="<%=request.getContextPath()%>/SignInController" class="hidden bg-white text-base z-50 float-left py-2 list-none text-left rounded shadow-lg min-w-48"
                                  id="user-responsive-dropdown">
                                <a href="#pablo" type="submit" name="action" value="sign_out"  class="uppercase text-blueGray-400 font-bold text-sm py-2 px-4 font-normal block w-full whitespace-nowrap bg-transparent hover:text-blueGray-700">
                                    Sign Out
                                </a>
                            </form>
                        </li>
                    </ul>
                    <div
                        class="md:flex md:flex-col md:items-stretch md:opacity-100 md:relative md:mt-4 md:shadow-none shadow absolute top-0 left-0 right-0 z-40 overflow-y-auto overflow-x-hidden h-auto items-center flex-1 rounded hidden"
                        id="example-collapse-sidebar">
                        <div class="md:min-w-full md:hidden block pb-4 mb-4 border-b border-solid border-blueGray-200">
                            <div class="flex flex-wrap">
                                <div class="w-6/12">
                                    <div class="flex-shrink-0 flex items-center px-4">
                                        <img class="h-auto w-auto" src="../Images/Logo-DSS-CAS.png" alt="Application Logo"/>
                                    </div>
                                </div>
                                <div class="w-6/12 flex justify-end">
                                    <button type="button"
                                            class="cursor-pointer text-black opacity-50 md:hidden px-3 py-1 text-xl leading-none bg-transparent rounded border border-solid border-transparent"
                                            onclick="toggleNavbar('example-collapse-sidebar')">
                                        <i class="fas fa-times"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <form class="mt-6 mb-4 md:hidden">
                            <div class="mb-3 pt-0">
                                <input type="text" placeholder="Search"
                                       class="border-0 px-3 py-2 h-12 border border-solid border-blueGray-500 placeholder-blueGray-300 text-blueGray-600 bg-white rounded text-base leading-snug shadow-none outline-none focus:outline-none w-full font-normal" />
                            </div>
                        </form>
                        <!-- Divider -->
                        <hr class="my-4 md:min-w-full" />
                        <!-- Heading -->
                        <h6 class="md:min-w-full text-blueGray-500 text-xs uppercase font-bold block pt-1 pb-4 no-underline">
                            Candidate Layout Pages
                        </h6>
                        <!-- Navigation -->

                        <ul class="md:flex-col md:min-w-full flex flex-col list-none">
                            <li class="items-center">
                                <a href="candidate-dashboard.jsp"
                                   class="text-xs uppercase py-3 font-bold block text-pink-500 hover:text-pink-600">
                                    <i class="fas fa-tv mr-2 text-sm opacity-75"></i>
                                    Dashboard
                                </a>
                            </li>

                            <li class="items-center">
                                <a href="merit-form.jsp"
                                   class="text-xs uppercase py-3 font-bold block text-blueGray-700 hover:text-blueGray-500">
                                    <i class="fa fa-upload mr-2 text-sm opacity-75"></i>
                                    Merit Submission
                                </a>
                            </li>

                            <li class="items-center">
                                <a href="cgpa-form.jsp"
                                   class="text-xs uppercase py-3 font-bold block text-blueGray-700 hover:text-blueGray-500">
                                    <i class="fa fa-upload mr-2 text-sm opacity-75"></i>
                                    CGPA Submission
                                </a>
                            </li>

                            <li class="items-center">
                                <a href="involvement-form.jsp"
                                   class="text-xs uppercase py-3 font-bold block text-blueGray-700 hover:text-blueGray-500">
                                    <i class="fa fa-upload mr-2 text-sm opacity-75"></i>
                                    Involvment Submission
                                </a>
                            </li>

                            <li class="items-center">
                                <a href="#"
                                   class="text-xs uppercase py-3 font-bold block text-blueGray-700 hover:text-blueGray-500">
                                    <i class="fas fa-user-circle mr-2 text-sm opacity-75"></i>
                                    Settings
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
            <div class="relative md:ml-64 bg-blueGray-50">
                <nav class="absolute top-0 left-0 w-full z-10 bg-transparent md:flex-row md:flex-nowrap md:justify-start flex items-center p-4">
                    <div class="w-full mx-autp items-center flex justify-between md:flex-nowrap flex-wrap md:px-10 px-4">
                        <a class="text-white text-sm uppercase hidden lg:inline-block font-semibold" href="sdc-dashboard.jsp">Dashboard | Student Development Committee</a>
                        <div class="flex items-center space-x-6">
                            <a class="text-white text-sm uppercase hidden lg:inline-block font-semibold">Due date: <%=currentEvent.getEventDate()%></a>
                            <ul class="flex-col md:flex-row list-none items-center hidden md:flex">
                                <a class="text-blueGray-500 block" href="#pablo" onclick="openDropdown(event, 'user-dropdown')">
                                    <div class="items-center flex">
                                        <span class="w-12 h-12 text-sm text-white bg-blueGray-200 inline-flex items-center justify-center rounded-full">
                                            <img alt="..." class="w-full rounded-full align-middle border-none shadow-lg" src="../assets/img/profile-picture.png"/>
                                        </span>
                                    </div>
                                </a>
                                <form method="post"  action="<%=request.getContextPath()%>/SignInController" class="hidden bg-white text-base z-50 float-left py-2 list-none text-left rounded shadow-lg min-w-48" id="user-dropdown">
                                    <button href="#pablo" type="submit" name="action" value="sign_out" class="uppercase text-blueGray-400 font-bold text-xs py-2 px-4 font-normal block w-full whitespace-nowrap bg-transparent hover:text-blueGray-700">
                                        Sign Out
                                    </button>
                                </form>
                            </ul>
                        </div>
                    </div>
                </nav>
                <!-- Header -->
                <div class="flex flex-col justify-between">
                    <div style="bg-gray-900">
                        <div class="relative bg-lightBlue-600 md:pt-20 pb-12">
                            <div class="px-4 md:px-10 mx-auto w-full">
                                <div class="flex flex-col justify-between">
                                    <div class="flex flex-wrap">
                                        <div class="w-full pb-6">
                                            <%
                                                if (currentEvent.getDss_status().equals("done")) {
                                            %>
                                            <div class="flex items-center bg-gray-900 rounded-lg m-4 px-6">
                                                <div class="p-2 bg-blueGray-200 rounded-lg my-4 flex space-x-2 text-white">
                                                    <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-gray-900" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                                                    <path stroke-linecap="round" stroke-linejoin="round" d="M11 5.882V19.24a1.76 1.76 0 01-3.417.592l-2.147-6.15M18 13a3 3 0 100-6M5.436 13.683A4.001 4.001 0 017 6h1.832c4.1 0 7.625-1.234 9.168-3v14c-1.543-1.766-5.067-3-9.168-3H7a3.988 3.988 0 01-1.564-.317z" />
                                                    </svg>
                                                </div>
                                                <div class="px-4 bg-blueGray-900">
                                                    <div class="relative w-full pr-4 max-w-full flex-grow flex-1">
                                                        <h5 class="text-blueGray-400 uppercase font-bold text-xs">
                                                            Announcement
                                                        </h5>
                                                        <span class="font-semibold text-md text-blueGray-200">
                                                            <%
                                                                if (eventid == 0) {
                                                            %>
                                                            No event available.
                                                            <%} else {%>
                                                            <%
                                                                if (currentEvent.getDss_status().equals("done")) {%>
                                                            DSS has been triggered! Winners will be announced soon!
                                                            <%} else {%>
                                                            DSS has not yet been triggered
                                                            <%}%>
                                                            <%}%>
                                                        </span>
                                                    </div> 
                                                </div>
                                            </div>
                                            <%
                                                }
                                            %>
                                        </div>
                                    </div>
                                    <!-- Card stats -->
                                    <%
                                        String eligible_award = "";
                                        User current_user = (User) request.getSession().getAttribute("logged_in_user");
                                        int number_of_eligible_awards = 0;
                                        AwardDao awardDao = new AwardDaoImpl();
                                        List<Award> awardList22 = awardDao.find_awards_by_event_id(eventid);
                                        for (Award award : awardList22) {
                                            String year_criteria = award.getYear_criteria();
                                            String program_criteria = award.getProgram_criteria();
                                            String gender_criteria = award.getGender_criteria();
                                            String student_year_criteria = "";
                                            if (current_user.getYearStudy() == 3) {
                                                student_year_criteria = "year_3";
                                            } else {
                                                student_year_criteria = "year_1_and_2";
                                            }
                                            if (student_year_criteria.equals(year_criteria) || year_criteria.equals("all")) {
                                                if (gender_criteria.equals("all") || current_user.getGender().equals(gender_criteria)) {
                                                    if (program_criteria.equals("all") || current_user.getProgram().equals(program_criteria)) {
                                                        eligible_award += award.getAward_name() + ", ";
                                                        number_of_eligible_awards++;
                                                    }
                                                }
                                            }
                                        }

                                    %>
                                    <div class="flex flex-wrap justify-center">
                                        <div class="w-full lg:w-6/12 xl:w-3/12 px-4">
                                            <div class="relative flex flex-col min-w-0 break-words bg-white rounded mb-6 xl:mb-0 shadow-lg">
                                                <div class="flex-auto p-4">
                                                    <div class="flex flex-wrap">
                                                        <div title="" class="relative w-full pr-4 max-w-full flex-grow flex-1">
                                                            <h5 title="<%=eligible_award%>" class="text-blueGray-400 uppercase font-bold text-xs">
                                                                Number of Eligible Awards
                                                            </h5>
                                                            <span class="font-semibold text-xl text-blueGray-700">
                                                                <%=number_of_eligible_awards%>
                                                            </span>
                                                        </div>
                                                        <div class="relative w-auto pl-4 flex-initial">
                                                            <div
                                                                class="text-white p-3 text-center inline-flex items-center justify-center w-12 h-12 shadow-lg rounded-full bg-red-500">
                                                                <i class="fa fa-trophy"></i>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <%
                                            MeritRequestDao dao = new MeritRequestDaoImpl();
                                        %>                    
                                        <div class="w-full lg:w-6/12 xl:w-3/12 px-4">
                                            <div class="relative flex flex-col min-w-0 break-words bg-white rounded mb-6 xl:mb-0 shadow-lg">
                                                <div class="flex-auto p-4">
                                                    <div class="flex flex-wrap">
                                                        <div class="relative w-full pr-4 max-w-full flex-grow flex-1">
                                                            <h5 class="text-blueGray-400 uppercase font-bold text-xs">
                                                                Merit Submission Status
                                                            </h5>
                                                            <span class="font-semibold text-lg text-blueGray-700">
                                                                <%=dao.getNumberOfRecordByUserId(current_user.getUserid()).equals(0) ? "NOT YET SUBMITTED" : "SUBMITTED"%>
                                                            </span>
                                                        </div>
                                                        <div class="relative w-auto pl-4 flex-initial">
                                                            <div
                                                                class="text-white p-3 text-center inline-flex items-center justify-center w-12 h-12 shadow-lg rounded-full bg-pink-500">
                                                                <i class="fa fa-upload"></i>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <%
                                            CGPARequestDao dao1 = new CGPARequestDaoImpl();
                                        %>                     
                                        <div class="w-full lg:w-6/12 xl:w-3/12 px-4">
                                            <div class="relative flex flex-col min-w-0 break-words bg-white rounded mb-6 xl:mb-0 shadow-lg">
                                                <div class="flex-auto p-4">
                                                    <div class="flex flex-wrap">
                                                        <div class="relative w-full pr-4 max-w-full flex-grow flex-1">
                                                            <h5 class="text-blueGray-400 uppercase font-bold text-xs">
                                                                CGPA Submission Status
                                                            </h5>
                                                            <span class="font-semibold text-lg text-blueGray-700">
                                                                <%=dao1.getNumberOfRecordByUserId(current_user.getUserid()).equals(0) ? "NOT YET SUBMITTED" : "SUBMITTED"%>
                                                            </span>
                                                        </div>
                                                        <div class="relative w-auto pl-4 flex-initial">
                                                            <div
                                                                class="text-white p-3 text-center inline-flex items-center justify-center w-12 h-12 shadow-lg rounded-full bg-orange-500">
                                                                <i class="fa fa-upload"></i>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="px-4 md:px-10 mx-auto w-full m-12">
                            <div class="flex flex-wrap mt-4">
                                <div class="w-full mb-12 xl:mb-0 px-4">
                                    <div class="relative flex flex-col min-w-0 break-words bg-white w-full mb-6 shadow-lg rounded">
                                        <div class="rounded-t mb-0 px-4 py-3 border-0">
                                            <div class="flex flex-wrap items-center">
                                                <div class="relative w-full px-4 max-w-full flex-grow flex-1">
                                                    <h3 class="uppercase font-semibold text-base text-blueGray-700">
                                                        List of winners
                                                    </h3>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="block w-full overflow-x-auto">
                                            <!-- Projects table -->
                                            <table class="items-center w-full bg-transparent border-collapse">
                                                <thead>
                                                    <tr>
                                                        <th
                                                            class="px-6 bg-blueGray-50 text-blueGray-500 align-middle border border-solid border-blueGray-100 py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left">
                                                            No.
                                                        </th>
                                                        <th
                                                            class="px-6 bg-blueGray-50 text-blueGray-500 align-middle border border-solid border-blueGray-100 py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left">
                                                            Award Name
                                                        </th>
                                                        <th
                                                            class="px-6 bg-blueGray-50 text-blueGray-500 align-middle border border-solid border-blueGray-100 py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left">
                                                            Winner
                                                        </th>
                                                        <th
                                                            class="px-6 bg-blueGray-50 text-blueGray-500 align-middle border border-solid border-blueGray-100 py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left">
                                                            Score
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <%
                                                    if (completedEventList.size() > 0) {
                                                        for (Event event : completedEventList) {

                                                            AwardDao awarddao99 = new AwardDaoImpl();
                                                            List<Award> completedAwards = awarddao99.find_awards_by_event_id(event.getEventid());
                                                            int complete_award_counter = 1;
                                                            for (Award award : completedAwards) {

                                                                AwardDao awarddao98 = new AwardDaoImpl();
                                                                int winnerid = awarddao98.getWinnerIdByAwardId(award.getAward_id());

                                                                UserDao userdao99 = new UserDaoImpl();
                                                                User candidate = userdao99.findById(winnerid);

                                                                AwardNomineeDao awardNomineeDao = new AwardNomineeDaoImpl();
                                                                double score = awardNomineeDao.getScoreByAwardIdNomineeId(award.getAward_id(), winnerid);
                                                %>

                                                <tbody>
                                                    <tr>
                                                        <th class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4 text-left">
                                                            <%=complete_award_counter%>.
                                                        </th>
                                                        <td class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4">
                                                            <%=award.getAward_name()%>
                                                        </td>
                                                        <td class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4">
                                                            <%=candidate.getName() == null ? "Undecided" : candidate.getName()%>
                                                        </td>
                                                        <td class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4">
                                                            <%=score%>
                                                        </td>
                                                    </tr>

                                                </tbody>
                                                <%
                                                        complete_award_counter++;
                                                    }

                                                %>

                                                <%                                                    }
                                                } else {
                                                %>

                                                <%
                                                    AwardDao awardDao33 = new AwardDaoImpl();
                                                    int counter = 1;
                                                    for (Award award : awardList22) {
                                                        int winnnerid = awardDao33.getWinnerIdByAwardId(award.getAward_id());

                                                        UserDao userDao3 = new UserDaoImpl();
                                                        User winner = userDao3.findById(winnnerid);
                                                        AwardNomineeDao awardNomineeDao = new AwardNomineeDaoImpl();
                                                        double score = awardNomineeDao.getScoreByAwardIdNomineeId(award.getAward_id(), winnnerid);


                                                %>
                                                <tbody>
                                                    <tr>
                                                        <th class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4 text-left">
                                                            <%=counter%>.
                                                        </th>
                                                        <td class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4">
                                                            <%=award.getAward_name()%>
                                                        </td>
                                                        <td class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4">
                                                            <%=winner.getName() == null ? "Undecided" : winner.getName()%>
                                                        </td>
                                                        <td class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4">
                                                            <%=score%>
                                                        </td>
                                                    </tr>

                                                </tbody>
                                                <%
                                                        counter++;
                                                    }
                                                %>

                                                <%}%>

                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class=" bg-lightBlue-600">
                        <div class="px-4 md:px-10 mx-auto w-full">
                            <div class="flex flex-col justify-between">
                                <div class="flex">
                                    <footer class="text-white w-full">
                                        <div class="border-blueGray-100">
                                            <div class="md:flex w-full sm:items-start sm:justify-between pt-8 pb-8">
                                                <div>
                                                    <h1 class="text-white text-sm uppercase hidden lg:inline-block font-semibold">&copy; 2022 - Aisyah</h1>
                                                </div>
                                                <div class="flex items-center space-x-2">
                                                    <svg class="h-6 w-6 inline-block fill-current text-blue-700" xmlns="http://www.w3.org/2000/svg"
                                                         viewBox="0 0 20 20">
                                                    <path d="M13 8V0L8.11 5.87 3 12h4v8L17 8h-4z" />
                                                    </svg>
                                                    <a class=" text-md font-semibold tracking-widest uppercase text-white"> 
                                                        DSS-CAS
                                                    </a>
                                                </div>
                                                <div>
                                                    <h1 class="text-white text-sm uppercase hidden lg:inline-block font-semibold">Reach me at t.me/aisyahamirahzamri</h1>
                                                </div>
                                            </div>
                                        </div>
                                    </footer>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js" charset="utf-8"></script>
        <script src="https://unpkg.com/@popperjs/core@2/dist/umd/popper.js"></script>

        <%            UserDao recordYearGenderDao = new UserDaoImpl();
            int one_female = recordYearGenderDao.getNumberOfRecordByYearAndGender(5, 1, "female");
            UserDao recordYearGenderDao1 = new UserDaoImpl();
            int one_male = recordYearGenderDao1.getNumberOfRecordByYearAndGender(5, 1, "female");
            UserDao recordYearGenderDao2 = new UserDaoImpl();
            int two_female = recordYearGenderDao2.getNumberOfRecordByYearAndGender(5, 2, "female");
            UserDao recordYearGenderDao3 = new UserDaoImpl();
            int two_male = recordYearGenderDao3.getNumberOfRecordByYearAndGender(5, 2, "male");
            UserDao recordYearGenderDao4 = new UserDaoImpl();
            int three_female = recordYearGenderDao4.getNumberOfRecordByYearAndGender(5, 3, "female");
            UserDao recordYearGenderDao5 = new UserDaoImpl();
            int three_male = recordYearGenderDao5.getNumberOfRecordByYearAndGender(5, 3, "female");

            UserDao recordProgramGenderDao = new UserDaoImpl();
            UserDao recordProgramGenderDao1 = new UserDaoImpl();
            UserDao recordProgramGenderDao2 = new UserDaoImpl();
            UserDao recordProgramGenderDao3 = new UserDaoImpl();
            UserDao recordProgramGenderDao4 = new UserDaoImpl();
            UserDao recordProgramGenderDao5 = new UserDaoImpl();
            int se_female = recordProgramGenderDao.getNumberOfRecordByProgramAndGender(5, "se", "female");
            int se_male = recordProgramGenderDao1.getNumberOfRecordByProgramAndGender(5, "se", "female");
            int im_female = recordProgramGenderDao2.getNumberOfRecordByProgramAndGender(5, "im", "female");
            int im_male = recordProgramGenderDao3.getNumberOfRecordByProgramAndGender(5, "im", "male");
            int kma_female = recordProgramGenderDao4.getNumberOfRecordByProgramAndGender(5, "kma", "female");
            int kma_male = recordProgramGenderDao5.getNumberOfRecordByProgramAndGender(5, "kma", "female");

            UserDao recordGenderDao = new UserDaoImpl();
            int female = recordGenderDao.getNumberOfRecordByGender(5, "female");
            UserDao recordGenderDao1 = new UserDaoImpl();
            int male = recordGenderDao1.getNumberOfRecordByGender(5, "male");
        %>

        <script type="text/javascript">
                                    /* Make dynamic date appear */
                                    (function () {
                                        if (document.getElementById("get-current-year")) {
                                            document.getElementById(
                                                    "get-current-year"
                                                    ).innerHTML = new Date().getFullYear();
                                        }
                                    })();
                                    /* Sidebar - Side navigation menu on mobile/responsive mode */
                                    function toggleNavbar(collapseID) {
                                        document.getElementById(collapseID).classList.toggle("hidden");
                                        document.getElementById(collapseID).classList.toggle("bg-white");
                                        document.getElementById(collapseID).classList.toggle("m-2");
                                        document.getElementById(collapseID).classList.toggle("py-3");
                                        document.getElementById(collapseID).classList.toggle("px-6");
                                    }
                                    /* Function for dropdowns */
                                    function openDropdown(event, dropdownID) {
                                        let element = event.target;
                                        while (element.nodeName !== "A") {
                                            element = element.parentNode;
                                        }
                                        Popper.createPopper(element, document.getElementById(dropdownID), {
                                            placement: "bottom-start",
                                        });
                                        document.getElementById(dropdownID).classList.toggle("hidden");
                                        document.getElementById(dropdownID).classList.toggle("block");
                                    }

                                    (function () {
                                        /* Chart initialisations */

                                        /* Bar Chart */
                                        config = {
                                            type: "bar",
                                            data: {
                                                labels: [
                                                    "Year 1",
                                                    "Year 2",
                                                    "Year 3",
                                                ],
                                                datasets: [
                                                    {
                                                        label: "Female",
                                                        backgroundColor: "#ed64a6",
                                                        borderColor: "#ed64a6",
                                                        data: [<%=one_female%>, <%=two_female%>, <%=three_female%>],
                                                        fill: false,
                                                        barThickness: 8,
                                                    },
                                                    {
                                                        label: "Male",
                                                        fill: false,
                                                        backgroundColor: "#4c51bf",
                                                        borderColor: "#4c51bf",
                                                        data: [<%=one_male%>, <%=two_male%>, <%=three_male%>],
                                                        barThickness: 8,
                                                    },
                                                ],
                                            },
                                            options: {
                                                maintainAspectRatio: false,
                                                responsive: true,
                                                title: {
                                                    display: false,
                                                    text: "Orders Chart",
                                                },
                                                tooltips: {
                                                    mode: "index",
                                                    intersect: false,
                                                },
                                                hover: {
                                                    mode: "nearest",
                                                    intersect: true,
                                                },
                                                legend: {
                                                    labels: {
                                                        fontColor: "rgba(0,0,0,.4)",
                                                    },
                                                    align: "end",
                                                    position: "bottom",
                                                },
                                                scales: {
                                                    xAxes: [
                                                        {
                                                            display: false,
                                                            scaleLabel: {
                                                                display: true,
                                                                labelString: "Month",
                                                            },
                                                            gridLines: {
                                                                borderDash: [2],
                                                                borderDashOffset: [2],
                                                                color: "rgba(33, 37, 41, 0.3)",
                                                                zeroLineColor: "rgba(33, 37, 41, 0.3)",
                                                                zeroLineBorderDash: [2],
                                                                zeroLineBorderDashOffset: [2],
                                                            },
                                                        },
                                                    ],
                                                    yAxes: [
                                                        {
                                                            display: true,
                                                            scaleLabel: {
                                                                display: false,
                                                                labelString: "Value",
                                                            },
                                                            gridLines: {
                                                                borderDash: [2],
                                                                drawBorder: false,
                                                                borderDashOffset: [2],
                                                                color: "rgba(33, 37, 41, 0.2)",
                                                                zeroLineColor: "rgba(33, 37, 41, 0.15)",
                                                                zeroLineBorderDash: [2],
                                                                zeroLineBorderDashOffset: [2],
                                                            },
                                                        },
                                                    ],
                                                },
                                            },
                                        };
                                        ctx = document.getElementById("bar-chart").getContext("2d");
                                        window.myBar = new Chart(ctx, config);

                                        config = {
                                            type: "bar",
                                            data: {
                                                labels: [
                                                    "Software Engineering",
                                                    "Informatic Maritime",
                                                    "Mobile Computing",
                                                ],
                                                datasets: [
                                                    {
                                                        label: "Female",
                                                        backgroundColor: "#ed64a6",
                                                        borderColor: "#ed64a6",
                                                        data: [<%=se_female%>, <%=im_female%>, <%=kma_female%>],
                                                        fill: false,
                                                        barThickness: 8,
                                                    },
                                                    {
                                                        label: "Male",
                                                        fill: false,
                                                        backgroundColor: "#4c51bf",
                                                        borderColor: "#4c51bf",
                                                        data: [<%=se_male%>, <%=im_male%>, <%=kma_male%>],
                                                        barThickness: 8,
                                                    },
                                                ],
                                            },
                                            options: {
                                                maintainAspectRatio: false,
                                                responsive: true,
                                                title: {
                                                    display: false,
                                                    text: "Orders Chart",
                                                },
                                                tooltips: {
                                                    mode: "index",
                                                    intersect: false,
                                                },
                                                hover: {
                                                    mode: "nearest",
                                                    intersect: true,
                                                },
                                                legend: {
                                                    labels: {
                                                        fontColor: "rgba(0,0,0,.4)",
                                                    },
                                                    align: "end",
                                                    position: "bottom",
                                                },
                                                scales: {
                                                    xAxes: [
                                                        {
                                                            display: false,
                                                            scaleLabel: {
                                                                display: true,
                                                                labelString: "Month",
                                                            },
                                                            gridLines: {
                                                                borderDash: [2],
                                                                borderDashOffset: [2],
                                                                color: "rgba(33, 37, 41, 0.3)",
                                                                zeroLineColor: "rgba(33, 37, 41, 0.3)",
                                                                zeroLineBorderDash: [2],
                                                                zeroLineBorderDashOffset: [2],
                                                            },
                                                        },
                                                    ],
                                                    yAxes: [
                                                        {
                                                            display: true,
                                                            scaleLabel: {
                                                                display: false,
                                                                labelString: "Value",
                                                            },
                                                            gridLines: {
                                                                borderDash: [2],
                                                                drawBorder: false,
                                                                borderDashOffset: [2],
                                                                color: "rgba(33, 37, 41, 0.2)",
                                                                zeroLineColor: "rgba(33, 37, 41, 0.15)",
                                                                zeroLineBorderDash: [2],
                                                                zeroLineBorderDashOffset: [2],
                                                            },
                                                        },
                                                    ],
                                                },
                                            },
                                        };
                                        ctx = document.getElementById("bar-chart2").getContext("2d");
                                        window.myBar = new Chart(ctx, config);


                                        config = {
                                            type: "bar",
                                            data: {
                                                labels: [
                                                    "Female",
                                                    "Male",
                                                ],
                                                datasets: [
                                                    {
                                                        label: "Female",
                                                        backgroundColor: "#ed64a6",
                                                        borderColor: "#ed64a6",
                                                        data: [<%=female%>, 0],
                                                        fill: false,
                                                        barThickness: 8,
                                                    },
                                                    {
                                                        label: "Male",
                                                        fill: false,
                                                        backgroundColor: "#4c51bf",
                                                        borderColor: "#4c51bf",
                                                        data: [0, <%=male%>],
                                                        barThickness: 8,
                                                    },
                                                ],
                                            },
                                            options: {
                                                maintainAspectRatio: false,
                                                responsive: true,
                                                title: {
                                                    display: false,
                                                    text: "Orders Chart",
                                                },
                                                tooltips: {
                                                    mode: "index",
                                                    intersect: false,
                                                },
                                                hover: {
                                                    mode: "nearest",
                                                    intersect: true,
                                                },
                                                legend: {
                                                    labels: {
                                                        fontColor: "rgba(0,0,0,.4)",
                                                    },
                                                    align: "end",
                                                    position: "bottom",
                                                },
                                                scales: {
                                                    xAxes: [
                                                        {
                                                            display: false,
                                                            scaleLabel: {
                                                                display: true,
                                                                labelString: "Month",
                                                            },
                                                            gridLines: {
                                                                borderDash: [2],
                                                                borderDashOffset: [2],
                                                                color: "rgba(33, 37, 41, 0.3)",
                                                                zeroLineColor: "rgba(33, 37, 41, 0.3)",
                                                                zeroLineBorderDash: [2],
                                                                zeroLineBorderDashOffset: [2],
                                                            },
                                                        },
                                                    ],
                                                    yAxes: [
                                                        {
                                                            display: true,
                                                            scaleLabel: {
                                                                display: false,
                                                                labelString: "Value",
                                                            },
                                                            gridLines: {
                                                                borderDash: [2],
                                                                drawBorder: false,
                                                                borderDashOffset: [2],
                                                                color: "rgba(33, 37, 41, 0.2)",
                                                                zeroLineColor: "rgba(33, 37, 41, 0.15)",
                                                                zeroLineBorderDash: [2],
                                                                zeroLineBorderDashOffset: [2],
                                                            },
                                                        },
                                                    ],
                                                },
                                            },
                                        };
                                        ctx = document.getElementById("bar-chart3").getContext("2d");
                                        window.myBar = new Chart(ctx, config);
                                    }
                                    )
                                            ();
        </script>
    </body>
</html>