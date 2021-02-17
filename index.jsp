<!DOCTYPE html>
<html lang="lt">
<%@page pageEncoding="UTF-8" language="java"%>
<%@page contentType="text/html;charset=UTF-8"%>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv="X-UA-Compatible" content="ie=edge">
		<title>Zoologijos sodas!</title>
		<link href="css/bootstrap.min.css" rel="stylesheet" />
		<link href="font/css/all.min.css" rel="stylesheet" /> 
		<link href="css/style.css" rel="stylesheet">
	</head>
<body>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

<%

	String driverName = "com.mysql.jdbc.Driver";
	String connectionUrl = "jdbc:mysql://localhost:3306/";
	String dbName = "zoo";
	String userId = "root";
	String password = "";

	Connection connection = null;
	Statement statement = null;
	ResultSet resultSet = null;

%>
<div class="container">

		<h2 align="center"><strong>Zoologijos Sodas</strong></h2>
		<table class="table" align="center" cellpadding="5" cellspacing="5" border="1">

			<tr class="lent_virsus">
				<th>Id</th>
				<th>Pavadinimas</th>
				<th>Narvo numeris</th>
				<th>Atgabenimo data</th>
				<th>Atgabenta iš</th>
			</tr>
<%

	try{
	     
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.setCharacterEncoding("UTF-8");		
		
	} catch(Exception e) {}

	try{ 

		connection = DriverManager.getConnection ( connectionUrl + dbName + "?useUnicode=yes&characterEncoding=UTF-8", userId, password );
		
		statement=connection.createStatement();		
		String sql ="SELECT * FROM `gyvunai`  WHERE 1";

		resultSet = statement.executeQuery(sql);
		 
		while( resultSet.next() ){
%>
<tr class="lent_vidus">
	<td><%= resultSet.getString ( "id" ) %></td>
	<td><%= resultSet.getString ( "pav" ) %></td>
	<td><%= resultSet.getString  ("narvo_nr" ) %></td>
	<td><%=resultSet.getString ( "atgabentas" ) %></td>
	<td><%=resultSet.getString ( "atgabentas_is" ) %></td>
</tr>

<% 
		}

	} catch (Exception e) {
	
		e.printStackTrace();
	}
%>
</table>
</div>

</body>