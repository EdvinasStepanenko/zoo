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
<script>
			function iTrinima ( id_rec ) {
			
				mygtukasEdit = document.getElementById ( 'toEdit_' + id_rec );
				
				pav = mygtukasEdit.dataset.pav;
				
				var r = confirm( "Ar norite pašalinti gyvūną?" + pav + "?" );
				
				
				if ( r == true ) {
					
					document.getElementById ( "m_del" ).value = id_rec;
					
					forma_del = document.getElementById ( "del_rec" );
					//document.getElementById ( "id_gyv" ).value = id_gyv;
					forma_del.submit();
				}
				
			}
			

</script>
	
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
	Statement statement_take = null;
	Statement statement_change = null;
	ResultSet resultSet = null;
	int resultSetChange;
	
	String[] lent_zoo = { "pav", "narvo_nr", "atgabentas", "atgabentas_is" };
	String[] lauk_zoo = new String [ lent_zoo.length ];   

%>
<div class="container">

		<h2 align="center"><strong>Zoologijos Sodas</strong></h2>
		<form method="post" action="">	
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
	
	try { 
	
		connection = DriverManager.getConnection ( connectionUrl + dbName + "?useUnicode=yes&characterEncoding=UTF-8", userId, password );
		String add; 
		String id_gyv = "0";
		id_gyv = request.getParameter( "id_gyv" );
		
		if ( ( ( add = request.getParameter("add")  ) != null ) && add.equals ( "Įvesti" ) ) {
	
			for ( int i = 0; i< lent_zoo.length; i++ ) {
			
				lauk_zoo [ i ] = request.getParameter ( lent_zoo [ i ] );
			}
			
			String sql_ins = "";
			String comma = "";
			
			for ( int i = 0; i < lent_zoo.length; i++ ) {
			
				sql_ins =  sql_ins + comma  + "'" + lauk_zoo [ i ] + "'";
				comma = ",";																												
			}
			
			sql_ins = 
				"INSERT INTO `gyvunai`"
				+ " ( `pav`, `narvo_nr`, `atgabentas`, `atgabentas_is` )"
				+ " VALUES ( "			
				+ sql_ins
				+ " )";

			out.println ( sql_ins );

			statement_change = connection.createStatement();
			resultSetChange = statement_change.executeUpdate(sql_ins);			
			
		 } else {
		 
			if ( add != null ) {

				out.println ( add );
			}
		 } 
		
		statement_take = connection.createStatement();		
		String sql ="SELECT * FROM `gyvunai`  WHERE 1";

		resultSet = statement_take.executeQuery(sql);
		
		String del = "";
		
		if ( ( (  del = request.getParameter("del" ) ) != null) && del.equals ( "del1rec" ) ) {		

			String sql_delete = "DELETE FROM `gyvunai` WHERE `gyvunai`. `id`='"+ id_gyv+"'";
			out.println ( sql_delete );
			statement_change = connection.createStatement();
			resultSetChange = statement_change.executeUpdate(sql_delete);
		}	
	 
		while( resultSet.next() ){
			
		String id_rec = resultSet.getString ( "id" );
					
				
%>
<tr class="lent_vidus">
	<td><%= resultSet.getString ( "id" ) %></td>
	<td><%= resultSet.getString ( "pav" ) %></td>
	<td><%= resultSet.getString  ("narvo_nr" ) %></td>
	<td><%=resultSet.getString ( "atgabentas" ) %></td>
	<td><%=resultSet.getString ( "atgabentas_is" ) %></td>
	<td><input type="button" class="delete" id="toDelete_<%=id_rec %>"data-id_gyv="<%=id_rec %>" value="&#10006;" onClick="iTrinima( <%=id_rec %>)"></td>
</tr>

<% 
		}
	} catch (Exception e) {
	
		e.printStackTrace();
	}
%>
<tr class="lent_vidus">
						
							<td></td>
							<td>
								<input type="text" name="pav" id="pav" value="" required>
							</td>
							<td>
								<input type="text" name="narvo_nr" id="narvo_nr" value="" required>
							</td>							
							<td>
								<input type="text" name="atgabentas" id="atgabentas" value="" required>
							</td>
							<td>
								<input type="text" name="atgabentas_is" id="atgabentas_is" value="" required>
							</td>
							
</table>
<div>
<input type="submit" name="add" value="Įvesti">
</div>
</form>
<form id="del_rec" method="post" action="">
<input type="hidden" name="del" value="del1rec">
<input type="hidden" id="m_del" name="id_gyv" value="0">
</form>

</div>

</body>
</html>