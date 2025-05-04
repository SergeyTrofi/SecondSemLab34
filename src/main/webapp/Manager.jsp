<%@ page import="java.io.File" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String directory = request.getParameter("path").replace("\\","/");
    File file = new File(directory);
    String parentDirectoryPath = "/";


    parentDirectoryPath = file.getParent();  // Получаем путь к родительской директории
    String login =(String) request.getAttribute("login");
    if (parentDirectoryPath == null || parentDirectoryPath.length() < ("D:\\Programming Java\\2 Семестр\\demo\\SecondSemLab34\\".length() + login.length())) {
        parentDirectoryPath = "D:\\Programming Java\\2 Семестр\\demo\\SecondSemLab34\\"+request.getAttribute("login");
    }


%>
<html>
<head>
    <title>Менеджер файлов</title>
</head>
<body>
<h1>Текущая директория: "<%=(String) request.getAttribute("currentPath")%> "</h1>
<a href=<%="?path="+parentDirectoryPath.replace("\\","/")%>>Назад</a>
<table>
    <tr>
        <th>Папка</th>
        <th>Перейти</th>
        <th>Размер(байты)</th>
        <th>Последнее изменение</th>
    </tr>
    <%
        File[] itemList = (File[]) request.getAttribute("folders"); // Получаем список из объекта запроса
        for (File item : itemList) {
    %>
    <tr>
        <td><img src="src\images\folder.png" alt="Folder Icon"/> <%= item.getName() %></td>
        <td><a href=<%="?path="+item.getAbsolutePath().replace("\\", "/").replace(" ","%20")%>/>Перейти</td>


        <td><%= item.length()%></td>
        <td><%= new Date(item.lastModified())%></td>
    </tr>
    <% } %>
    <tr>
        <th>Файл</th>
        <th>Ссылка на скачивание</th>
        <th>Размер(байты)</th>
        <th>Последнее изменение</th>
    </tr>
    <%
        File[] list = (File[]) request.getAttribute("files"); // Получаем список из объекта запроса
        for (File item : list) {
    %>
    <tr>
        <td><img src="src\images\file.png" alt="File Icon"/> <%= item.getName() %></td>
        <td><a href=<%="http://localhost:8080/SecondSemLab346-1.0-SNAPSHOT/Download?path="+ item.getAbsolutePath().replace("\\","/").replace(" ","%20")%>> Скачать </a> </td>
        <td><%= item.length()%></td>
        <td><%= new Date(item.lastModified())%></td>
    </tr>
    <% } %>
</table>
<p>
<form action="Manager" method="POST">
    <input type="submit" value="Выйти">
</form>
</p>
</body>
</html>