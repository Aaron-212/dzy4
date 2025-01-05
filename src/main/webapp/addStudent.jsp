<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.aaron212.javadzy.StudentDataHandler" %>
<%@ page import="com.aaron212.javadzy.StudentDataException" %>

<html>
<head>
    <title>添加学生信息</title>
    <link href="main.css" rel="stylesheet" type="text/css">
</head>
<body>

<h1>添加学生信息</h1>

<form method="post" class="styled-form">
    <label for="id">学号</label>
    <input type="text" id="id" name="id" required>

    <label for="name">姓名</label>
    <input type="text" id="name" name="name" required>

    <div class="button-container">
        <input type="submit" value="添加" class="button">
        <input type="reset" value="重置" class="button">
        <a href="index.jsp" class="button">返回</a>
    </div>
</form>

<%
    if (request.getMethod().equalsIgnoreCase("POST")) {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");

        try {
            StudentDataHandler.getInstance().addStudent(id, name);
        } catch (StudentDataException e) {
            out.println("<p>已有重复学生</p>");
        } finally {
            out.println("<p>学生已添加成功！</p>");
        }

        response.sendRedirect("index.jsp");
    }
%>

</body>
</html>
