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
</head>


<body style="background-color: #333;">


    <nav class="navbar">
        <ul class="nav-list">
        <div class="logo"><img src="img/logo.jpeg" alt="logo"></div>
           <li> <a href="#home"><h2> Home</h2></a> </li>
           <li> <a href="#contact"><h2>Contact Us</h2></a> </li>
        </ul>
        <div class="rightNav">
            <!--<input type=""text" name="search" id="search">
            <button class="btn btn-sm">Search</button>-->
                <form action="Profile.jsp" method="post" class="profile-show">
                            <button class="iconbtn"><img src="img/user.ico" alt="Profile Picture" class=""></button>
                </form>
        </div>
     </nav>





<%! String message = "";
    int similar, total, total_recepie;
%>

<%
    String[] selected_ingrediants = request.getParameterValues("ingredients");
    List<String> selected_ingrediants_list = new ArrayList<String>();

    if(selected_ingrediants == null){
        selected_ingrediants_list.add("None");
    }

    else{
        for (String c : selected_ingrediants) {
            c = c.replace("\n", "");
            selected_ingrediants_list.add(c.replaceAll(" ", "").toLowerCase());
        }
    }
    //out.println(selected_ingrediants_list);
        
%>






    <section class="background firstSection">
        <div class="box-main">
            <div class="firsthalf">
                <p class="text-big">Minute Recipes</p>
                <p class="text-small"></p>
                <br>
            <!-- <div class="buttons">
                <form action="Login" method="post"><button type=Login class="btn" value="Login"> Login</button></form>

                <form action="Sign_up" method="post"><button type=Signup class="btn" value="Sign up"> Sign up</button></form>
            </div>     -->
        </div>

            <!--<div class="secondhalf">
                <img src="img/logo.jpeg" alt="logo Image">
            </div>-->
    </section><br><hr><br>
    <p class="selectIng">SELECT INGREDIENTS</p>
    

        <div class="container">

            <form action="HomePage.jsp" method=post class="Ingredients">

                    <div class="subcont"><br>
                        <p class="ingtitle">Pantry Essentials</p><br>
                        
                        <div class="ingthings">
                            <input type="checkbox" id="ingredients" name="egg" value="Egg" class="chkbx">
                            <label for="egg"> Egg</label><br>
                        </div>
                            
                        <div class="ingthings">
                            <input type="checkbox" id="bread" name="ingredients" value="Bread" class="chkbx">
                            <label for="bread"> Bread</label><br>
                        </div>

                        <div class="ingthings">
                            <input type="checkbox" id="milk" name="ingredients" value="Milk" class="chkbx">
                            <label for="milk"> Milk</label><br>
                        </div>
                        
                        <div class="ingthings">
                            <input type="checkbox" id="ketchup" name="ingredients" value="Ketchup" class="chkbx">
                            <label for="ketchup"> Ketchup</label><br>
                        </div>
                        
                        <div class="ingthings">
                            <input type="checkbox" id="butter" name="ingredients" value="Butter" class="chkbx">
                            <label for="butter"> Butter</label><br>
                        </div>
                    </div>

                    <div class="subcont"><br>

                        <p class="ingtitle">Vegies</p><br>

                        <div class="ingthings">
                            <input type="checkbox" id="potato" name="ingredients" value="potato" class="chkbx">
                            <label for="egg"> Potato</label><br>
                        </div>

                        <div class="ingthings">
                            <input type="checkbox" id="Tomato" name="ingredients" value="Tomato" class="chkbx">
                            <label for="Tomato"> Tomato</label><br>
                        </div>

                        <div class="ingthings">
                            <input type="checkbox" id="cabbage" name="ingredients" value="Cabbage" class="chkbx">
                            <label for="cabbage"> Cabbage</label><br>
                        </div>

                        <div class="ingthings">
                            <input type="checkbox" id="onion" name="ingredients" value="Onion" class="chkbx">
                            <label for="onion"> Onion</label><br>
                        </div>    
                            
                        <div class="ingthings">
                            <input type="checkbox" id="carrot" name="ingredients" value="Carrot" class="chkbx">
                            <label for="carrot"> Carrot</label><br>
                        </div>
                    </div>
                    
                    <div class="subcont"><br>

                        <p class="ingtitle"> Common</p><br>
                            
                        <div class="ingthings">
                            <input type="checkbox" id="oil" name="ingredients" value="Oil" class="chkbx">
                            <label for="Oil"> Oil</label><br>
                        </div>

                        <div class="ingthings">
                            <input type="checkbox" id="rice" name="ingredients" value="Rice" class="chkbx">
                            <label for="rice"> Rice</label><br>
                        </div>
                        
                        <div class="ingthings">
                            <input type="checkbox" id="flour" name="ingredients" value="Flour" class="chkbx">
                            <label for="flour"> Flour</label><br>
                        </div>

                        <div class="ingthings">
                            <input type="checkbox" id="honey" name="ingredients" value="Honey" class="chkbx">
                            <label for="honey"> Honey</label><br>
                        </div>
                            
                        <div class="ingthings">
                            <input type="checkbox" id="garlic" name="ingredients" value="Garlic" class="chkbx">
                            <label for="garlic"> Garlic</label><br>
                        </div>
                    </div>
                <center><input type=Reset class="btn"> <input class="btn" type=Submit value="Get Recipes"> </form></center>
            </form></div>
            <br>
    <section class="Ingredients">







