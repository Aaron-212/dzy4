<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.aaron212.javadzy.Student" %>
<%@ page import="com.aaron212.javadzy.StudentDataHandler" %>
<%@ page import="com.aaron212.javadzy.Score" %>
<%@ page import="com.aaron212.javadzy.StudentDataException" %>
<%@ page import="java.util.ArrayList" %>

<%
    StudentDataHandler handler = StudentDataHandler.getInstance();
    int id = 0;
    String method = request.getMethod();

    // Retrieve the id parameter for both GET and POST requests
    String idParam = request.getParameter("id");
    if (idParam == null || idParam.isEmpty()) {
        idParam = request.getParameter("id2");
    }
    if (idParam != null && !idParam.isEmpty()) {
        id = Integer.parseInt(idParam);
    } else {
        out.println("<p>Student ID is missing.</p>");
        return;
    }

    Student student = handler.getStudent(id);
    if (student == null) {
        out.println("<p>Student not found.</p>");
        return;
    }
    ArrayList<Score> scores = student.getScores();
%>

<!DOCTYPE html>
<html>
<head>
    <title>学生详细信息</title>
    <link href="main.css" rel="stylesheet" type="text/css">
</head>

<body>

<h1>学生详细信息</h1>

<h2><%= student.getName() %>
</h2>
<p style="font-weight: bold"> 学号： <%= id %>
</p>

<table>
    <colgroup>
        <col style="width: 30%">
        <col style="width: 30%">
    </colgroup>

    <tr>
        <th>课程名</th>
        <th>成绩</th>
    </tr>
    <%
        if (scores != null && !scores.isEmpty()) {
            for (Score score : scores) {
    %>
    <tr>
        <td><%= score.getCourse() %>
        </td>
        <td><%= score.getGrade() %>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="2" style="text-align: center">暂无学生成绩信息。</td>
    </tr>
    <%
        }
    %>
</table>

<%
    if (scores != null && !scores.isEmpty()) {
        Student.Statistics stats = student.new Statistics();
%>

<br/>

<p>
平均分：<%= stats.average %>；
最高分：<%= stats.max %>；
最低分：<%= stats.min %>；
及格率：<%= String.format("%.0f%%",stats.passRate * 100) %>。
</p>

<%
    }
%>

<br/>

<h1>添加成绩信息</h1>

<form method="post" class="styled-form">
    <label for="id2">学号</label>
    <input type="number" id="id2" name="id2" min="0" readonly value="<%= id %>">

    <label for="name">姓名</label>
    <input type="text" id="name" name="name" readonly value="<%= student.getName() %>">

    <label for="course">课程名称</label>
    <input type="text" id="course" name="course" required>

    <label for="score">成绩</label>
    <input type="number" id="score" name="score" min="0" max="100" required>

    <div class="button-container">
        <input type="submit" value="添加" class="button">
        <input type="reset" value="重置" class="button">
        <a href="index.jsp" class="button">返回</a>
    </div>
</form>

<%
    if (request.getMethod().equalsIgnoreCase("POST")) {
        int id2 = Integer.parseInt(request.getParameter("id2"));
        String course = request.getParameter("course");
        int scoreValue = Integer.parseInt(request.getParameter("score"));

        try {
            handler.addScore(id2, course, scoreValue);
            out.println("<p>成绩已添加成功！</p>");
        } catch (StudentDataException e) {
            out.println("<p>添加失败: " + e.getMessage() + "</p>");
        }

        // Redirect to the same page with the id parameter
        response.sendRedirect("studentDetail.jsp?id=" + id2);
    }
%>

</body>
</html>
