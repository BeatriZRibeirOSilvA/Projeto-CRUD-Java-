<%-- 
    Document   : logout
    Created on : 09/12/2020, 18:17:20
    Author     : Estudo
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <% 
            session.invalidate();
            response.sendRedirect("index.jsp");
        %>
    </body>
</html>
