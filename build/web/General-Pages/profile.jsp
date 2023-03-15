<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"
      xmlns:th="http://www.thymeleaf.org"
      lang="en">
    <head>
        <meta charset="UTF-8">
        <title>DSS CAS | Profile</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
        <meta name="viewport" content="width=device-width, initial-scale=1"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tailwindcss/2.1.1/tailwind.min.css" integrity="sha512-BAK6UB671tmfzrkeH1CacTvgHQ3aLAFnT2KsigdATsc5X7+3u42tb5vjmAoDiqtxphP5dNZ3cDygivTsGEJhGw==" crossorigin="anonymous" />
        <link rel="icon" href="../Images/logo-comtech.png">
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
                                 th:src="/Images/Logo-DSS-CAS.png" alt="Application Logo"/>
                        </div>
                        <div class="mt-5 flex-1 h-0 overflow-y-auto">
                            <nav class="px-2 space-y-1">
                                <!-- Current: "bg-gray-100 text-gray-900", Default: "text-gray-600 hover:bg-gray-50 hover:text-gray-900" -->
                                <a href="#" class="text-gray-900 group flex items-center px-2 py-2 text-sm font-medium rounded-md">
                                    <!-- Current: "text-gray-500", Default: "text-gray-400 group-hover:text-gray-500" -->
                                    <!-- Heroicon name: home -->
                                    <svg class="text-gray-500 mr-3 h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
                                    </svg>
                                    Dashboard
                                </a>

                                <a href="#" class="text-gray-600 hover:bg-gray-50 hover:text-gray-900 group flex items-center px-2 py-2 text-sm font-medium rounded-md">
                                    <!-- Heroicon name: users -->
                                    <svg class="text-gray-400 group-hover:text-gray-500 mr-3 h-6 w-6" xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path d="M12 14l9-5-9-5-9 5 9 5z" />
                                        <path d="M12 14l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14z" />
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 14l9-5-9-5-9 5 9 5zm0 0l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14zm-4 6v-7.5l4-2.222" />
                                    </svg>
                                    Award
                                </a>

                                <a href="#" class="text-gray-600 hover:bg-gray-50 hover:text-gray-900 group flex items-center px-2 py-2 text-sm font-medium rounded-md">
                                    <!-- Heroicon name: folder -->
                                    <svg class="text-gray-400 group-hover:text-gray-500 mr-3 h-6 w-6" xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z" />
                                    </svg>
                                    Merit
                                </a>

                                <a href="#" class="text-gray-600 hover:bg-gray-50 hover:text-gray-900 group flex items-center px-2 py-2 text-sm font-medium rounded-md">
                                    <!-- Heroicon name: calendar -->
                                    <svg class="text-gray-400 group-hover:text-gray-500 mr-3 h-6 w-6" xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                                    </svg>
                                    CGPA 
                                </a>

                                <a href="#" class="text-gray-600 hover:bg-gray-50 hover:text-gray-900 group flex items-center px-2 py-2 text-sm font-medium rounded-md">
                                    <!-- Heroicon name: calendar -->
                                    <svg class="text-gray-400 group-hover:text-gray-500 mr-3 h-6 w-6" xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
                                    </svg>
                                    Involvement
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
                                <a href="#" class="text-gray-900 group flex items-center px-2 py-2 text-sm font-medium rounded-md">
                                    <!-- Current: "text-gray-500", Default: "text-gray-400 group-hover:text-gray-500" -->
                                    <!-- Heroicon name: home -->
                                    <svg class="text-gray-500 mr-3 h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 12l2-2m0 0l7-7 7 7M5 10v10a1 1 0 001 1h3m10-11l2 2m-2-2v10a1 1 0 01-1 1h-3m-6 0a1 1 0 001-1v-4a1 1 0 011-1h2a1 1 0 011 1v4a1 1 0 001 1m-6 0h6" />
                                    </svg>
                                    Dashboard
                                </a>

                                <a href="#" class="text-gray-600 hover:bg-gray-50 hover:text-gray-900 group flex items-center px-2 py-2 text-sm font-medium rounded-md">
                                    <!-- Heroicon name: users -->
                                    <svg class="text-gray-400 group-hover:text-gray-500 mr-3 h-6 w-6" xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path d="M12 14l9-5-9-5-9 5 9 5z" />
                                        <path d="M12 14l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14z" />
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 14l9-5-9-5-9 5 9 5zm0 0l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14zm-4 6v-7.5l4-2.222" />
                                    </svg>
                                    Award
                                </a>

                                <a href="#" class="text-gray-600 hover:bg-gray-50 hover:text-gray-900 group flex items-center px-2 py-2 text-sm font-medium rounded-md">
                                    <!-- Heroicon name: folder -->
                                    <svg class="text-gray-400 group-hover:text-gray-500 mr-3 h-6 w-6" xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z" />
                                    </svg>
                                    Merit
                                </a>

                                <a href="#" class="text-gray-600 hover:bg-gray-50 hover:text-gray-900 group flex items-center px-2 py-2 text-sm font-medium rounded-md">
                                    <!-- Heroicon name: calendar -->
                                    <svg class="text-gray-400 group-hover:text-gray-500 mr-3 h-6 w-6" xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
                                    </svg>
                                    CGPA 
                                </a>

                                <a href="#" class="text-gray-600 hover:bg-gray-50 hover:text-gray-900 group flex items-center px-2 py-2 text-sm font-medium rounded-md">
                                    <!-- Heroicon name: calendar -->
                                    <svg class="text-gray-400 group-hover:text-gray-500 mr-3 h-6 w-6" xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 10V3L4 14h7v7l9-11h-7z" />
                                    </svg>
                                    Involvement
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
                        <div class="flex items-center">
                            <div class="p-2 space-y-4 rounded-lg">
                                <div class="flex items-center" x-data="{ open: false }">
                                    <button class="transition px-4 py-2 bg-gray-400 hover:bg-gray-700 text-white rounded-full border-none focus:outline-none"
                                    @click="open = true">Change to Committee</button>
                                    <div class="fixed z-1 w-full h-full top-0 left-0 flex items-center justify-center" x-cloak x-show="open">
                                        <div class="fixed w-full h-full bg-gray-500 opacity-50"></div>
                                            <div class="relative z-2 w-3/12 bg-white p-8 mx-auto rounded-xl flex flex-col items-center" @click.away="open = false">
                                            <p class="pb-4">Do you want to be a committee for the program?</p>
                                            <div class="flex space-x-2">
                                                <button class="px-4 py-2 bg-red-400 hover:bg-red-700 text-white rounded-full border-none focus:outline-none" @click="open = false">No</button>
                                                <!-- button bawah buat jadi form, hantar user id, role id, dan seterusnya, untuk request table -->
                                                <form action="servlethere">
                                                    <input type="hidden" name="user_id" id="" value="">
                                                    <input type="hidden" name="role_id" value="">
                                                    <button type="submit" class="px-4 py-2 bg-green-400 hover:bg-green-700 text-white rounded-full border-none focus:outline-none" @click="open = false">Yes</button>
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
                                        <span class="sr-only">Open user menu</span>
                                        <img class="h-8 w-8 rounded-full"
                                             src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"
                                             alt="">
                                    </button>
                                </div>
                                <!--
                                  Profile dropdown panel
                                -->
                                <div class="origin-top-right absolute right-0 mt-2 w-48 rounded-md shadow-lg py-1 bg-white ring-1 ring-black ring-opacity-5" role="menu" aria-orientation="vertical" aria-labelledby="user-menu"
                                     x-show="isVisible()"
                                     x-cloak
                                     x-transition:enter="transition ease-out duration-100 transform"
                                     x-transition:enter-start="opacity-0 scale-95"
                                     x-transition:enter-end="opacity-100 scale-100"
                                     x-transition:leave="transition ease-in duration-75 transform"
                                     x-transition:leave-start="opacity-100 scale-100"
                                     x-transition:leave-end="opacity-0 scale-95"
                                >
                                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100" role="menuitem">Your Profile</a>

                                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100" role="menuitem">Settings</a>

                                    <a href="#" class="block px-4 py-2 text-sm text-gray-700 hover:bg-gray-100" role="menuitem">Sign out</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <main class="flex-1 relative overflow-y-auto focus:outline-none" tabindex="0">
                    <div class="py-6">
                        <div class="max-w-7xl mx-auto px-4 sm:px-6 md:px-8">
                            <h1 class="text-2xl font-semibold text-gray-900">Profile Information</h1>
                        </div>
                        <div class="max-w-7xl mx-auto px-4 sm:px-6 md:px-8">
                            <!-- Replace with your content -->
                            <div class="pt-2">
                                <div class="flex justify-end">
                                    <div class="flex">
                                        <div class="p-2 space-y-4 rounded-lg">
                                            <div class="flex items-end" x-data="{ open: false }">
                                                <button class="flex bg-gray-200 px-4 py-2 rounded-md border hover:bg-gray-900 hover:text-white transition duration-500"
                                                @click="open = true">
                                                    Edit
                                                    <span class="ml-2">
                                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                          <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z" />
                                                        </svg>
                                                    </span>
                                                </button>
                                                <div class="fixed z-1 w-full h-full top-0 left-0 flex items-center justify-center" x-cloak x-show="open">
                                                    <div class="fixed w-full h-full bg-gray-500 opacity-50">

                                                    </div>
                                                        <div class="relative z-2 w-4/12 bg-white p-8 mx-auto rounded-xl" @click.away="open = false">
                                                            <div class="flex flex-col my-2 mx-auto items-end justify-end">
                                                                <button id="no" class="bg-red-400 hover:bg-red-700 text-white rounded-full border-none focus:outline-none" @click="open = false">
                                                                    <span>
                                                                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z" />
                                                                        </svg>
                                                                    </span>
                                                                </button>
                                                            </div>
                                                            <div class="flex flex-col items-center pb-4">
                                                                <p class="font-bold">Edit Your Profile Information</p>
                                                            </div>
                                                            <div class="space-x-2">
                                                                <!-- button bawah buat jadi form, hantar user id, role id, dan seterusnya, untuk request table -->
                                                                <form action="servlethere">
                                                                    <div class="border-t border-gray-200">
                                                                        <dl>
                                                                            <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                                                                <dt class="text-sm font-medium text-gray-500">
                                                                                    Matric Number
                                                                                </dt>
                                                                                <dd class="uppercase mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                                                                    S54164
                                                                                </dd>
                                                                            </div>
                                                                        </dl>
                                                                    </div>
                                                                    <div class="border-t border-gray-200">
                                                                        <dl>
                                                                            <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                                                                <dt class="text-sm font-medium text-gray-500">
                                                                                    Full Name
                                                                                </dt>
                                                                                <dd class="uppercase mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                                                                    Wan Aisyah Amirah Binti Wan Mohd Zamri
                                                                                </dd>
                                                                            </div>
                                                                        </dl>
                                                                    </div> 
                                                                    <div class="border-t border-gray-200">
                                                                        <dl>
                                                                            <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                                                                <dt class="text-sm font-medium text-gray-500">
                                                                                    IC Number
                                                                                </dt>
                                                                                <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                                                                    000802-03-1168
                                                                                </dd>
                                                                            </div>
                                                                        </dl>
                                                                    </div>
                                                                    <div class="border-t border-gray-200">
                                                                        <dl>
                                                                            <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                                                                <dt class="text-sm font-medium text-gray-500">
                                                                                    Mentor
                                                                                </dt>
                                                                                <dd class="uppercase mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                                                                    Dr. Farizah Binti Yunus
                                                                                </dd>
                                                                            </div>
                                                                        </dl>
                                                                    </div>  
                                                                    <div class="border-t border-b border-gray-200">
                                                                        <dl>
                                                                            <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                                                                <dt class="text-sm font-medium text-gray-500">
                                                                                    Email
                                                                                </dt>
                                                                                <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                                                                    S54164@ocean.umt.edu.my
                                                                                </dd>
                                                                            </div>
                                                                        </dl>
                                                                    </div>
                                                                    <hr>
                                                                    <div class="my-2 flex flex-col items-center">
                                                                        <input type="hidden" name="user_id" id="" value="">
                                                                        <input type="hidden" name="role_id" value="">
                                                                        <button type="submit" class="px-4 py-2 bg-green-400 hover:bg-green-700 text-white rounded-full border-none focus:outline-none" @click="open = false">Submit</button>
                                                                    </div>           
                                                                </form>
                                                            </div>
                                                        </div>
                                                </div>      
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="py-2 flex flex-wrap">
                                    <!-- This example requires Tailwind CSS v2.0+ -->
                                    <div class="w-full bg-white shadow overflow-hidden sm:rounded-lg">
                                        <div class="px-4 py-5 sm:px-6 flex items-center justify-center">
                                            <div class="w-1/3 items-center">
                                                <img class="mx-auto rounded-full" src="https://randomuser.me/api/portraits/women/81.jpg" alt="user image" />
                                            </div>
                                            <div class="w-1/3 text-center mx-2 bg-green-200 px-4 py-2 rounded-lg text-green-900 hover:bg-green-500 hover:text-green-100 transition duration-500">
                                                <p>CGPA</p>
                                                <p class="font-bold tracking-widest">2.57</p>
                                            </div>
                                            <div class="w-1/3 text-center mx-2 bg-blue-200 px-4 py-2 rounded-lg text-blue-900 hover:bg-blue-700 hover:text-blue-100 transition duration-500">
                                                <p>Merit</p>
                                                <p class="font-bold tracking-widest">2000</p>
                                            </div>
                                        </div>
                                        <div class="border-t border-gray-200">
                                            <dl>
                                                <div class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                                    <dt class="text-sm font-medium text-gray-500">
                                                        Matric Number
                                                    </dt>
                                                    <dd class="uppercase mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                                        S54164
                                                    </dd>
                                                </div>
                                                <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                                    <dt class="text-sm font-medium text-gray-500">
                                                        Full name
                                                    </dt>
                                                    <dd class="uppercase mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                                        Wan Aisyah Amirah Binti Wan Mohd Zamri
                                                    </dd>
                                                </div>
                                                <div class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                                    <dt class="text-sm font-medium text-gray-500">
                                                        Gender
                                                    </dt>
                                                    <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                                        Female
                                                    </dd>
                                                </div>
                                                <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                                    <dt class=" text-sm font-medium text-gray-500">
                                                        Identification Card Number
                                                    </dt>
                                                    <dd class="uppercase mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                                        000802-03-1168
                                                    </dd>
                                                </div>
                                                <div class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                                    <dt class="text-sm font-medium text-gray-500">
                                                        Year of Study
                                                    </dt>
                                                    <dd class="mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                                        Year 3
                                                    </dd>
                                                </div>
                                                <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                                    <dt class="text-sm font-medium text-gray-500">
                                                        Program
                                                    </dt>
                                                    <dd class="uppercase mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                                        Bachelor of Degree in Computer Science (Software Engineering) with Honours
                                                    </dd>
                                                </div>
                                                <div class="bg-white px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                                    <dt class="text-sm font-medium text-gray-500">
                                                        Mentor
                                                    </dt>
                                                    <dd class="uppercase mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                                        Dr. Farizah Binti Yunus
                                                    </dd>
                                                </div>
                                                <div class="bg-gray-50 px-4 py-5 sm:grid sm:grid-cols-3 sm:gap-4 sm:px-6">
                                                    <dt class="text-sm font-medium text-gray-500">
                                                        Email
                                                    </dt>
                                                    <dd class=" mt-1 text-sm text-gray-900 sm:mt-0 sm:col-span-2">
                                                        S54164@ocean.umt.edu.my
                                                    </dd>
                                                </div>
                                            </dl>
                                        </div>
                                    </div>
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