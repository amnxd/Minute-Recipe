<%

String cookie_data = "";
        Cookie cookie = new Cookie("name", cookie_data);
        cookie.setMaxAge(0);
        response.addCookie(cookie);

        RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
        rd.forward(request, response);

%>