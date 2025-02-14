<%-- 
    Document   : logout
    Created on : oct, 2015, 2:25:34 AM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        session.removeAttribute("i_id");
        session.removeAttribute("cus_id");
        response.sendRedirect("../home_page/home.jsp");
        %>
    </body>
</html>
