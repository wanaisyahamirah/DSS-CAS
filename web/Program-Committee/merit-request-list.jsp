<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Objects"%>
<%@page import="Model.MeritRequest"%>
<%@page import="DaoImpl.MeritRequestDaoImpl"%>
<%@page import="Dao.MeritRequestDao"%>
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
        <title>DSS CAS | Merit Request List</title>
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
                            Committee Layout Pages
                        </h6>
                        <!-- Navigation -->

                        <ul class="md:flex-col md:min-w-full flex flex-col list-none">
                            <li class="items-center">
                                <a href="committee-dashboard.jsp"
                                   class="text-xs uppercase py-3 font-bold block text-blueGray-700 hover:text-blueGray-500">
                                    <i class="fas fa-tv mr-2 text-sm opacity-75"></i>
                                    Dashboard
                                </a>
                            </li>

                            <li class="items-center">
                                <a href="award-list.jsp?eventid=<%=eventid%>"
                                   class="text-xs uppercase py-3 font-bold block text-blueGray-700 hover:text-blueGray-500">
                                    <i class="fa fa-trophy mr-2 text-sm opacity-75"></i>
                                    Award
                                </a>
                            </li>

                            <li class="items-center">
                                <a href="merit-request-list.jsp"
                                   class="text-xs uppercase py-3 font-bold block text-pink-500 hover:text-pink-600">
                                    <i class="fa fa-list-alt mr-2 text-sm opacity-75"></i>
                                    Merit Request
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
                        <a class="text-white text-sm uppercase hidden lg:inline-block font-semibold" href="cgpa-request-list.jsp">Merit Request List | Program Committee</a>
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
                                        <div class="w-full mb-12 xl:mb-0 px-4">
                                            <div class="relative flex flex-col min-w-0 break-words bg-white w-full mb-6 shadow-lg rounded">

                                            </div>
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
                                                        Merit Request List
                                                    </h3>
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
                                                            Matric Number
                                                        </th>
                                                        <th class="px-6 bg-blueGray-50 text-blueGray-500 align-middle border border-solid border-blueGray-100 py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left">
                                                            Candidate Name
                                                        </th>
                                                        <th class="px-6 bg-blueGray-50 text-blueGray-500 align-middle border border-solid border-blueGray-100 py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left">
                                                            Merit Value
                                                        </th>
                                                        <th class="px-6 bg-blueGray-50 text-blueGray-500 align-middle border border-solid border-blueGray-100 py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left">
                                                            Evidence
                                                        </th>
                                                        <th class="px-6 bg-blueGray-50 text-blueGray-500 align-middle border border-solid border-blueGray-100 py-3 text-xs uppercase border-l-0 border-r-0 whitespace-nowrap font-semibold text-left">
                                                            Action
                                                        </th>
                                                    </tr>
                                                </thead>
                                                <%
                                                    MeritRequestDao meritRequestDao = new MeritRequestDaoImpl();
                                                    List<MeritRequest> requestList = meritRequestDao.listPendingMeritRequest();
                                                    User user;
                                                    int listCounter = 1;
                                                    for (MeritRequest meritRequest : requestList) {
                                                        UserDao userDao = new UserDaoImpl();
                                                        user = userDao.findById(meritRequest.getUser_id());
                                                %>
                                                <tbody>
                                                    <tr>
                                                        <th class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4 text-left">
                                                            <%=listCounter%>.
                                                        </th>
                                                        <td class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4">
                                                            <%=user.getUsername()%>
                                                        </td>
                                                        <td class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4">
                                                            <%=user.getName()%>
                                                        </td>
                                                        <td class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4">
                                                            <%=meritRequest.getMerit_value()%>
                                                        </td>
                                                        <td class="border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4">
                                                            <form action="<%=request.getContextPath()%>/MeritRequestController" method="GET">
                                                                <input name="requestId" value="<%=meritRequest.getRequest_id()%>" type="hidden"/>
                                                                <button type="submit" name="action" value="view_evidence" class="text-sm px-4 py-2 bg-gray-100 text-gray-900 border border-gray-900 rounded-md hover:bg-gray-500 hover:text-white transition duration-500 focus:outline-none">View Evidence</button>
                                                            </form>
                                                        </td>
                                                        <td class="flex border-t-0 px-6 align-middle border-l-0 border-r-0 text-xs whitespace-nowrap p-4">
                                                            <form id="form" action="<%=request.getContextPath()%>/MeritRequestController" class="pl-0 p-6 text-left" method="post">
                                                                <input type="hidden" name="managedBy" value="<%=logged_in_user.getUserid()%>">
                                                                <input type="hidden" name="candidateid" value="<%=meritRequest.getUser_id()%>">
                                                                <input type="hidden" name="requestId" value="<%=meritRequest.getRequest_id()%>">
                                                                <input type="hidden" name="meritValue" value="<%=meritRequest.getMerit_value()%>">
                                                                <button type="submit" name="action" value="approveMeritRequest" 
                                                                        data-modal-toggle="popup-modal-approve-merit-<%=meritRequest.getRequest_id()%>" type="button" class="text-white bg-green-600 hover:bg-green-800 focus:ring-4 focus:outline-none focus:ring-red-300 dark:focus:ring-red-800 font-medium rounded-lg text-sm inline-flex items-center px-5 py-2.5 text-center mr-2">
                                                                    Approve
                                                                </button>
                                                            </form>
                                                            <form id="form" action="<%=request.getContextPath()%>/MeritRequestController" class="pl-0 p-6 text-left" method="post">
                                                                <input type="hidden" name="managedBy" value="<%=logged_in_user.getUserid()%>">
                                                                <input type="hidden" name="requestId" value="<%=meritRequest.getRequest_id()%>">
                                                                <button type="submit" name="action" value="rejectMeritRequest" 
                                                                        data-modal-toggle="popup-modal-approve-merit-<%=meritRequest.getRequest_id()%>" type="button" class="text-white bg-red-600 hover:bg-red-800 focus:ring-4 focus:outline-none focus:ring-red-300 dark:focus:ring-red-800 font-medium rounded-lg text-sm inline-flex items-center px-5 py-2.5 text-center mr-2">
                                                                    Reject
                                                                </button>
                                                            </form>
                                                        </td>
                                                    </tr>

                                                </tbody>
                                                <%
                                                        listCounter++;
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
                                }
                                )
                                        ();


        </script>
    </body>
</html>
