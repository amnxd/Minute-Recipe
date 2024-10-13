<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MinuteRecipes - Making Recipe according to your ingredients</title>
    <link rel="stylesheet" href="css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap"
          rel="stylesheet">

    <style>
        body {
            font-family: Roboto;
        }
    </style>
</head>

<%! String message = "";
    String name;
    String email;
    String cookie_data;
 %>

<%

try{
                response.setContentType("text/html");

                Cookie[] cookies = request.getCookies();      
                //out.println(cookies);
                
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/minute_recipe", "root", "toor");

                //out.println(cookies);

                if(cookies != null){
                    for(Cookie c : cookies){
                        if(c.getName().equals("name"))
				            cookie_data = c.getValue();
                            //out.println(cookie_data);


                            try{
                                
                                cookie_data = cookie_data.substring(0, cookie_data.length()-5);
                                email = cookie_data;
                                //out.println(cookie_data);

                                PreparedStatement ps1 = connection.prepareStatement("select user_name from login_info where email=?");
                                ps1.setString(1, email);
                                ResultSet result1 = ps1.executeQuery();
                                
                                
                                if(result1.next() == true){
                                    name = result1.getString("user_name");
                                    break;
                                }

                                else{
                                    //out.println("blank");
                                }
                                
                                
                            }
                            catch(Exception a){
                                //out.println(a);
                            }

                    }
                }

}



catch(Exception e){
    message = "Error";
}

 %>








<body>
    <nav class="navbar">
        <ul class="nav-list">
            <div class="logo"><img src="img/logo.jpeg" alt="logo"></div>
            <li> <a href="HomePage.jsp">
                    <h2> Home</h2>
                </a> </li>
            <li> <a href="#contact">
                    <h2>Contact Us</h2>
                </a> </li>
            <!-- <img src="img/magnify.png" alt="logoacc" class="logoacc"> -->
        </ul>
        <div class="rightNav">
            <!--<input type=""text" name="search" id="search">
            <button class="btn btn-sm">Search</button>-->
                <form action="Delete_cookies.jsp" method="post" class="delete_cookie">
                            <button class="btn2">Log out</button>
                </form>
        </div>
     </nav>

    <section class="background firstSection">
        <div class="box-main">
            <form action="Login_forward.jsp" method="post" class="profile-container ">
                <div>
                    <div class="profile-header">
                        <img src="img/user.png" alt="Profile Picture" class="profile-picture">
                        <div class="profile-info">
                            
                            <h4>User Name : <% out.println(name); %></h4>
                            <br>
                            <p>Email: <% out.println(email); %></p>
                        </div>
                    </div>

                    <!-- <div class="profile-updates">
                        <h2>Update Profile</h2>
                        <br>
                        <form action="/profile" method="post">
                            <label for="newUsername">New Username:</label>
                            <input type="text" id="newUsername" name="newUsername" class="inputr" placeholder="@username">
            
                            <label for="newEmail">New Email:</label>
                            <input type="email" id="newEmail" name="newEmail" class="inputr" placeholder="@Email">
            
                            <button type="submit">Save Changes</button>
                        </form>
                    </div> -->
                </div>


            </form>

            <section class="history">

                <form>
                    <div>
                        <font class="wishlist">
                        
                            <h1> Wishlist </h1>
                        
                        </font>
                    </div>
                </form>

            </section>



        </div>
    </section>
    <footer>
        <div class="foot">
            <center>
                <br>
                <p>&copy; 2023 Minute Recipe. All rights reserved - Team Malevolent </p>

        </div>
        </center>
    </footer>
</body>

</html>
