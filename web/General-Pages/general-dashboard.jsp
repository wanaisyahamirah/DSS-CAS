<%@page import="Model.User"%>
<%@page import="Dao.UserDao"%>
<%@page import="DaoImpl.UserDaoImpl"%>
<%@page import="java.util.Locale"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="Model.Event"%>
<%@page import="DaoImpl.EventDaoImpl"%>
<%@page import="Dao.EventDao"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:th="http://www.thymeleaf.org"
      lang="en">
  <head>
    <meta charset="UTF-8">
      <title>DSS CAS | Director Dashboard</title>
      <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
      <meta name="viewport" content="width=device-width, initial-scale=1"/>
      <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.1.1/tailwind.min.css" integrity="sha512-BAK6UB671tmfzrkeH1CacTvgHQ3aLAFnT2KsigdATsc5X7+3u42tb5vjmAoDiqtxphP5dNZ3cDygivTsGEJhGw==" crossorigin="anonymous" />
  </head>
  <body>
    <div class="h-screen flex overflow-hidden bg-gray-100"
         x-data="sidebarMenu()"
         @keydown.window.escape="closeSidebar">
      <!-- Off-canvas menu for mobile -->
      <div class="md:hidden"
           x-show="isVisible()">
        <div class="fixed inset-0 flex z-40">
          <!--
            Off-canvas menu overlay
          -->
          <div class="fixed inset-0" aria-hidden="true"
               x-show="isVisible()"
               x-cloak
               x-transition:enter="transition-opacity ease-linear duration-300"
               x-transition:enter-start="opacity-0"
               x-transition:enter-end="opacity-100"
               x-transition:leave="transition-opacity ease-linear duration-300"
               x-transition:leave-start="opacity-100"
               x-transition:leave-end="opacity-0">
            <div class="absolute inset-0 bg-gray-600 opacity-75"></div>
          </div>
          <!--
            Off-canvas menu
          -->
          <div class="relative flex-1 flex flex-col max-w-xs w-full pt-5 pb-4 bg-white"
               x-show="isVisible()"
               x-cloak
               x-transition:enter="transition ease-in-out duration-300 transform"
               x-transition:enter-start="-translate-x-full"
               x-transition:enter-end="translate-x-0"
               x-transition:leave="transition ease-in-out duration-300 transform"
               x-transition:leave-start="translate-x-0"
               x-transition:leave-end="-translate-x-full">
            <div class="absolute top-0 right-0 -mr-12 pt-2">
              <!--
                Close sidebar menu button
              -->
              <button class="ml-1 flex items-center justify-center h-10 w-10 rounded-full focus:outline-none focus:ring-2 focus:ring-inset focus:ring-white"
                      @click="closeSidebar">
                <span class="sr-only">Close sidebar</span>
                <!-- Heroicon name: x -->
                <svg class="h-6 w-6 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                </svg>
              </button>
            </div>
            <div class="flex-shrink-0 flex items-center px-4">
              <img class="h-10 w-auto"
                   src="/Images/Logo-DSS-CAS.png" alt="Application Logo"/>
            </div>
            <div class="mt-5 flex-1 h-0 overflow-y-auto">
              <nav class="px-2 space-y-1">
                <!-- Current: "bg-gray-100 text-gray-900", Default: "text-gray-600 hover:bg-gray-50 hover:text-gray-900" -->
                <a href="../Program-Director/director-dashboard.html" class="bg-gray-100 text-gray-900 group flex items-center px-2 py-2 text-sm font-medium rounded-md">
                  <!-- Current: "text-gray-500", Default: "text-gray-400 group-hover:text-gray-500" -->
                  <!-- Heroicon name: home -->
                  <svg class="text-gray-500 mr-3 h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
                  </svg>
                  Dashboard
                </a>

                <a href="../Program-Director/create-event.jsp" class="text-gray-600 hover:bg-gray-50 hover:text-gray-900 group flex items-center px-2 py-2 text-sm font-medium rounded-md">
                  <!-- Heroicon name: users -->
                  <svg class="text-gray-400 group-hover:text-gray-500 mr-3 h-6 w-6" xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path d="M12 14l9-5-9-5-9 5 9 5z" />
                    <path d="M12 14l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14z" />
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 14l9-5-9-5-9 5 9 5zm0 0l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14zm-4 6v-7.5l4-2.222" />
                  </svg>
                  Event
                </a>
              </nav>
            </div>
          </div>
          <div class="flex-shrink-0 w-14" aria-hidden="true">
            <!-- Dummy element to force sidebar to shrink to fit close icon -->
          </div>
        </div>
      </div>

      <!-- Static sidebar for desktop -->
      <div class="hidden md:flex md:flex-shrink-0">
        <div class="flex flex-col w-64">
          <div class="flex flex-col flex-grow border-r border-gray-200 pt-5 pb-4 bg-white overflow-y-auto">
            <div class="flex items-center flex-shrink-0 px-4">
              <img class="h-auto w-auto" src="../Images/Logo-DSS-CAS.png" alt="Application Logo"/>
            </div>
            <div class="mt-5 flex-grow flex flex-col">
              <nav class="flex-1 px-2 bg-white space-y-1">
                <!-- Current: "bg-gray-100 text-gray-900", Default: "text-gray-600 hover:bg-gray-50 hover:text-gray-900" -->
                <a href="../Program-Director/director-dashboard.jsp" class="bg-gray-100 text-gray-900 group flex items-center px-2 py-2 text-sm font-medium rounded-md">
                  <!-- Current: "text-gray-500", Default: "text-gray-400 group-hover:text-gray-500" -->
                  <!-- Heroicon name: home -->
                  <svg class="text-gray-500 mr-3 h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
                  </svg>
                  Dashboard
                </a>

                <a href="../Program-Director/create-event.jsp?" class="text-gray-600 hover:bg-gray-50 hover:text-gray-900 group flex items-center px-2 py-2 text-sm font-medium rounded-md">
                  <!-- Heroicon name: users -->
                  <svg class="text-gray-400 group-hover:text-gray-500 mr-3 h-6 w-6" xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                    <path d="M12 14l9-5-9-5-9 5 9 5z" />
                    <path d="M12 14l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14z" />
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 14l9-5-9-5-9 5 9 5zm0 0l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14zm-4 6v-7.5l4-2.222" />
                  </svg>
                  Event
                </a>
              </nav>
            </div>
          </div>
        </div>
      </div>

      <div class="flex flex-col w-0 flex-1 overflow-hidden">

        <div class="relative z-10 flex-shrink-0 flex h-16 bg-white shadow">
          <button class="px-4 border-r border-gray-200 text-gray-500 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-indigo-500 md:hidden"
                  @click.stop="openSidebar">
            <span class="sr-only">Open sidebar</span>
            <!-- Heroicon name: menu-alt-2 -->
            <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h7" />
            </svg>
          </button>
          <div class="flex-1 px-4 flex justify-between">
            <div class="flex items-center w-full justify-between">
              <div class="p-2 space-y-4 rounded-lg">
                <div class="flex items-center" x-data="{ open: false }">
                  <button class="transition px-4 py-2 bg-gray-400 hover:bg-gray-700 text-white rounded-full border-none focus:outline-none"
                          @click="open = true">
                    Change to Candidate
                  </button>
                  <div class="fixed z-1 w-full h-full top-0 left-0 flex items-center justify-center" x-cloak x-show="open">
                    <div class="fixed w-full h-full bg-gray-500 opacity-50">

                    </div>
                    <div class="relative z-2 w-3/12 bg-white p-8 mx-auto rounded-xl flex flex-col items-center" @click.away="open = false">
                      <p class="pb-4">Do you want to be a candidate for the awards?</p>
                      <div class="flex space-x-2">
                        <button class="px-4 py-2 bg-red-400 hover:bg-red-700 text-white rounded-full border-none focus:outline-none" @click="open = false">No</button>
                        <!-- button bawah buat jadi form, hantar user id, role id, dan seterusnya, untuk request table -->
                        <form action="servlethere">
                          <input type="hidden" name="user_id" id="" value="">
                            <input type="hidden" name="role_id" value="">
                              <button type="submit" class="px-4 py-2 bg-green-400 hover:bg-green-700 text-white rounded-full border-none focus:outline-none" @click="open = false">
                                Yes
                              </button>
                              </form>
                              </div>
                              </div>  
                              </div>
                              </div>
                              </div>
                              <div class="p-2 space-y-4 rounded-lg">
                                <div class="flex items-center" x-data="{ open: false }">
                                  <a href="event-form.jsp" class="transition px-4 py-2 bg-gray-400 hover:bg-gray-700 text-white rounded-full border-none focus:outline-none"">Create Event</a>
                                  <div class="fixed z-1 w-full h-full top-0 left-0 flex items-center justify-center" x-cloak x-show="open">
                                    <div class="fixed w-full h-full bg-gray-500 opacity-50">

                                    </div>
                                    <div class="relative z-2 w-3/12 bg-white p-8 mx-auto rounded-xl flex flex-col items-center" @click.away="open = false">
                                      <p class="pb-4">Do you want to trigger DSS now?</p>
                                      <div class="flex space-x-2">
                                        <button class="px-4 py-2 bg-red-400 hover:bg-red-700 text-white rounded-full border-none focus:outline-none" @click="open = false">
                                          N
                                        </button>
                                        <!-- button bawah buat jadi form, hantar user id, role id, dan seterusnya, untuk request table -->
                                        <form action="servlethere">
                                          <input type="hidden" name="user_id" id="" value="">
                                            <input type="hidden" name="role_id" value="">
                                              <button type="submit" class="px-4 py-2 bg-green-400 hover:bg-green-700 text-white rounded-full border-none focus:outline-none" @click="open = false">
                                                Yes
                                              </button>
                                              </form>
                                              </div>
                                              </div>  
                                              </div>
                                              </div>
                                              </div>
                                              </div>
                                              <div class="ml-4 flex items-center md:ml-6">

                                                <!-- Profile dropdown -->
                                                <div class="ml-3 relative"
                                                     x-data="userPopupMenu()"
                                                     @click.away="close"
                                                     @keydown.window.escape="close">
                                                  <div>
                                                    <button class="max-w-xs bg-white flex items-center text-sm rounded-full focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" id="user-menu" aria-haspopup="true"
                                                            @click="toggleVisibility">
                                                      <span class="sr-only">
                                                        Open user menu
                                                      </span>
                                                      <img class="h-8 w-8 rounded-full" src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80" alt="">
                                                    </button>
                                                  </div>
                                                  <!--Profile drop down panel-->
                                                  <div class="origin-top-right absolute right-0 mt-2 w-48 rounded-md shadow-lg py-1 bg-white ring-1 ring-black ring-opacity-5" role="menu" aria-orientation="vertical" aria-labelledby="user-menu"
                                                       x-show="isVisible()" x-cloak x-transition:enter="transition ease-out duration-100 transform" x-transition:enter-start="opacity-0 scale-95" x-transition:enter-end="opacity-100 scale-100"
                                                       x-transition:leave="transition ease-in duration-75 transform" x-transition:leave-start="opacity-100 scale-100" x-transition:leave-end="opacity-0 scale-95">
                                                    <form class="flex flex-col" id="logout-form" method="post"  action="<%=request.getContextPath()%>/SignInController"> <!--.-->
                                                      <button type="submit" name="action" value="sign_out" class="px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 focus:outline-none">
                                                        Sign out
                                                      </button>
                                                    </form>
                                                  </div>
                                                </div>
                                              </div>
                                              </div>
                                              </div>

                                              <main class="flex-1 relative overflow-y-auto focus:outline-none" tabindex="0">
                                                <div class="py-6">
                                                  <div class="max-w-7xl mx-auto px-4 sm:px-6 md:px-8">
                                                    <h1 class="text-2xl font-semibold text-gray-900">General Dashboard</h1>
                                                  </div>
                                                  <div class="max-w-7xl mx-auto px-4 sm:px-6 md:px-8">
                                                    <!-- Replace with your content -->
                                                    <div class="pt-2">
                                                      <div class="flex justify-between">
                                                        <h1 class="tracking-wider">Candidate List</h1>
                                                      </div>
                                                      <div class="py-2 flex flex-wrap w-full">
                                                        <div class="py-2 flex flex-wrap w-full">
                                                          <!-- Loop display all created event -->
                                                          <%
                                                              UserDao userDao = new UserDaoImpl();
                                                              List<Integer> candidateList = userDao.findUsersByRoleId(5);
                                                              int candidate_counter = 1;
                                                              for (Integer user_id : candidateList) {
                                                                  UserDao userDao1 = new UserDaoImpl();
                                                                  User user = userDao1.findById(user_id);
                                                          %>
                                                          <div class="space-y-2 w-full rounded-md border border-gray-900 my-2 text-center overflow-hidden">
                                                            <p href="../Program-Director/award-list.html" class="flex bg-gray-200 px-4 py-2 font-bold items-center"><%=candidate_counter %>. <%=user.getName() %></p>
                                                          </div>
                                                          <%
                                                                  candidate_counter++;
                                                              }
                                                          %>
                                                        </div>
                                                      </div>
                                                    </div>
                                                    <!-- /End replace -->
                                                  </div>
                                                </div>
                                              </main>
                                              </div>
                                              </div>
                                              <script src="https://unpkg.com/alpinejs@3.7.0/dist/cdn.min.js" defer></script>
                                              <script>

                                                  function sidebarMenu() {
                                                      return {
                                                          show: false,
                                                          openSidebar() {
                                                              this.show = true;
                                                          },
                                                          closeSidebar() {
                                                              this.show = false;
                                                          },
                                                          isVisible() {
                                                              return this.show === true;
                                                          }
                                                      };
                                                  }

                                                  function userPopupMenu() {
                                                      return {
                                                          show: false,
                                                          toggleVisibility() {
                                                              this.show = !this.show;
                                                          },
                                                          close() {
                                                              this.show = false;
                                                          },
                                                          isVisible() {
                                                              return this.show === true;
                                                          }
                                                      };
                                                  }
                                              </script>
                                              </body>
                                              </html>