<%

    try{
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/minute_recipe", "root", "toor");

        PreparedStatement ps = connection.prepareStatement("select * from recepies");
        ResultSet result = ps.executeQuery();
        //out.println(result.next());

        while (result.next()){
            total = 0;
            similar = 0;
            total_recepie = 0;

            String db_ingrediants = result.getString("ingredients");

            db_ingrediants = db_ingrediants.toLowerCase().replace("\n", ",");


            List<String> db_ingrediants_list = new ArrayList<String>(Arrays.asList(db_ingrediants.split(",")));

            //out.println(db_ingrediants_list.size());
            //out.println(db_ingrediants_list);

            for(int db_len = 0 ; db_len < db_ingrediants_list.size(); db_len++){
                
                String db_ing = db_ingrediants_list.get(db_len).replace(" ", "");
                total += 1;

                for(int user_len = 0; user_len < selected_ingrediants_list.size(); user_len++){
                    String user_ing = selected_ingrediants_list.get(user_len).replace(" ", "");

                    boolean comapre = db_ing.equals(user_ing);

                    if(comapre == Boolean.TRUE){
                        similar += 1;
                    }
                    


                }
                
            }

            if((similar/total)*100 >= 70 ){
                //out.println("Match 70");
                total_recepie += 1;
                %>
        
                <form class="rcpcont">

                <% out.println("Name -: " + result.getString("recepie_name")); %><br><br>
                <% out.println("Ingredients -: " +  result.getString("ingredients")); %><br><br>
                <% out.println("Quantity -: " + result.getString("quantity")); %><br><br>
                <% out.println("Steps -: " + result.getString("steps")); %><br><br>

                <br><br><br>


                 
            <%
            }            
       
        }

        if(total_recepie < 0){
            out.println("Sorry No recepie found :( "); %> <br> <% 
        }


                    
    }

    catch(Exception error){
        message = "Unable to fetch recepie";
        out.println(error);
    }



%>

                </form>


<%-- 
    <%
        for (String ingredient : selected_ingrediants){
        %>
        
            <form class="rcpcont">

                <% out.println(ingredient); %>


            </form> 
        <%
        }
    %>
         --%>



    </section>


        
    <%-- <footer>
        <div class="foot">
            <center>
                <br>
        <p>&copy; 2023 Minute Recipes. All rights reserved - Team Malevolent</p>
    
</div>
        </center>
      </footer> --%>
    </body>
</html>
