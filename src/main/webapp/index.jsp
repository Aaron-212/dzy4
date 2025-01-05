<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.aaron212.javadzy.Student" %>
<%@ page import="com.aaron212.javadzy.StudentDataHandler" %>
<%@ page import="java.util.TreeMap" %>
<%@ page import="java.util.Map" %>

<%
    StudentDataHandler handler = StudentDataHandler.getInstance();
    TreeMap<Integer, Student> students = handler.getStudents();
%>

<!DOCTYPE html>
<html>
<head>
    <title>学生信息列表</title>
    <link href="main.css" rel="stylesheet" type="text/css">
</head>

<body>

<h1>学生信息列表</h1>
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
        <th>详情</th>
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
                <input type="submit" value="🔍" class="small-button">
            </form>
        </td>

    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="4" style="text-align: center">暂无学生信息。</td>
    </tr>
    <%
        }
    %>
</table>

<br/>

<div class="button-container">
    <a href="addStudent.jsp" class="button">添加学生信息</a>
    <a href="removeStudent.jsp" class="button">删除学生信息</a>
</div>

<%
    if (request.getMethod().equalsIgnoreCase("POST")) {
        int id = Integer.parseInt(request.getParameter("id"));

        response.sendRedirect("studentDetail.jsp?id=" + id);
    }
%>


</body>
</html>
