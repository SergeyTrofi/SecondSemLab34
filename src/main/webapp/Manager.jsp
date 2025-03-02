<%@ page import="java.io.File" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String directory = request.getParameter("path");
    File file = new File(directory);
    String parentDirectoryPath = "/";

    parentDirectoryPath = file.getParent();  // Получаем путь к папке-родителю

    if (parentDirectoryPath == null) {
        parentDirectoryPath = "/";
    }

    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    String currentDateTime = dateFormat.format(new Date());
%>
<html>
<head>
    <title>Менеджер файлов</title>
    <style>
        img {
            width: 20px;
            height: 20px;
        }
    </style>
</head>
<body>
<h3>Текущая дата и время: <%= currentDateTime %></h3>
<h1>Текущая директория: "<%= directory %>"</h1>
<p><a href=<%="?path="+parentDirectoryPath.replace("\\","/")%>/>Назад</p>
<table>
    <tr>
        <th>Папка</th>
        <th>Перейти</th>
        <th>Размер(байты)</th>
        <th>Последнее изменение</th>
    </tr>
    <%
        File[] itemList = (File[]) request.getAttribute("folders");
        for (File item : itemList) {
            String folderImage = "src/images/folder.png"; // Экранирование обратных слэшей
    %>
    <tr>
        <td><img src="<%= folderImage %>" alt="Folder Icon"/> <%= item.getName() %></td>
        <td><a href=<%="?path="+item.getAbsolutePath().replace("\\", "/")%>/>Перейти</a></td>
        <td><%= item.length() %></td>
        <td><%= new Date(item.lastModified()) %></td>
    </tr>
    <% } %>
    <tr>
        <th>Файл</th>
        <th>Ссылка на скачивание</th>
        <th>Размер(байты)</th>
        <th>Последнее изменение</th>
    </tr>
    <%
        File[] list = (File[]) request.getAttribute("files");
        for (File item : list) {
            String fileImage = "src/images/file.png";
    %>
    <tr>
        <td><img src="<%= fileImage %>" alt="File Icon"/> <%= item.getName() %></td>
        <td><a href=<%="http://localhost:8080/SecondSemLab34-1.0-SNAPSHOT/Download?path="+ item.getAbsolutePath().replace("\\","/")%>> Скачать </a></td>
        <td><%= item.length() %></td>
        <td><%= new Date(item.lastModified()) %></td>
    </tr>
    <% } %>
</table>

<p></p>
</body>
</html>
