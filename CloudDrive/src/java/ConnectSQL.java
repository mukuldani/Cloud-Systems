
import java.sql.*;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Admin
 */
public class ConnectSQL {
    
		Connection con = null;
    ConnectSQL(){
    String connectionUrl = "jdbc:sqlserver://localhost:1433;databaseName=CloudSystems;";
    String username = "sa";
    String password= "Bvimit@123";
                

		// Declare the JDBC objects.
                    try{
        		// Establish the connection.
        		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                    //DriverManager.registerDriver(new sun.jdbc.odbc.JdbcOdbcDriver());
            		con = DriverManager.getConnection(connectionUrl,username,password);
                    }
                    catch(Exception e)
                    {System.out.println("Exception Connection : " +e);}
    }
}
