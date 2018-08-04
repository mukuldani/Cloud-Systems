<%@page import="java.util.Collections"%>
<%@page import="java.util.Arrays"%>
<%@page import="javax.mail.Message.RecipientType"%>
<%@page import="java.util.Properties"%>
<%@page import="javax.mail.internet.*"%>
<%@page import="javax.mail.*"%>
<%@page import="java.sql.*"%>
<%
    String connectionUrl = "jdbc:sqlserver://localhost:1433;" +
			"databaseName=CloudSystems;user=sa;password=Bvimit@123;";
                

		// Declare the JDBC objects.
		Connection con = null;
		
        	try {
        		// Establish the connection.
        		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                    //DriverManager.registerDriver(new sun.jdbc.odbc.JdbcOdbcDriver());
            		con = DriverManager.getConnection(connectionUrl);
                }catch(Exception e)
                {}
                
String notid="";
notid=request.getParameter("notid");

String stat="";
stat=request.getParameter("s");

PreparedStatement ps=con.prepareStatement("update Notifications set status='"+stat+"' where notid='"+notid+"'");
int i=ps.executeUpdate();
if(i==1)
{
    
    if(stat.equals("1"))
    {
        String fileid="",pass="";
        String userid=session.getAttribute("UserID").toString();
        String recid="";
        try{
         Statement st=con.createStatement();
                        ResultSet rs=st.executeQuery("select fileid,recUser from Notifications where notid='"+notid+"'");
                        while(rs.next())
                        {
                            notid=rs.getString("fileid");
                            recid=rs.getString("recUser");
                        }   
                        
                        if(!fileid.equals(""))
                        {
                           rs=st.executeQuery("select password from Files where fileid='"+fileid+"'");
                        while(rs.next())
                        {
                            pass=rs.getString("password");
                        } 
                            
                            char[] ascii=pass.toCharArray();
            int count=0;
            String key="",result="",resultTemp="",resultActual="";
            String atgs[]=new String[4];
            atgs[0]="00";
            atgs[1]="01";
            atgs[2]="10";
            atgs[3]="11";
            
            
            String A="",T="",G="",S="";
            
            String bit[]=new String[100];
            
            Integer[] arr = new Integer[4];
            for (i = 0; i < arr.length; i++) {
                arr[i] = i;
            }
            Collections.shuffle(Arrays.asList(arr));
            //System.out.println(Arrays.toString(arr));
            
            for(i=0;i<arr.length;i++)
            {
                key+=arr[i];
            }
            
                A=atgs[arr[0]];
                T=atgs[arr[1]];
                G=atgs[arr[2]];
                S=atgs[arr[3]];
                           
            
              for(char ch:ascii){
                System.out.println((int)ch+"  ");
              }
              
              for(char ch:ascii){
                  resultTemp=Integer.toBinaryString(ch);
                  resultTemp=String.format("%08d",Integer.parseInt(resultTemp));
                result+=resultTemp+" ";
                resultActual+=resultTemp;
              }

              System.out.println("Result "+result);
              char[] twodigit=resultActual.toCharArray();
              
              for(i=0;i<100;i++)
                  bit[i]="";
              for(i=0;i<twodigit.length;i++)
              {
                  bit[count]+=twodigit[i];
                  if(i%2!=0)
                  {
                      count++;
                  }
              }
              pass="";
              for(i=0;i<count;i++)
              {
                  if(bit[i].equals(A))
                      pass+="A";
                  else if(bit[i].equals(T))
                      pass+="T";
                  else if(bit[i].equals(G))
                      pass+="G";
                  else if(bit[i].equals(S))
                      pass+="S";
              }
              
               PreparedStatement psFT=con.prepareStatement("insert into FileTrack(userid,recid,fileid,encrykey,pass,ontime,status) values('"+userid+"','"+recid+"','"+fileid+"','"+key+"','"+pass+"',getDate(),0)");
                psFT.executeUpdate();
            
              String message="<div>"+
"<h2 style=\"background-color: #aaaaaa;-webkit-border-radius: 20px 20px 0 0;margin: 0;padding: 0;-moz-border-radius: 20px 20px 0 0;border-radius: 20px 20px 0 0;color: #fff;font-size: 28px;padding: 20px 26px;\"><span class=\"fontawesome-lock\"></span>Cloud Systems</h2>"+
"<fieldset style=\"margin: 0;border: 1px solid #aaa;padding: 0;background-color: #fff;-webkit-border-radius: 0 0 20px 20px;-moz-border-radius: 0 0 20px 20px;border-radius: 0 0 20px 20px;padding: 20px 26px;\">"+
"<p>"+(String)session.getAttribute("Username")+" has shared one file with you</p><p>Use this password to access it</p>"+
"<p style=\"color: #777;margin-bottom: 14px;\"><label for=\"password\">Password</label> : "+pass+"</p>"+
"</fieldset></div>";
              
            PreparedStatement psms=con.prepareStatement("insert into Messages(sender,receiver,message,ontime) values('"+userid+"','"+recid+"','"+message+"',getDate())");
                psms.executeUpdate();
                        
                        
                        String m_subject="Cloud Systems";
                        String m_body="";
                        String m_from="";
                        String m_to="";
                        
                        rs=st.executeQuery("select email from Users where userid='"+recid+"'");
                        while(rs.next())
                        {
                            m_to=rs.getString("email");
                        }
                        rs=st.executeQuery("select email from Users where userid='"+userid+"'");
                        while(rs.next())
                        {
                            m_from=rs.getString("email");
                        }
                        
                         m_body ="<div id=\"login\">\n" +
"\n" +
"		<h2 style='background-color: #aaaaaa;-webkit-border-radius: 20px 20px 0 0;margin: 0;\n" +
"	padding: 0;-moz-border-radius: 20px 20px 0 0;border-radius: 20px 20px 0 0;color: #fff;font-size: 28px;padding: 20px 26px;'><span class=\"fontawesome-lock\"></span>Cloud Systems</h2>\n" +
"\n" +
"\n" +
"			<fieldset style='margin: 0;border: 1px solid #aaa;\n" +
"	padding: 0;background-color: #fff;-webkit-border-radius: 0 0 20px 20px;-moz-border-radius: 0 0 20px 20px;border-radius: 0 0 20px 20px;padding: 20px 26px;'>\n" +
"\n" +
              "<p>"+(String)session.getAttribute("Username")+" has shared one file with you</p><p>Use this otp to access it</p>"+
"				<p style='color: #777;margin-bottom: 14px;'><label for=\"email\">OTP</label> : 3210</p>\n" +
"				<p></p> \n" +
"\n" +
"			</fieldset>\n" +
"	</div> ";
                        
          Session m_Session;
          Message m_simpleMessage;
          InternetAddress m_fromAddress;
          InternetAddress m_toAddress;
          Properties m_properties;

          m_properties     = new Properties();
          m_properties.put("mail.smtp.host", "smtp.gmail.com"); 
          m_properties.put("mail.smtp.socketFactory.port", "465");
          m_properties.put("mail.smtp.socketFactory.class",
                                     "javax.net.ssl.SSLSocketFactory");
          m_properties.put("mail.smtp.auth", "true");
          m_properties.put("mail.smtp.port", "465");

          m_Session=Session.getDefaultInstance(m_properties,new Authenticator() {
               protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication("ajagkar@gmail.com","ybx9edm[]4836"); // username and the password
               }
          });

          m_simpleMessage  =   new MimeMessage(m_Session);
          m_fromAddress    =   new InternetAddress(m_from);
          m_toAddress      =   new InternetAddress(m_to);
          m_simpleMessage.setFrom(m_fromAddress);
          m_simpleMessage.setRecipient(RecipientType.TO, m_toAddress);
          m_simpleMessage.setSubject(m_subject);

          m_simpleMessage.setContent(m_body, "text/html");       

          Transport.send(m_simpleMessage);
                        }
                        
        }catch(Exception e)
        {}
    }
    
    %>
<script>
function goBack() {
    //window.history.back();
    location.replace(document.referrer);
}
goBack();
</script>
<%
}
%>