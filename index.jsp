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
		<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	</head>
<style>
 label, input { display:block; }
    input.text { margin-bottom:12px; width:95%; padding: .4em; }
    fieldset { padding:0; border:0; margin-top:25px; }
    h1 { font-size: 1.2em; margin: .6em 0; }
    div#users-contain { width: 350px; margin: 20px 0; }
    div#users-contain table { margin: 1em 0; border-collapse: collapse; width: 100%; }
    div#users-contain table td, div#users-contain table th { border: 1px solid #eee; padding: .6em 10px; text-align: left; }
    .ui-dialog .ui-state-error { padding: .3em; }
    .validateTips { border: 1px solid transparent; padding: 0.3em; }

#customers {
  font-family: Arial, Helvetica, sans-serif;
  border-collapse: collapse;
  width: 100%;
}

#customers td, #customers th {
  border: 1px solid #ddd;
  padding: 8px;
}

#customers tr:nth-child(even){background-color: #f2f2f2;}

#customers tr:hover {background-color: #ddd;}

#customers th {
  padding-top: 12px;
  padding-bottom: 12px;
  text-align: left;
  background-color: powderblue;
  color: white;
}
</style>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
 <script>
  $( function() {
    var dialog, form,
 
      // From http://www.whatwg.org/specs/web-apps/current-work/multipage/states-of-the-type-attribute.html#e-mail-state-%28type=email%29
      emailRegex = /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/,
	  id = $( "#id" ),
      pav = $( "#pav" ),
      narvo_nr = $( "#narvo_nr" ),
      atgabentas = $( "#atgabentas" ),
	  atgabentas_is = $( "#atgabentas_is" ),
	  allFields = $( [] ).add( id ).add( pav ).add( narvo_nr ).add( atgabentas ).add( atgabentas_is ),
      tips = $( ".validateTips" );
 
    function updateTips( t ) {
      tips
        .text( t )
        .addClass( "ui-state-highlight" );
      setTimeout(function() {
        tips.removeClass( "ui-state-highlight", 1500 );
      }, 500 );
    }
 
    function checkLength( o, n, min, max ) {
      if ( o.val().length > max || o.val().length < min ) {
        o.addClass( "ui-state-error" );
        updateTips( "Length of " + n + " must be between " +
          min + " and " + max + "." );
        return false;
      } else {
        return true;
      }
    }
 
    function checkRegexp( o, regexp, n ) {
      if ( !( regexp.test( o.val() ) ) ) {
        o.addClass( "ui-state-error" );
        updateTips( n );
        return false;
      } else {
        return true;
      }
    }
 
    function addUser() {
      var valid = true;
      allFields.removeClass( "ui-state-error" );
	  
	//  valid = valid && checkLength( id, "id", 1, 16 );
      valid = valid && checkLength( pav, "pav", 1, 1000 );
      valid = valid && checkLength( narvo_nr, "narvo_nr", 1, 10000 );
      valid = valid && checkLength( atgabentas, "atgabentas", 1, 10000 );
	  valid = valid && checkLength( atgabentas_is, "atgabentas_is", 1, 1000 );
	  
	//  valid = valid && checkRegexp( id, /([0-9a-z_\s])+$/i, "Username may consist of a-z, 0-9, underscores, spaces and must begin with a letter." );
      valid = valid && checkRegexp( pav, /([0-9a-z_\s])+$/i, "Username may consist of a-z, 0-9, underscores, spaces and must begin with a letter." );
      valid = valid && checkRegexp( narvo_nr, /([0-9a-z_\s])+$/i,"eg. ui@jquery.com" );
      valid = valid && checkRegexp( atgabentas, /([0-9a-z_\s])+$/i, "Password field only allow : a-z 0-9" );
	  valid = valid && checkRegexp( atgabentas_is, /([0-9a-z_\s])+$/i, "Password field only allow : a-z 0-9" );

 
      if ( valid ) {
		  	 $("#duomenys").submit();
			 alert("asdf")
		/* $( "#customers" ).append( "<tr>" +
		
		  "<td>" + id.val() + "</td>" +
		  "<td>" + pav.val() + "</td>" +
          "<td>" + narvo_nr.val() + "</td>" +
          "<td>" + atgabentas.val() + "</td>" +
		  "<td>" + atgabentas_is.val() + "</td>" +
        "</tr>" );
        dialog.dialog( "close" );*/
     }
	 	 
      return valid;
    }
 
    dialog = $( "#dialog-form" ).dialog({
      autoOpen: false,
      height: 400,
      width: 350,
      modal: true,
      buttons: {
        "Pridėti": addUser,
        "Atšaukti": function() {
          dialog.dialog( "close" );
        }
      },
      close: function() {
        form[ 0 ].reset();
        allFields.removeClass( "ui-state-error" );
      }
    });
 
   /* form = dialog.find( "form" ).on( "submit", function( event ) {
      event.preventDefault();
      addUser();
    });*/
 
    $( "#create-user" ).button().on( "click", function() {
      dialog.dialog( "open" );
	  //++ i redagavima
    });
  } );
  </script>	
