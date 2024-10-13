<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MinuteRecipes - Login</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap"
          rel="stylesheet">
    <style>
        body {
        font-family:Arial, Helvetica, sans-serif;
        }
    </style>
</head>
<body>
    <!-- <nav class="navbar">
        <ul class="nav-list">
        <div class="logo"><img src="img/logo.jpeg" alt="logo"></div>
           <li> <a href="#home"><h2> Home</h2></a> </li>
           <li> <a href="#contact"><h2>Contact Us</h2></a> </li>
        </ul> -->
        <!-- <div class="rightNav">
            <input type=""text" name="search" id="search">
            <button class="btn btn-sm">Search</button>
        </div>
     </nav> -->

    <section class="background firstSection">
        <div class="box-main">
            <div class="firsthalf">
                <p class="text-small"></p>
                
            <div class="buttons">
            
            <%! String message = ""; %>
            
            <% 
            try{
                response.setContentType("text/html");

                Cookie[] cookies = request.getCookies();      
                //out.println(cookies);
                
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/minute_recipe", "root", "toor");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String cookie_data = "";
                
                if(cookies != null){
                    for(Cookie c : cookies) {
                        //out.println(c.getName().equals("name"));
				        if(c.getName().equals("name"))
				            cookie_data = c.getValue();
                            //out.println(cookie_data.length());
                            //out.println(cookie_data);
                            //out.println("hello");
                            try{
                                
                                //out.println(cookie_data);
                                cookie_data = cookie_data.substring(0, cookie_data.length() - 5);
                                //out.println(cookie_data);
                                email = cookie_data;

                                PreparedStatement ps1 = connection.prepareStatement("select password from login_info where email=?");
                                ps1.setString(1, email);
                                ResultSet result1 = ps1.executeQuery();
                                
                                if(result1.next() == true){
                                    password = result1.getString("password");
                                }

                                else{
                                    //out.println("blank");
                                }
                                
                                
                            }
                            catch(Exception a){
                                //out.println(a);
                            }


                            //redirect
                    }  
                }

                if(email.contains(";") || password.contains(";")){
                        message = "Invalid Input";
                    }

                else{
                    if(email != null && password != null){

                    PreparedStatement ps = connection.prepareStatement("select email from login_info where email=? and password=?");
                    ps.setString(1, email);
                    ps.setString(2, password);

                    ResultSet result = ps.executeQuery();

                        //out.println(result.next());

                    if (result.next()) {
                        Random random = new Random();
                        int random_num = random.nextInt(11111, 99999);

                        cookie_data = result.getString("email") + String.valueOf(random_num);
                        Cookie cookie = new Cookie("name", cookie_data);
                        response.addCookie(cookie);
                        //out.println(cookie_data);



                        RequestDispatcher rd = request.getRequestDispatcher("HomePage.jsp");
                        rd.forward(request, response);
                    }

                    else{
                        message = "Invalid Input";
                    }

                    }

                }

            }
            catch(Exception ex){
            	String message = "Error connecting website";
            }
      
            %>


            <div class="toleft">
                <form action="LoginPage.jsp" method="post" class="loginpageform">
                <font class="login_font">
                    
                    <center><p class="formstitle">Sign in</p></center>
                    <br>
                    <div class="epaspos">
                    <label for="username">Email</label><br>
                    <input type="text" placeholder="Email" name="email" id="email" class="inputr" required>
                    <br><br>
                    
                    <label for="password">Password</label><br>
                    <input type="password" placeholder=" Password" name="password" id="password"class="inputr" required>
                    
                    <font class="error"><h6><%= message %></h6></font>
                    <br>

                    
                    <button class="btn" value="loginProceed" type=Submit>Log In</button>

                </div>

                    <!-- login and create account -->
                    <!-- <div>
                    <form action="SignupPage.jsp" method="post" class="homepageSignupalpca">
                        <div class="social" >
                            <br>
                            Don't have a Account?
                            <button type=Submit class="btn" value="Signup">Create Account</button><br>
                            </div>
                    </form></div> -->
                </font>


                </form>
            </div>
                </div>
                <form action="SignupPage.jsp" method="post" class="loginpageformca">
                <font class="formbottomfont">
                        <div class="social">
                            Don't have a Account?
                            <button type=Submit class="btn" value="Signup">Create Account</button><br>
                        </div>
                        </font>
                    </form>

                </div>

            </div>
    </section>
    <!-- <footer>
        <div class="foot">
            <center>
                <br>
        <p>&copy; 2023 Minute Recipe's. All rights reserved. Design : Malevolent's Team</p>
    </center>
</div>
        </center>
      </footer> -->
    </body>
</html>
