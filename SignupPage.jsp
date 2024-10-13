<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
 


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MinuteRecipes - Signup</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
    <style>
        body {
        font-family: courier, serif;
        }
    </style>
</head>
<body>
    <!-- <nav class="navbar">
        <ul class="nav-list">
        <div class="logo"><img src="img/logo.jpeg" alt="logo"></div>
           <li> <a href="#home"><h2> Home</h2></a> </li>
           <li> <a href="#contact"><h2>Contact Us</h2></a> </li>
        </ul>
        <div class="rightNav">
            <input type=""text" name="search" id="search">
            <button class="btn btn-sm">Search</button>
        </div>
     </nav> -->

    <section class="background firstSection">
        <div class="box-main">
            <div class="firsthalf">
                <p class="text-small"></p>
                <br>
            <div class="buttons">

            <%! String message = "";
                String message2 = "";   
             %>

            <%
                try{
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    
                    Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/minute_recipe", "root", "toor");


                    String name = request.getParameter("username");
                    String email = request.getParameter("email");
                    String password = request.getParameter("password");

                    if(email != null && password != null && name != null){
                            if(name.contains(";") || email.contains(";") || password.contains(";") || name.contains(" ") || email.contains("@") == Boolean.FALSE || email.contains(" ")){
                            message = "Invalid Input2";
                            message2 = "No space allowed";
                        }
                        

                        else{
                            PreparedStatement ps = connection.prepareStatement("select email from login_info where email=?");
                            ps.setString(1, email);
                                //ps.setString(2, password);
                        ResultSet rs = ps.executeQuery();

                            if(rs.next()){
                                message = "Account already exist Please Login!!!";
                            }

                            else{
                                PreparedStatement ps2 = connection.prepareStatement("insert into login_info values (?, ?, ?)");
                                ps2.setString(1, name);
                                ps2.setString(2, email);
                                ps2.setString(3, password);

                                Boolean rs2 = ps2.execute();

                                if (rs2 == Boolean.FALSE){
                                    message = "Account created Please Login!!!";
                                }
                                else {
                                    out.println("Account not created");
                                }
                            }

                        }
                    }

                    
                    
                }

                catch(Exception ex){
                    message = "Error connecting website";
                }

            %>




                <form action="SignupPage.jsp" method="post" class="signupPageform">
                    <center><p class="formstitle">Create Account</p></center>
                    <br>
                <font class="login_font">
                    <label for="username">Username</label>
                    <input type="text" placeholder=" Username" name="username" id="username" class="inputr" required>
                    <font class="error"><h6><%= message2 %></h6></font>
                        <br>

                        <label for="username">Email</label>
                        <input type="text" placeholder="Email" name="email" id="email" class="inputr" required><br><br>
                        <label for="password">Password</label>
                        <input type="password" placeholder=" Password" name="password" id="password" class="inputr" required>
                        <font class="error"><h6><%= message %></h6>
                    </font><br>
                    <button class="btn" value="loginProceed">Sign up</button>
                </font>
                </form>
                    <!-- <form action="LoginPage.jsp" method="post" class="homepageSignup">
                    
                        <div class="social">
                            Already have an account?
                        <button type=Submit class="btn" value="login">Sign in</button><br>
                        
                        </div>
                    </form> -->
                </div>
                
                <form action="LoginPage.jsp" method="post" class="loginpageformca">
                <font class="formbottomfont"> 
                    <div class="social">
                        Already have an account?
                    <button type=Submit class="btn" value="login">Sign in</button><br>
                    
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
    <p>&copy; 2023 Minute Recipes. All rights reserved - Team Maleveolent</p>

</div>
    </center>
  </footer> -->
    </body>
</html>
