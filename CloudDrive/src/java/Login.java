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

/**
 *
 * @author Admin
 */
public class Login extends HttpServlet {
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
            String txtEmail=request.getParameter("loginEmail");
            String txtPassword=request.getParameter("loginPassword");
        
        //String DB_URL = "jdbc:mysql://localhost:3306/cloudsystems";
        
   //  Database credentials
   String USER = "root";
   String PASS = "";
   
   Connection con = null;
   Statement stmt = null;
  
   ConnectSQL cn=new ConnectSQL();
   con=cn.con;
   
   
      //STEP 2: Register JDBC driver
      /*Class.forName("com.mysql.jdbc.Driver").newInstance();

      conn = DriverManager.getConnection(DB_URL,USER,PASS);*/
               
      //STEP 4: Execute a query
      stmt = con.createStatement();
      int lastNo=0;
      ResultSet rs=stmt.executeQuery("select * from Users where email='"+txtEmail+"' and password='"+txtPassword+"'");
      if(rs.next())
      {
          
          
        HttpSession session = request.getSession();

        session.setAttribute("UserID",rs.getString(1));  
        session.setAttribute("Username",rs.getString(2)); 
           
          stmt.close();
          con.close();
           response.sendRedirect("home.jsp");
           
                  
      }else
      {
          stmt.close();
          con.close();

           response.sendRedirect("index.jsp#download");
      }
      
   }catch(SQLException se){
      //Handle errors for JDBC
      out.println("in 2 exception"+se);
   }catch(Exception e){
      //Handle errors for Class.forName
      out.println("in 1 exception"+e);
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
