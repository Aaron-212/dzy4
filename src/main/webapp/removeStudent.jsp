<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.aaron212.javadzy.Student" %>
<%@ page import="com.aaron212.javadzy.StudentDataHandler" %>
<%@ page import="com.aaron212.javadzy.StudentDataException" %>
<%@ page import="java.util.TreeMap" %>
<%@ page import="java.util.Map" %>

<%
    StudentDataHandler handler = StudentDataHandler.getInstance();
    TreeMap<Integer, Student> students = handler.getStudents();
%>

<html>
<head>
    <title>删除学生信息</title>
    <link href="main.css" rel="stylesheet" type="text/css">
</head>
<body>

<h1>删除学生信息</h1>

<table>
    <colgroup>
        <col style="width: 1%; min-width: 4em; white-space: nowrap;">
        <col style="width: 30%">
        <col style="width: 30%">
        <col style="width: 1%; min-width: 4em; white-space: nowrap;">
    </colgroup>


    <tr>
        <th>学号</th>
        <th>姓名</th>
        <th>课程数量</th>
        <th>删除</th>
    </tr>
    <%
        if (students != null && !students.isEmpty()) {
            for (Map.Entry<Integer, Student> studentKV : students.entrySet()) {
                Integer id = studentKV.getKey();
                Student student = studentKV.getValue();
    %>
    <tr>
        <td><%= id %>
        </td>
        <td><%= student.getName() %>
        </td>
        <td><%= student.getSize() %>
        </td>
        <td>
            <form method="post" class="small-form">
                <input type="hidden" name="id" value="<%= id %>">
                <input type="submit" value="❌" class="small-button">
            </form>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="5" style="text-align: center">暂无学生信息。</td>
    </tr>
    <%
        }
    %>
</table>

<br/>

<div class="button-container">
    <a href="index.jsp" class="button">返回</a>
</div>

<%
    if (request.getMethod().equalsIgnoreCase("POST")) {
        int id = Integer.parseInt(request.getParameter("id"));

        response.sendRedirect("removeStudent.jsp");

        try {
            StudentDataHandler.getInstance().removeStudent(id);
        } catch (StudentDataException e) {
            out.println("<p>学生删除失败</p>");
        } finally {
            out.println("<p>学生已删除成功</p>");
        }
    }
%>

</body>
</html>
