<!DOCTYPE html>
<html lang="en">
    <head>
        <title>DSS CAS | Lecturer Sign Up</title>
        <script src="//unpkg.com/alpinejs" defer></script>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.1.1/tailwind.min.css" integrity="sha512-BAK6UB671tmfzrkeH1CacTvgHQ3aLAFnT2KsigdATsc5X7+3u42tb5vjmAoDiqtxphP5dNZ3cDygivTsGEJhGw==" crossorigin="anonymous" />
        <link rel="icon" href="../Images/logo-comtech.png">
    </head>
    <body class="bg-gray-900">
        <nav class="pb-4">
            <div class="max-w-7xl mx-auto pt-2">
                <div style="margin-top: 30px" class="hidden md:flex items-center justify-between h-16">
                    <div>
                        <svg class="h-6 w-6 inline-block fill-current text-blue-700" xmlns="http://www.w3.org/2000/svg"
                             viewBox="0 0 20 20">
                        <path d="M13 8V0L8.11 5.87 3 12h4v8L17 8h-4z" />
                        </svg>
                        <a href="../index.jsp" class=" text-xl font-semibold tracking-widest uppercase text-white hover:text-indigo-200"> 
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
        <div class="w-full lg:flex lg:flex-col bg-gray-900">
            <main class="px-4 pb-10 sm:px focus:outline-none">
                <div class="max-w-7xl mx-auto px-4 sm:px-6 md:px-8">
                    <div class="py-2">
                        <div class="bg-gray-100 px-4 py-5 sm:rounded-lg rounded-md sm:p-6">
                            <div class="text-red-400">
                                <% if (session.getAttribute("numberExistenceError") != null) {
                                        String message = (String) session.getAttribute("numberExistenceError");%>

                                <%= message%>
                                <% }%>
                                <% if (session.getAttribute("lowerCaseError") != null) {
                                        String message = (String) session.getAttribute("lowerCaseError");%>

                                <%= message%>
                                <% }%>
                                <% if (session.getAttribute("uppercaseError") != null) {
                                        String message = (String) session.getAttribute("uppercaseError");%>

                                <%= message%>
                                <% }%>
                                <% if (session.getAttribute("eightCharacterError") != null) {
                                        String message = (String) session.getAttribute("eightCharacterError");%>

                                <%= message%>
                                <% }%>
                                <% if (session.getAttribute("repeatPasswordError") != null) {
                                        String message = (String) session.getAttribute("repeatPasswordError");%>

                                <%= message%>
                                <% }%>
                                <% if (session.getAttribute("cgpa_merit_not_qualified_error") != null) {
                                        String message = (String) session.getAttribute("cgpa_merit_not_qualified_error");%>

                                <%= message%>
                                <% }%>
                                   <% if (session.getAttribute("record_exists") != null) {
                                        String message = (String) session.getAttribute("record_exists");%>

                                <%= message%>
                                <% }%>
                            </div>
                            <form id="user-form" method="post" action="<%=request.getContextPath()%>/SignUpController"> <!--.-->
                                <div>
                                    <div class="mt-4 grid grid-cols-1 gap-y-6 gap-x-4 sm:grid-cols-6">
                                        <div class="sm:col-span-6">
                                            <label class="block text-sm font-bold text-gray-700 pb-2">
                                                Gender
                                            </label>
                                            <div class="flex space-x-4">
                                                <div class="flex items-center">
                                                    <input value="male" name="gender" type="radio" id="male" class="transition duration-500 mr-1 focus:ring-green-500 h-4 w-4 text-green-500 border-gray-300">
                                                    <label for="male" class="text-sm font-medium text-gray-700">Male</label>
                                                </div>
                                                <div class="flex items-center">
                                                    <input value="female" name="gender" type="radio" id="female" class="transition duration-500 mr-1 focus:ring-green-500 h-4 w-4 text-green-500 border-gray-300">
                                                    <label for="female" class="text-sm font-medium text-gray-700">Female</label>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="sm:col-span-3">
                                            <label for="fullName" class="block text-sm font-bold text-gray-700">
                                                Full Name
                                            </label>
                                            <div class="mt-1 relative rounded-md shadow-sm">
                                                <input name="fullName" id="fullName" class="transition duration-500 shadow-sm block w-full sm:text-sm border-gray-300 rounded-md p-2" placeholder="Insert your full name">
                                            </div>
                                        </div>
                                        <div class="sm:col-span-3">
                                            <label for="username" class="block text-sm font-bold text-gray-700">
                                                Staff Number
                                            </label>
                                            <div class="mt-1 relative rounded-md shadow-sm">
                                                <input name="username" id="username" class="transition duration-500 shadow-sm block w-full sm:text-sm border-gray-300 rounded-md p-2" placeholder="Insert your matric number">
                                            </div>
                                        </div>
                                        <div class="sm:col-span-3">
                                            <label for="password" class="block text-sm font-bold text-gray-700">
                                                Password
                                            </label>
                                            <div class="mt-1 relative rounded-md shadow-sm">
                                                <input type="password" name="password" id="password" class="transition duration-500 shadow-sm block w-full sm:text-sm border-gray-300 rounded-md p-2" placeholder="Insert your password">
                                            </div>
                                        </div>
                                        <div class="sm:col-span-3">
                                            <label for="rePassword" class="block text-sm font-bold text-gray-700">
                                                Re-Enter Password
                                            </label>
                                            <div class="mt-1 relative rounded-md shadow-sm">
                                                <input type="password" name="rePassword" id="rePassword" class="transition duration-500 shadow-sm block w-full sm:text-sm border-gray-300 rounded-md p-2" placeholder="Re-enter your password">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="mt-5 border-t border-gray-200 pt-5">
                                    <span class="block w-full rounded-md shadow-sm">
                                        <button type="submit" name="action" value="register_lecturer" class="transition duration-500 w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-800 focus:outline-none focus:ring-2 focus:ring-offset-2 ring-offset-blue-700 focus:ring-blue-900 uppercase">
                                            Sign Up
                                        </button>
                                    </span>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </body>
</html>
