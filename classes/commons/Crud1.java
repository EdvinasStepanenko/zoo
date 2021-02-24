
	package commons;
	
	import java.sql.DriverManager;
	import java.sql.ResultSet;
	import java.sql.Statement;
	import java.sql.Connection;

	public class Crud1 {
		
		public String[] lent_lauk;
		public String name_db;
		public String passwd;
		public String serv; 
		public String lent;
		public String user;
		
		private Connection connection = null;
		private Statement statement_take = null;
		private Statement statement_change = null;
		private ResultSet resultSet = null;
		private int resultSetChange;
		private String comma = "";

		public Crud1() {
			
		}
		
		public Crud1 ( String name_database, String user_name, String password, String server, String lentele, String[] lent_laukai ) {
			
			name_db = name_database;
			user = user_name;
			passwd = password;
			serv = server;
			lent = lentele;
			lent_lauk = lent_laukai;
			
			try {
			
				connection = DriverManager.getConnection ( serv + name_db + "?useUnicode=yes&characterEncoding=UTF-8", user, password );
				
			} catch( Exception e ) {
				
				e.printStackTrace( System.out );
				
			}
		}
		
		public Integer papildyti ( String[] lent_lauk_reiksmes ) {
			
			String sql_ins = "";
			String str_lauk = "";

			
			for ( int i = 0; i < lent_lauk.length; i++ ) {
			
				str_lauk = str_lauk + comma + "`" + lent_lauk [ i ] + "`";
				sql_ins =  sql_ins + comma  + "'" + lent_lauk_reiksmes [ i ] + "'";
				comma = ",";																													// sql_ins = sql_ins + "'" + Miestai.value + "'";
			}
			
			sql_ins = 
				"INSERT INTO `" + lent + "`"
				+ " ( " + str_lauk + " )"
				+ " VALUES ( "			
				+ sql_ins
				+ " )";

			System.out.println ( sql_ins );
			
			
			try {

				statement_change = connection.createStatement();
				resultSetChange = statement_change.executeUpdate(sql_ins);			
				
			} catch ( Exception e ) {
				
				e.printStackTrace( System.out );
			}
			return resultSetChange;
		}
		
		public Integer update ( String[] lent_lauk_reiksmes, String id_iraso ) {
			
			String sql_upd = "";
			comma = ",";	

			sql_upd += "UPDATE `" + lent + "` SET " ;
			
				for ( int i = 0; i < lent_lauk.length; i++ ) {
				
				sql_upd += "`" + (  lent_lauk [ i ]  ) +"`";
				sql_upd += "='" + (  lent_lauk_reiksmes [ i ] ) + "'" + comma; 
				} 
				
				sql_upd = sql_upd.substring(0,sql_upd.length()- 1);
				
				sql_upd += " WHERE `" + lent + "`.`id` ='"+ id_iraso +"'";
			
			System.out.println ( sql_upd );
			
			try {

				statement_change = connection.createStatement();
				resultSetChange = statement_change.executeUpdate(sql_upd);			
				
			} catch ( Exception e ) {
				
				e.printStackTrace( System.out );
			}
			return resultSetChange;
		}		
		
		
		public String lentele()  {
			
			try {
			
				statement_take = connection.createStatement();		
				String sql ="SELECT * FROM `" + lent + "`  WHERE 1";

				resultSet = statement_take.executeQuery( sql );
			 
				while( resultSet.next() ){
					
					
					lent += "<tr>";
					lent += "<td><input type=\"button\" class=\"record_edit\" data-id_miesto=\"\" value=\"&#9998;\"></td>";
		
					for ( int i = 0; i < lent_lauk.length; i++ ) {
				
						lent += "<td>" + resultSet.getString (  lent_lauk [ i ]  ) + "</td>";

					}
					lent += "</tr>";

				}
				
			} catch( Exception e ) {
				
				e.printStackTrace( System.out );
			}				
			return lent;
		}
	}