<script>
			function iTrinima ( id_rec ) {
			
				mygtukasEdit = document.getElementById ( 'toDelete_' + id_rec );
				
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
		<table id="customers" class="table" align="center" cellpadding="5" cellspacing="5" border="1">
		
			<tr class="lent_virsus">
				<th>Id</th>
				<th>Pavadinimas</th>
				<th>Narvo numeris</th>
				<th>Atgabenimo data</th>
				<th>Atgabenta iš</th>
				<th>Del</th>
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
		
		add = request.getParameter("add");
		
		out.println(add);
		
		if ( ( (  add  ) != null ) && add.equals ( "ivesti" ) ) {
			
	
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
			
		String del = "";
		
		if ( ( (  del = request.getParameter("del" ) ) != null) && del.equals ( "del1rec" ) ) {		

			String sql_delete = "DELETE FROM `gyvunai` WHERE `gyvunai`.`id`='"+ id_gyv+"'";
			out.println ( sql_delete );
			statement_change = connection.createStatement();
			resultSetChange = statement_change.executeUpdate(sql_delete);
		}	
		
		statement_take = connection.createStatement();		
		String sql ="SELECT * FROM `gyvunai`  WHERE 1";

		resultSet = statement_take.executeQuery(sql);
	 
		while( resultSet.next() ){
			
		String id_rec = resultSet.getString ( "id" );
					
		String pav = resultSet.getString ( "pav" );	
%>
<tr class="lent_vidus">
	<td><%= resultSet.getString ( "id" ) %></td>
	<td><%= pav %></td>
	<td><%= resultSet.getString  ("narvo_nr" ) %></td>
	<td><%= resultSet.getString ( "atgabentas" ) %></td>
	<td><%= resultSet.getString ( "atgabentas_is" ) %></td>
	<td><input type="button" class="delete" id="toDelete_<%=id_rec %>" data-id_gyv="<%= id_rec %>" data-pav="<%= pav %>"  value="&#10006;" onClick="iTrinima( <%=id_rec %>)"></td>
</tr>

<% 
		}
	} catch (Exception e) {
	
		e.printStackTrace();
	}
%>
<!--<tr class="lent_vidus">
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
							<td></td>-->
							
</table>
<!--<div>
<input type="submit" name="add" value="ivesti">
</div>-->
</form>
<form id="del_rec" method="post" action="">
<input type="hidden" name="del" value="del1rec">
<input type="hidden" id="m_del" name="id_gyv" value="0">
</form>

<div id="dialog-form" title="Pridėti naują gyvūną">
  <p class="validateTips">Privaloma užpildyti visus laukelius</p>
 
  <form id="duomenys" method="post">
    <fieldset>
	<label for="id">Id</label>
    <input type="text" name="id" id="id" value="" class="text ui-widget-content ui-corner-all">
    <label for="tipas">Pavadinimas</label>
    <input type="text" name="pav" id="pav" value="" class="text ui-widget-content ui-corner-all">
	<label for="pav">Narvo Numeris</label>
    <input type="text" name="narvo_nr" id="narvo_nr" value="" class="text ui-widget-content ui-corner-all">
	<label for="name">Atgabentas</label>
    <input type="text" name="atgabentas" id="atgabentas" value="" class="text ui-widget-content ui-corner-all">
	<label for="name">Atgabentas iš</label>
    <input type="text" name="atgabentas_is" id="atgabentas_is" value="" class="text ui-widget-content ui-corner-all">
	<input type="hidden" name="add" value="ivesti">
	  
 
      <!-- Allow form submission with keyboard without duplicating the dialog button -->
      <input type="submit" tabindex="-1" style="position:absolute; top:-1000px">
    </fieldset>
  </form>
</div>
<button id="create-user">Pridėti naują gyvūną</button>


</div>

</body>
</html>