<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>DSS CAS | Sign In</title>
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
<!--                            <h3 class="sm:tracking-wider  text-center justify-center items-center w-full mb-4 text-4xl font-bold text-gray-700 dark:text-white">
                                Sign In
                            </h3>-->
                            <div class="text-red-400">
                                <%  if (request.getSession().getAttribute("successful_candidate_signup_process") != null) {
                                        String message = (String) request.getSession().getAttribute("successful_candidate_signup_process");
                                %>
                                <div><%= message%></div>
                                
                                <%
                                    }
                                %>
                                
                                <%  if (request.getSession().getAttribute("successful_director_signup_process") != null) {
                                        String message = (String) request.getSession().getAttribute("successful_director_signup_process");
                                %>
                                <div><%= message%></div>
                                
                                <%
                                    }
                                %>

                                <%  if (request.getSession().getAttribute("signin_message") != null) {
                                        String message = (String) request.getSession().getAttribute("signin_message");
                                %>
                                <div><%= message%></div>
                                <%
                                    }
                                %>

                                <%  if (request.getSession().getAttribute("authentication_failed") != null) {
                                        String message = (String) request.getSession().getAttribute("authentication_failed");
                                %>
                                <div><%= message%></div>
                                <%
                                    }
                                %>

                                <%  if (request.getSession().getAttribute("logout_message") != null) {
                                        String message = (String) request.getSession().getAttribute("logout_message");
                                %>
                                <div><%= message%></div>
                                <%
                                    }
                                %>
                            </div>
                            <form id="user-form" method="post"  action="<%=request.getContextPath()%>/SignInController">
                                <div>
                                    <div class="">
                                        <div class="mt-2">
                                            <label for="username" class="block text-sm font-bold text-gray-700">
                                                Matric / Staff Number
                                            </label>
                                            <div class="mt-1 relative rounded-md shadow-sm">
                                                <input name="username" id="username" class="transition duration-500 shadow-sm block w-full sm:text-sm border-gray-300 rounded-md p-2" placeholder="Insert Your Matric / Staff Number">
                                            </div>
                                        </div>
                                        <div class="mt-4">
                                            <label for="password" class="mt-2 block text-sm font-bold text-gray-700">
                                                Password
                                            </label>
                                            <div class="mt-1 relative rounded-md shadow-sm">
                                                <input type="password" name="password" id="password" class="transition duration-500 shadow-sm block w-full sm:text-sm border-gray-300 rounded-md p-2" placeholder="Insert Your Password">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="mt-5 border-t border-gray-200 pt-5">
                                    <span class="block w-full rounded-md shadow-sm">
                                        <button type="submit" name="action" value="sign_in" class="transition duration-500 w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-blue-600 hover:bg-blue-800 focus:outline-none focus:ring-2 focus:ring-offset-2 ring-offset-blue-700 focus:ring-blue-900">
                                            Sign in
                                        </button>
                                    </span>
                                </div>
                            </form>
                            <div class="mt-6 flex items-center justify-center">
                                <div class="text-sm">
                                    <a href="../index.jsp" class="duration-500 font-medium text-blue-500 hover:text-gray-900">
                                        No account? Sign up
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
        <script src="@{/js/alpine.js}"></script>
        <script replace="fragments/alerts :: alert-js"></script>
    </body>
</html>