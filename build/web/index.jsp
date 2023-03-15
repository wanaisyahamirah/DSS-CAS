<%@page import="DaoImpl.EventDaoImpl"%>
<%@page import="Dao.EventDao"%>
<%@page import="Dao.EventDao"%>
<%@page import="Model.Event"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>DSS CAS</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.1.1/tailwind.min.css" integrity="sha512-BAK6UB671tmfzrkeH1CacTvgHQ3aLAFnT2KsigdATsc5X7+3u42tb5vjmAoDiqtxphP5dNZ3cDygivTsGEJhGw==" crossorigin="anonymous" />
        <link rel="icon" href="Images/logo-comtech.png">
    </head>

    <body class="bg-gray-900">
        <%
            EventDao eventDao = new EventDaoImpl();
            Event currentEvent = eventDao.getLiveEvent();
        %>
        <script src="https://unpkg.com/flowbite@1.4.7/dist/flowbite.js"></script>
        <nav class="pb-4">
            <div class="max-w-7xl mx-auto pt-2">
                <div style="margin-top: 30px" class="hidden md:flex items-center justify-between h-16">
                    <div>
                        <svg class="h-6 w-6 inline-block fill-current text-blue-700" xmlns="http://www.w3.org/2000/svg"
                             viewBox="0 0 20 20">
                        <path d="M13 8V0L8.11 5.87 3 12h4v8L17 8h-4z" />
                        </svg>
                        <a href="index.jsp" class=" text-xl font-semibold tracking-widest uppercase text-white hover:text-indigo-200"> 
                            DSS-CAS
                        </a>
                    </div>
                    <div class="">
                        <div class="ml-4 flex items-center md:ml-6">
                            <!-- Profile dropdown -->
                            <div class="ml-3 relative flex space-x-3 text-gray-100 font-semibold">
                                <div>
                                    <a class="p-2 bg-blue-700 hover:bg-blue-900 uppercase tracking-widest text-md font-bold px-2 max-w-xs rounded-md flex items-center text-sm
                                       focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-gray-800 focus:ring-white"
                                       href="General-Pages/signin.jsp">
                                        Sign in
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="md:hidden flex items-center justify-center h-12">
                    <div class="md:hidden">
                        <div class="flex items-center">
                            <!-- Profile dropdown -->
                            <div class="flex space-x-3 text-gray-200 font-semibold items-center">

                                <div>
                                    <a class="px-2 max-w-xs uppercase bg-gray-900 rounded-sm flex items-center text-sm hover:underline focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-offset-gray-800 focus:ring-white">
                                        Sign In
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </nav>
        <div class="lg:flex lg:flex-col">
            <div class="w-full bg-gray-900">
                <div class="px-4 pb-10 sm:px-6">
                    <div class="rounded-lg">
                        <div class="sm:flex sm:items-center sm:justify-between max-w-7xl mx-auto">
                            <div class="sm:mt-0 sm:hidden flex flex-col justify-center bg-gray-300 rounded-full">
                                <div class="rounded-full">
                                    <img class="rounded-full" src="Images/Logo-DSS-CAS.png" alt="Logo DSS" />
                                </div>
                                <div class="text-gray-900 text-center flex flex-col justify-center h-full p-4">
                                    <p>Your all time fave decision maker!</p>
                                </div>
                            </div>
                            <div class="flex flex-col sm:pt-0">
                                <h1 class="sm:tracking-wider text-gray-100 lg:text-4xl text-xl font-bold mb-16 uppercase">
                                    COMTECH Appraisal System
                                </h1>
                                <p class="text-xl text-gray-100 font-semibold mb-2 pr-12">
                                    Decision Support System that implements Simple Additive Weighting (SAW) Algorithm
                                </p>
                                <p class="pt-2 text-md text-gray-200 pr-12">
                                    We provide a greater speed & efficiency for your decision-making activities. <span
                                        class="text-blue-500 hover:underline hover:text-white">Waste No Time, Let DSS
                                        decides!</span> <br>
                                    This system is designed to help clubs/organizations mobilized/operated in one of the
                                    instituitions in Malaysia <br>
                                    called Universiti Malaysia Terengganu or also known as UMT.

                                    <br><br>

                                    In this early development, the main focus of this system is to ease in appraising
                                    performances of the students <br>
                                    in COMTECH Club in order to decide on the best student for the specific awards.
                                    In the next coming years, <br> this system is hope to be expanded better.
                                </p>
                            </div>
                            <img class="hidden sm:block sm:h-96 sm:object-cover rounded-full border-4"
                                 src="Images/Logo-DSS-CAS.png" alt="Bilik Darjah" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="w-full bg-gray-900 py-12">
                <div>
                    <h1 class="sm:tracking-wider sm:text-center text-gray-100 lg:text-4xl text-xl font-bold mb-4 uppercase">
                        Available Features
                    </h1>
                </div>
                <div class="px-4 sm:px-6">
                    <div class="rounded-lg sm:py-6">
                        <div class="lg:flex lg:items-center sm:space-x-6 max-w-7xl mx-auto">
                            <div class="mx-auto sm:max-w-xl md:max-w-full lg:max-w-screen-xl">
                                <div class="grid gap-8 row-gap-5 lg:grid-cols-3">
                                    <div class="relative p-px overflow-hidden transition duration-300 transform rounded-lg shadow-sm hover:scale-105 group hover:shadow-xl">
                                        <div class="absolute bottom-0 left-0 w-full h-1 duration-300 origin-left transform scale-x-0 bg-deep-purple-accent-400 group-hover:scale-x-100"></div>
                                        <div class="absolute bottom-0 left-0 w-1 h-full duration-300 origin-bottom transform scale-y-0 bg-deep-purple-accent-400 group-hover:scale-y-100"></div>
                                        <div class="absolute top-0 left-0 w-full h-1 duration-300 origin-right transform scale-x-0 bg-deep-purple-accent-400 group-hover:scale-x-100"></div>
                                        <div class="absolute bottom-0 right-0 w-1 h-full duration-300 origin-top transform scale-y-0 bg-deep-purple-accent-400 group-hover:scale-y-100"></div>
                                        <div class="relative p-5 bg-white rounded-sm">
                                            <div class="flex flex-col mb-2 lg:items-center lg:flex-row">
                                                <div class="flex items-center justify-center w-10 h-10 mb-4 mr-2 rounded-full bg-indigo-200 lg:mb-0">
                                                    <svg class="w-8 h-8 text-deep-purple-accent-400" stroke="currentColor" viewBox="0 0 52 52">
                                                    <polygon stroke-width="3" stroke-linecap="round" stroke-linejoin="round" fill="none" points="29 13 14 29 25 29 23 39 38 23 27 23"></polygon>
                                                    </svg>
                                                </div>
                                                <h6 class="font-semibold leading-5">Trigger Decision Support System</h6>
                                            </div>
                                            <p class="mb-2 text-sm text-gray-900">
                                                Implementation of Simple Additive Weighting (SAW) algorithm to assist in decision making in the event.
                                            </p>
                                        </div>
                                    </div>
                                    <div class="relative p-px overflow-hidden transition duration-300 transform rounded-lg shadow-sm hover:scale-105 group hover:shadow-xl">
                                        <div class="absolute bottom-0 left-0 w-full h-1 duration-300 origin-left transform scale-x-0 bg-deep-purple-accent-400 group-hover:scale-x-100"></div>
                                        <div class="absolute bottom-0 left-0 w-1 h-full duration-300 origin-bottom transform scale-y-0 bg-deep-purple-accent-400 group-hover:scale-y-100"></div>
                                        <div class="absolute top-0 left-0 w-full h-1 duration-300 origin-right transform scale-x-0 bg-deep-purple-accent-400 group-hover:scale-x-100"></div>
                                        <div class="absolute bottom-0 right-0 w-1 h-full duration-300 origin-top transform scale-y-0 bg-deep-purple-accent-400 group-hover:scale-y-100"></div>
                                        <div class="relative p-5 bg-white rounded-sm">
                                            <div class="flex flex-col mb-2 lg:items-center lg:flex-row">
                                                <div class="flex items-center justify-center w-10 h-10 mb-4 mr-2 rounded-full bg-indigo-200 lg:mb-0">
                                                    <svg class="w-8 h-8 text-deep-purple-accent-400" stroke="currentColor" viewBox="0 0 52 52">
                                                    <polygon stroke-width="3" stroke-linecap="round" stroke-linejoin="round" fill="none" points="29 13 14 29 25 29 23 39 38 23 27 23"></polygon>
                                                    </svg>
                                                </div>
                                                <h6 class="font-semibold leading-5">High Authority Approval</h6>
                                            </div>
                                            <p class="mb-2 text-sm text-gray-900">
                                                Role, Merit and CGPA are undergoing approval process before actors are allowed to participate in the event.
                                            </p>
                                        </div>    
                                    </div>
                                    <div class="relative p-px overflow-hidden transition duration-300 transform rounded-lg shadow-sm hover:scale-105 group hover:shadow-xl">
                                        <div class="absolute bottom-0 left-0 w-full h-1 duration-300 origin-left transform scale-x-0 bg-deep-purple-accent-400 group-hover:scale-x-100"></div>
                                        <div class="absolute bottom-0 left-0 w-1 h-full duration-300 origin-bottom transform scale-y-0 bg-deep-purple-accent-400 group-hover:scale-y-100"></div>
                                        <div class="absolute top-0 left-0 w-full h-1 duration-300 origin-right transform scale-x-0 bg-deep-purple-accent-400 group-hover:scale-x-100"></div>
                                        <div class="absolute bottom-0 right-0 w-1 h-full duration-300 origin-top transform scale-y-0 bg-deep-purple-accent-400 group-hover:scale-y-100"></div>
                                        <div class="relative p-5 bg-white rounded-sm">
                                            <div class="flex flex-col mb-2 lg:items-center lg:flex-row">
                                                <div class="flex items-center justify-center w-10 h-10 mb-4 mr-2 rounded-full bg-indigo-200 lg:mb-0">
                                                    <svg class="w-8 h-8 text-deep-purple-accent-400" stroke="currentColor" viewBox="0 0 52 52">
                                                    <polygon stroke-width="3" stroke-linecap="round" stroke-linejoin="round" fill="none" points="29 13 14 29 25 29 23 39 38 23 27 23"></polygon>
                                                    </svg>
                                                </div>
                                                <h6 class="font-semibold leading-5">Transparency</h6>
                                            </div>
                                            <p class="mb-2 text-sm text-gray-900">
                                                Everyone gets to know the updates and how evaluation is done in the event.
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="w-full bg-gray-900 py-12">
                <div class="container mx-auto max-w-7xl">
                    <div class="w-full">
                        <div class="pb-8">
                            <h1 class="sm:tracking-wider sm:text-center text-gray-100 lg:text-4xl text-xl font-bold mb-4 uppercase">
                                Who are you?
                            </h1>
                        </div>
                        <div class="mx-auto sm:max-w-xl md:max-w-full lg:max-w-screen-xl ">
                            <div class="grid gap-6 row-gap-5 mb-8 lg:grid-cols-2 sm:row-gap-6 sm:grid-cols-1">
                                <a class="focus:ring-0" type="button" data-modal-toggle="authentication-modal">
                                    <div class="relative overflow-hidden transition duration-200 transform rounded shadow-lg hover:-translate-y-2 hover:shadow-2xl">
                                        <img class="object-cover w-full h-56 md:h-50 xl:h-80" src="https://www.umt.edu.my/highlight/konvo1920_02.jpg" alt="" />
                                        <div class="flex flex-col w-full text-center h-full flex justify-center items-center m-auto absolute inset-0 px-6 py-4 transition-opacity duration-200 bg-black bg-opacity-75 opacity-0 hover:opacity-100">
                                            <p class="mb-4 text-4xl font-bold text-gray-100">Student (Candidate)</p>
                                            <p class="p-2 bg-blue-700 uppercase tracking-widest text-md font-bold px-2 max-w-xs rounded-sm flex items-center text-sm text-white">
                                                Sign Up Now
                                            </p>
                                        </div>
                                    </div>
                                </a>

                                <!-- Main modal -->
                                <div id="authentication-modal" tabindex="-1" aria-hidden="true" class="hidden overflow-y-auto overflow-x-hidden fixed top-0 right-0 left-0 z-50 w-full md:inset-0 h-modal h-full">
                                    <div class="relative p-4 w-full max-w-4xl h-full md:h-auto">
                                        <!-- Modal content -->
                                        <div class="relative bg-white rounded-lg shadow dark:bg-gray-800 py-12">
                                            <button type="button" class="absolute top-3 right-2.5 text-gray-400 bg-transparent hover:bg-gray-200 hover:text-gray-900 rounded-lg text-sm p-1.5 ml-auto inline-flex items-center dark:hover:bg-gray-800 dark:hover:text-white" data-modal-toggle="authentication-modal">
                                                <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 20 20" xmlns="http://www.w3.org/2000/svg"><path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path></svg>  
                                            </button>
                                            <div class="py-6 px-6 lg:px-8">
                                                <h3 class="sm:tracking-wider  text-center justify-center items-center w-full mb-4 text-4xl font-bold text-gray-900 dark:text-white uppercase">Candidate Eligibility Verification</h3>

                                                <div class="text-center py-4">
                                                    <div class="p-2 bg-indigo-800 items-center text-indigo-100 leading-none lg:rounded-full flex lg:inline-flex" role="alert">
                                                        <span class="flex rounded-full bg-indigo-500 uppercase px-2 py-1 text-xs font-bold mr-3">Note</span>
                                                        <span class="font-semibold mr-2 text-left flex-auto">Application of candidate is only eligible for students with minimum  CGPA = <%=currentEvent.getMinCgpa() %> & Merit = <%=currentEvent.getMinMerit() %></span>
                                                    </div>
                                                </div>

                                                <div class="text-red-600">
                                                    <%
                                                        if (request.getSession().getAttribute("cgpa_merit_not_eligible") != null) {
                                                            String message = (String) request.getSession().getAttribute("cgpa_merit_not_eligible");
                                                    %>
                                                    <p><%= message%></p>
                                                    <%
                                                        }
                                                    %>
                                                </div>

                                                <form id="user-form" method="post" action="<%=request.getContextPath()%>/SignUpController">
                                                    <div>
                                                        <label for="cgpa" class="block mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">CGPA</label>
                                                        <input name="cgpa" id="cgpa" class="mb-2 bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" placeholder="3.00" required>
                                                    </div>
                                                    <div>
                                                        <label for="merit" class="block mt-2 mb-2 text-sm font-medium text-gray-900 dark:text-gray-300">Total Merit</label>
                                                        <input  name="merit" id="merit" placeholder="200" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5 dark:bg-gray-600 dark:border-gray-500 dark:placeholder-gray-400 dark:text-white" required>
                                                    </div>
                                                    <button type="submit" href="../Candidate/candidate-signup-verified.jsp" name="action" value="check_cgpa_merit" class=" mt-4 w-full text-white bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 text-center dark:bg-blue-600 dark:hover:bg-blue-700 dark:focus:ring-blue-800">Next</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div> 
                                <!--Modal [End]-->

                                <a href="Lecturer/lecturer-signup.jsp" aria-label="signup">
                                    <div class="relative overflow-hidden transition duration-200 transform rounded shadow-lg hover:-translate-y-2 hover:shadow-2xl">
                                        <img class="object-cover w-full h-56 md:h-50 xl:h-80" src="https://wallpapercave.com/wp/wp4385877.jpg" alt="" />
                                        <div class="flex flex-col w-full text-center h-full flex justify-center items-center m-auto absolute inset-0 px-6 py-4 transition-opacity duration-200 bg-black bg-opacity-75 opacity-0 hover:opacity-100">
                                            <p class="mb-4 text-4xl font-bold text-gray-100">Lecturer (Evaluator)</p>
                                            <p class="p-2 bg-blue-700 uppercase tracking-widest text-md font-bold px-2 max-w-xs rounded-sm flex items-center text-sm text-white">
                                                Sign Up Now
                                            </p>
                                        </div>
                                    </div>
                                </a>
                                <a href="Program-Director/director-signup.jsp" aria-label="signup">
                                    <div class="relative overflow-hidden transition duration-200 transform rounded shadow-lg hover:-translate-y-2 hover:shadow-2xl">
                                        <img class="object-cover w-full h-56 md:h-50 xl:h-80" src=https://www.betterteam.com/images/betterteam-programming-director-job-description-5732x3821-2021034.jpeg?crop=40:21,smart&width=1200&dpr=2 alt="" />
                                        <div class="flex flex-col w-full text-center h-full flex justify-center items-center m-auto absolute inset-0 px-6 py-4 transition-opacity duration-200 bg-black bg-opacity-75 opacity-0 hover:opacity-100">
                                            <p class="mb-4 text-4xl font-bold text-gray-100">Program Director (Organizer)</p>
                                            <p class="p-2 bg-blue-700 uppercase tracking-widest text-md font-bold px-2 max-w-xs rounded-sm flex items-center text-sm text-white">
                                                Sign Up Now
                                            </p>
                                        </div>
                                    </div>
                                </a>
                                <a href="Program-Committee/committee-signup.jsp" aria-label="signup">
                                    <div class=" overflow-hidden transition duration-200 transform rounded shadow-lg hover:-translate-y-2 hover:shadow-2xl flex h-fullscreen">
                                        <img class="object-cover w-full h-56 md:h-50 xl:h-80" src="https://images.pexels.com/photos/3184311/pexels-photo-3184311.jpeg?auto=compress&amp;cs=tinysrgb&amp;dpr=2&amp;w=500" alt="" />
                                        <div class="flex flex-col w-full text-center h-full flex justify-center items-center m-auto absolute inset-0 px-6 py-4 transition-opacity duration-200 bg-black bg-opacity-75 opacity-0 hover:opacity-100">
                                            <p class="mb-4 text-4xl font-bold text-gray-100">Program Committee</p>
                                            <p class="p-2 bg-blue-700 uppercase tracking-widest text-md font-bold px-2 max-w-xs rounded-sm flex items-center text-sm text-white">
                                                Sign Up Now
                                            </p>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="w-full bg-gray-900">
                <div class="px-4 pb-10 px-2 sm:px-6">
                    <div class="rounded-lg">
                        <div class="sm:flex sm:items-center sm:justify-between max-w-7xl mx-auto">
                            <img class="hidden sm:block sm:h-96 sm:object-cover rounded-full border-4 border-blue-300"
                                 src="Images/profile-picture.png" alt="Profile-Picture" />
                            <div class="flex flex-col sm:pt-0">
                                <h1 class="sm:tracking-wider text-gray-100 lg:text-4xl text-xl font-bold mb-16 uppercase">
                                    MASTERMIND
                                </h1>
                                <p class="text-xl text-gray-100 font-semibold mb-2 pr-12">
                                    Greetings, everyone ! I am Wan Aisyah Amirah Binti Wan Mohd Zamri !
                                </p>
                                <p class="pt-2 text-md text-gray-200 pr-12">
                                    A final-year Software Engineering undergraduate at Universiti Malaysia Terengganu (UMT) majoring in <br>
                                    Computer Science and expected to graduate in November 2023. A passionate full-stack developer <br>
                                    and a vice secretary of COMTECH Club 2021/2022.

                                    <br><br>

                                    This website is designed for the purpose of my Final Year Project. The idea came from the problems <br>
                                    found when my team and I were conducting Majlis Anugerah Mahasiwa Cemerlang COMTECH on <br> 31st of January 2022.
                                    It came to realization that having this website would be so much helpful for <br> such award-event management.
                                    Therefore, here I am making the realization into reality.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="w-full bg-gray-700">
                <footer class="bg-gray-900 text-white">
                    <div class="max-w-7xl mx-auto">
                        <div class="md:flex sm:items-start sm:justify-between pt-24 pb-12">
                            <div>
                                <h1>&copy; 2022 This webstie is owned by Aisyah</h1>
                            </div>
                            <div>
                                <svg class="h-6 w-6 inline-block fill-current text-blue-700" xmlns="http://www.w3.org/2000/svg"
                                     viewBox="0 0 20 20">
                                <path d="M13 8V0L8.11 5.87 3 12h4v8L17 8h-4z" />
                                </svg>
                                <a class=" text-xl font-semibold tracking-widest uppercase text-white"> 
                                    DSS-CAS
                                </a>
                            </div>
                            <div>
                                <h1>Reach me at t.me/aisyahamirahzamri</h1>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
    </body>

</html>