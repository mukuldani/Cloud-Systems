/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class Register extends HttpServlet {
        PrintWriter out;
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try
        {
            out=response.getWriter();
            String txtName=request.getParameter("regName");
            String txtEmail=request.getParameter("regEmail");
            String txtPassword=request.getParameter("regPassword");
            String txtContact=request.getParameter("regContact");
            
   
            Connection con = null;
            Statement stmt = null;
  
            String connectionUrl = "jdbc:sqlserver://localhost:1433;" +
			"databaseName=CloudSystems;user=sa;password=Bvimit@123;";
                

		// Declare the JDBC objects.
                    try
                    {
        		// Establish the connection.
        		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                        //DriverManager.registerDriver(new sun.jdbc.odbc.JdbcOdbcDriver());
            		con = DriverManager.getConnection(connectionUrl);
                        System.out.println("1");
                         //STEP 4: Execute a query
                        try{
                                stmt = con.createStatement();
                                int lastNo=0;
                                System.out.println("2");
                                ResultSet rs=stmt.executeQuery("select (case when max(seq) is null then 0 else"
                                               + " max(seq) end) from Users");
                                while(rs.next()){
                                    lastNo=Integer.parseInt(rs.getString(1));
                                }
                                System.out.println("3");
                                //int rs = stmt.executeUpdate("insert into tbladmin(admID,admName,admPassword,admDOB,admGender,admEmail) values(null,'"+admName+"','"+admPassword+"','"+admDOB+"','"+admGender+"','"+admEmailID+"');");
                                PreparedStatement statement = con.prepareStatement("insert into Users "
                                             + "values('USR"+(lastNo+1)+"',?,?,?,?,"+(lastNo+1)+");");
                                statement.setString(1, txtName);
                                statement.setString(2, txtEmail);
                                statement.setString(3, txtContact);
                                statement.setString(4, txtPassword);
                                int result=statement.executeUpdate();
                                if(result==1){
                                    stmt.close();
                                    con.close();
                                    HttpSession session = request.getSession();
                                    session.setAttribute("UserID","USR"+(lastNo+1));  
                                    session.setAttribute("Username",txtName);  
                                    response.sendRedirect("home.jsp");
                                }else{
                                    stmt.close();
                                    con.close();
                                    response.sendRedirect("index.jsp#download");
                            } 
                        }catch(SQLException  se){
                            System.out.println("sql exception " +se);
                            out.println("sql exception " +se);
                        } 
                    }
                    catch(Exception e)
                    {System.out.println(" exception " +e);}
                    
    
     
        }catch(Exception e){
            System.out.println("exception " +e);
             out.println("in exception"+e);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
