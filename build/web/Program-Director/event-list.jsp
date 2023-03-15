<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Locale"%>
<%@page import="Model.Event"%>
<%@page import="DaoImpl.EventDaoImpl"%>
<%@page import="Dao.EventDao"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="Dao.UserDao"%>
<%@page import="DaoImpl.UserDaoImpl"%>
<%@page import="Model.CGPARequest"%>
<%@page import="java.util.List"%>
<%@page import="DaoImpl.CGPARequestDaoImpl"%>
<%@page import="Dao.CGPARequestDao"%>
<%@page import="Model.User"%>


<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <meta name="theme-color" content="#000000" />
        <link rel="icon" sizes="76x76" href="../assets/img/logo-comtech.png" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.css" />
        <link rel="stylesheet" href="../assets/vendor/@fortawesome/fontawesome-free/css/all.min.css" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.1.1/tailwind.min.css" integrity="sha512-BAK6UB671tmfzrkeH1CacTvgHQ3aLAFnT2KsigdATsc5X7+3u42tb5vjmAoDiqtxphP5dNZ3cDygivTsGEJhGw==" crossorigin="anonymous" />
        <link rel="stylesheet" href="../assets/styles/tailwind.css" />
        <title>DSS CAS | Event List</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    </head>

    <body class="text-blueGray-700 antialiased">
        <%
            User logged_in_user = (User) request.getSession().getAttribute("logged_in_user");
            int eventid = Integer.parseInt(request.getParameter("eventid"));
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
                            Director Layout Pages
                        </h6>
                        <!-- Navigation -->
                        <ul class="md:flex-col md:min-w-full flex flex-col list-none">
                            <li class="items-center">
                                <a href="director-dashboard.jsp"
                                   class="text-xs uppercase py-3 font-bold block text-blueGray-700 hover:text-blueGray-500">
                                    <i class="fas fa-tv mr-2 text-sm opacity-75"></i>
                                    Dashboard
                                </a>
                            </li>

                            <li class="items-center">
                                <a href="event-list.jsp"
                                   class="text-xs uppercase py-3 font-bold block text-pink-500 hover:text-pink-600">
                                    <i class="fa fa-calendar mr-2 text-sm opacity-75"></i>
                                    Event
                                </a>
                            </li>

                            <li class="items-center">
                                <a href="#"
                                   class="text-xs uppercase py-3 font-bold block text-blueGray-700 hover:text-blueGray-500">
                                    <i class="fa fa-list-alt mr-2 text-sm opacity-75"></i>
                                    History
                                </a>
                            </li>

                            <li class="items-center">
                                <a href="customize-weightage-form.jsp?eventid=<%=eventid%>"
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
                        <a class="text-white text-sm uppercase hidden lg:inline-block font-semibold" href="event-list.jsp">Event List | Program Director</a>
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
                </nav>

                <div class="flex flex-col justify-between">
                    <div style="bg-gray-900">
                        <div class="relative bg-lightBlue-600 md:pt-20">
                            <div class="px-4 md:px-10 mx-auto w-full">
                                <div class="flex flex-col justify-between">
                                    <div class="flex flex-wrap">
                                        <div class="w-full pb-6">
                                            <%
                                                String duplicate_live_event_message = (String) request.getSession().getAttribute("duplicate_live_event_message");
                                                if (duplicate_live_event_message != null) {
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
                                                            <%=duplicate_live_event_message %>
                                                        </span>
                                                    </div> 
                                                </div>
                                            </div>
                                            <%
                                                }
                                            %>
                                        </div>
                                    </div>
                                </div>    
                            </div>
                        </div>
                        <div class="px-4 md:px-10 mx-auto w-full m-12">
                            <div class="flex flex-wrap mt-4">
                                <!--Insert Content Here-->

                                <div class="w-full mb-12 xl:mb-0 px-4">
                                    <div class="relative flex flex-col min-w-0 break-words bg-white w-full mb-6 shadow-lg rounded">
                                        <div class="rounded-t mb-0 px-4 py-3 border-0">
                                            <div class="flex flex-wrap items-center">
                                                <div class="relative w-full px-4 max-w-full flex-grow flex-1">
                                                    <h3 class="uppercase font-semibold text-base text-blueGray-700">
                                                        List of Events
                                                    </h3>
                                                </div>
                                                <div class="relative w-full px-4 max-w-full flex-grow flex-1 text-right">
                                                    <a href="event-form.jsp" class="bg-indigo-500 text-white active:bg-indigo-600 text-xs font-bold uppercase px-3 py-1 rounded outline-none focus:outline-none mr-1 mb-1 ease-linear transition-all duration-150">
                                                        Create New Event
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="block w-full overflow-x-auto">
                                            <!-- Projects table -->
                                            <table class="items-center w-full bg-transparent border-collapse">
                                                <thead>
                                                    <tr>
                                                        <th class="px-6 bg-blueGray-50 text-blueGray-500 align-middle border border-solid border-blueGray-100 py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left">
                                                            No.
                                                        </th>
                                                        <th class="px-6 bg-blueGray-50 text-blueGray-500 align-middle border border-solid border-blueGray-100 py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left">
                                                            Event Name
                                                        </th>
                                                        <th class="px-6 bg-blueGray-50 text-blueGray-500 align-middle border border-solid border-blueGray-100 py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left">
                                                            Due Date
                                                        </th>
                                                        <th class="px-6 bg-blueGray-50 text-blueGray-500 align-middle border border-solid border-blueGray-100 py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left">
                                                            Minimum CGPA                                                        
                                                        </th>
                                                        <th class="px-6 bg-blueGray-50 text-blueGray-500 align-middle border border-solid border-blueGray-100 py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left">
                                                            Minimum Merit
                                                        </th>
                                                        <th class="px-6 bg-blueGray-50 text-blueGray-500 align-middle border border-solid border-blueGray-100 py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left">
                                                            Status
                                                        </th>
                                                        <th class="px-6 bg-blueGray-50 text-blueGray-500 align-middle border border-solid border-blueGray-100 py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left">
                                                            Action
                                                        </th>
                                                        <th class="px-6 bg-blueGray-50 text-blueGray-500 align-middle border border-solid border-blueGray-100 py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left">

                                                        </th>
                                                    </tr>
                                                </thead>
                                                <%
                                                    int counter = 1;
                                                    EventDao eventDao = new EventDaoImpl();
                                                    List<Event> eventList = eventDao.getAllEvents();
                                                    for (Event event : eventList) {
                                                %>   
                                                <tbody>
                                                    <tr>
                                                        <th class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4 text-left">
                                                            <%=counter%>.
                                                        </th>
                                                        <td class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4">
                                                            <%
                                                                String link = "award-list.jsp?eventid=" + event.getEventid();
                                                            %>
                                                            <a style="pointer-events: <%=!event.getStatus().equals("INACTIVE") ? "pointer" : "none"%>" class="hover:text-gray-200" href="<%=!event.getStatus().equals("INACTIVE") ? link : "#"%>"><%=event.getEventName()%></a>
                                                        </td>
                                                        <%
                                                            SimpleDateFormat month_date = new SimpleDateFormat("MMM yyyy", Locale.ENGLISH);
                                                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

                                                            Date date = sdf.parse(event.getEventDate());

                                                            String month_name = month_date.format(date);
                                                            String day = event.getEventDate().substring(8, 10);
                                                        %>
                                                        <td class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4">
                                                            Date: <%=day%> <%=month_name%>
                                                        </td>
                                                        <%
                                                            DecimalFormat df = new DecimalFormat("0.00");
                                                            double min_cgpa = event.getMinCgpa();
                                                        %>
                                                        <td class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4">
                                                            <%=df.format(min_cgpa)%>
                                                        </td>
                                                        <td class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4">
                                                            <%=event.getMinMerit()%>
                                                        </td>

                                                        <%
                                                            if (event.getStatus().equals("LIVE")) {
                                                        %>
                                                        <td class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4">
                                                            <span class="relative inline-block px-3 py-1 font-semibold text-green-900 leading-tight">
                                                                <span class="absolute inset-0 bg-green-200 opacity-50 rounded-full"></span>
                                                                <span class="relative"><%=event.getStatus()%></span>
                                                            </span>
                                                        </td>
                                                        <%
                                                            }
                                                        %>
                                                        <%
                                                            if (event.getStatus().equals("INACTIVE")) {
                                                        %>
                                                        <td class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4">
                                                            <span class="relative inline-block px-3 py-1 font-semibold text-red-900 leading-tight">
                                                                <span class="absolute inset-0 bg-red-200 opacity-50 rounded-full"></span>
                                                                <span class="relative"><%=event.getStatus()%></span>
                                                            </span>
                                                        </td>
                                                        <%
                                                            }
                                                        %>

                                                        <%
                                                            if (event.getStatus().equals("COMPLETED")) {
                                                        %>
                                                        <td class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4">
                                                            <span class="relative inline-block px-3 py-1 font-semibold text-gray-900 leading-tight">
                                                                <span class="absolute inset-0 bg-gray-200 opacity-50 rounded-full"></span>
                                                                <span class="relative"><%=event.getStatus()%></span>
                                                            </span>
                                                        </td>
                                                        <%
                                                            }
                                                        %>


                                                        <%
                                                            if (event.getStatus().equals("LIVE") && !event.getDss_status().equals("not_yet")) {
                                                        %>
                                                        <td class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4">
                                                            <form method="POST" action="<%=request.getContextPath()%>/EventController">
                                                                <input type="hidden" name="eventid" value="<%=event.getEventid()%>">
                                                                <button type="submit" name="action" value="publish_event" class="w-full px-4 py-1 text-green-300 font-light tracking-wider bg-green-900 rounded hover:bg-green-300 hover:text-green-900">
                                                                    Publish
                                                                </button>
                                                            </form>
                                                        </td>
                                                        <%
                                                            }
                                                        %>
                                                        <%
                                                            if (event.getStatus().equals("INACTIVE")) {
                                                        %>
                                                        <td class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4">
                                                            <form method="POST" action="<%=request.getContextPath()%>/EventController">
                                                                <input type="hidden" name="eventid" value="<%=event.getEventid()%>">
                                                                <button type="submit" name="action" value="launch_event" class="w-full px-4 py-1 text-red-300 font-light tracking-wider bg-red-900 rounded hover:bg-red-300 hover:text-red-900">
                                                                    Launch
                                                                </button>
                                                            </form>
                                                        </td>
                                                        <%
                                                            }
                                                        %>
                                                        <%
                                                            if (event.getStatus().equals("COMPLETED")) {
                                                        %>
                                                        <td class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4">
                                                            <button disabled class="w-full px-4 py-1 text-gray-300 font-light tracking-wider bg-gray-400 rounded hover:bg-gray-300 hover:text-gray-900">
                                                                Disabled
                                                            </button>
                                                        </td>
                                                        <%
                                                            }
                                                        %>

                                                        <%
                                                            if (event.getDss_status().equals("not_yet") && event.getStatus().equals("LIVE")) {

                                                        %>
                                                        <td class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4">
                                                            <form method="POST" action="<%=request.getContextPath()%>/EventController">
                                                                <input type="hidden" name="eventid" value="<%=event.getEventid()%>">
                                                                <button type="submit" name="action" value="triggerdss" class="w-full px-4 py-1 text-green-200 font-light tracking-wider bg-green-900 rounded hover:bg-green-300 hover:text-green-900">
                                                                    Trigger DSS
                                                                </button>
                                                            </form>
                                                        </td>
                                                        <%
                                                            }
                                                        %>


                                                    </tr>

                                                </tbody>
                                                <%
                                                        counter++;
                                                    }
                                                %>
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
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js" charset="utf-8"></script>
    <script src="https://unpkg.com/@popperjs/core@2/dist/umd/popper.js"></script>
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
                                                "January",
                                                "February",
                                                "March",
                                                "April",
                                                "May",
                                                "June",
                                                "July",
                                            ],
                                            datasets: [
                                                {
                                                    label: new Date().getFullYear(),
                                                    backgroundColor: "#ed64a6",
                                                    borderColor: "#ed64a6",
                                                    data: [30, 78, 56, 34, 100, 45, 13],
                                                    fill: false,
                                                    barThickness: 8,
                                                },
                                                {
                                                    label: new Date().getFullYear() - 1,
                                                    fill: false,
                                                    backgroundColor: "#4c51bf",
                                                    borderColor: "#4c51bf",
                                                    data: [27, 68, 86, 74, 10, 4, 87],
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
                                })();
    </script>
</body>
</html>
