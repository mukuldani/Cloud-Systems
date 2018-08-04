/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.List;
 
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;


import java.util.ArrayList;
import java.util.Calendar;
import java.util.LinkedList;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.apache.commons.io.FilenameUtils;
import org.cloudbus.cloudsim.Datacenter;
import org.cloudbus.cloudsim.DatacenterBroker;
import org.cloudbus.cloudsim.DatacenterCharacteristics;
//import org.cloudbus.cloudsim.File;
import org.cloudbus.cloudsim.HarddriveStorage;
import org.cloudbus.cloudsim.Host;
import org.cloudbus.cloudsim.Pe;
import org.cloudbus.cloudsim.Storage;
import org.cloudbus.cloudsim.VmAllocationPolicySimple;
import org.cloudbus.cloudsim.VmSchedulerTimeShared;
import org.cloudbus.cloudsim.core.CloudSim;
import static org.cloudbus.cloudsim.examples.power.Helper.createBroker;
import org.cloudbus.cloudsim.provisioners.BwProvisionerSimple;
import org.cloudbus.cloudsim.provisioners.PeProvisionerSimple;
import org.cloudbus.cloudsim.provisioners.RamProvisionerSimple;
/**
 *
 * @author sipl-1
 */
public class FileUploadServlet extends HttpServlet {

   private static final long serialVersionUID = 1L;
     
    // location to store file uploaded
    private static final String UPLOAD_DIRECTORY = "upload";
 
    // upload settings
    private static final int MEMORY_THRESHOLD   = 1024 * 1024 * 3;  // 3MB
    private static final int MAX_FILE_SIZE      = 1024 * 1024 * 50; // 40MB
    private static final int MAX_REQUEST_SIZE   = 1024 * 1024 * 50; // 50MB
    String fileName,displayName="",filePath,extension,size,alerts,description,encryption,password,parentid;
 PrintWriter writer;
    /**
     * Upon receiving file upload submission, parses the request to read
     * upload data and saves the file on disk.
     */
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        
        long startTime = System.currentTimeMillis();
        // checks if the request actually contains upload file
        if (!ServletFileUpload.isMultipartContent(request)) {
            // if not, we stop here
            writer = response.getWriter();
            writer.println("Error: Form must has enctype=multipart/form-data.");
            writer.flush();
            return;
        }
        
        
 
        // configures upload settings
        DiskFileItemFactory factory = new DiskFileItemFactory();
        // sets memory threshold - beyond which files are stored in disk
        factory.setSizeThreshold(MEMORY_THRESHOLD);
        // sets temporary location to store files
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));
 
        ServletFileUpload upload = new ServletFileUpload(factory);
         
        // sets maximum size of upload file
        upload.setFileSizeMax(MAX_FILE_SIZE);
         
        // sets maximum size of request (include file + form data)
        upload.setSizeMax(MAX_REQUEST_SIZE);
 
        // constructs the directory path to store upload file
        // this path is relative to application's directory
        String uploadPath = getServletContext().getRealPath("")+ File.separator + UPLOAD_DIRECTORY;
        //String uploadPath = "~/CloudDrive/"+ File.separator + UPLOAD_DIRECTORY; 
        // creates the directory if it does not exist
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
 
                try {

                    // parses the request's content to extract file data
                    @SuppressWarnings("unchecked")      
                    List<FileItem> formItems = upload.parseRequest(request);

                    if (formItems != null && formItems.size() > 0) {
                        // iterates over form's fields
                        for (FileItem item : formItems) {
                            // processes only fields that are not form fields
                            if (!item.isFormField()) {
                                //java.io.PrintWriter out = response.getWriter( );

                                String message="";
                                /*New*/
                                int num_user = 1;
                    Calendar calendar = Calendar.getInstance();
                    boolean trace_flag = false;
                    CloudSim.init(num_user, calendar, trace_flag);


                    message+=("\nCalender"+calendar);

                    //******************************************************
                    //Creating 3 Storages
                    HarddriveStorage hd1 = new HarddriveStorage(MAX_FILE_SIZE);

                    message+=("\n* * *");
                    message+=("\nUsed disk space on hd1=" + hd1.getCurrentSize());
                    message+=("\n* * *");



                    fileName = new File(item.getName()).getName();
                    //int size = Integer.parseInt(""+new File(item.getName()).getTotalSpace());
                    filePath = uploadPath + File.separator + fileName;
                    File storeFile = new File(filePath);
                    extension=FilenameUtils.getExtension(fileName);
                    size=""+item.getSize();
                    org.cloudbus.cloudsim.File file1 = new org.cloudbus.cloudsim.File(fileName,Integer.parseInt(size));
                    hd1.addFile(file1);

                    LinkedList<Storage> hdList = new LinkedList<Storage>();
                    hdList.add(hd1);
                    // saves the file on disk
                    item.write(storeFile);

                    Datacenter mydc = createDatacenter("MyDC", hdList);

                    DatacenterBroker broker = createBroker();
                    int brokerId = broker.getId();


                    CloudSim.startSimulation();


                    message+=("\n* * *");
                    message+=("\nUsed disk space on hd1=" + hd1.getCurrentSize());
                    message+=("\n* * *");

                    request.setAttribute("message",
                        "Upload has been done successfully!\n\n");
                    request.setAttribute("message2",message);


                }
                else
                {
                    switch (item.getFieldName()) {
                        case "txtDisplayName":
                            displayName=item.getString();
                            break;
                        case "txtDescription":
                            description=item.getString();
                            break;
                        case "txtAlerts":
                            alerts=item.getString();
                            break;
                        case "txtEncryption":
                            encryption=item.getString();
                            break;
                        case "txtPassword":
                            password=item.getString();
                            break;
                        case "txtParent":
                            parentid=item.getString();
                            break;
                    }
                }
            }
   
    ConnectSQL cn=new ConnectSQL();
                        
   Connection con = null;
   Statement stmt = null;
  
    con=cn.con;
   
      //STEP 4: Execute a query
      stmt = con.createStatement();
      int lastNo=0;
      ResultSet rs=stmt.executeQuery("select (case when max(seq) is null then 0 else max(seq) end) from files");
      while(rs.next())
      {
           lastNo=Integer.parseInt(rs.getString(1));
      }
long endTime   = System.currentTimeMillis();
long totalTime = endTime - startTime;
        //int rs = stmt.executeUpdate("insert into tbladmin(admID,admName,admPassword,admDOB,admGender,admEmail) values(null,'"+admName+"','"+admPassword+"','"+admDOB+"','"+admGender+"','"+admEmailID+"');");
PreparedStatement statement = con.prepareStatement("insert into Files values('F"+(lastNo+1)+"',?,?,?,?,?,?,?,?,?,?,getDate(),"+(int)(totalTime)+",0,"+(lastNo+1)+",?);");
      statement.setString(1, fileName);
      HttpSession session = request.getSession();
      statement.setString(2, (String)session.getAttribute("UserID"));
      if(!displayName.equals(""))
      statement.setString(3, displayName);
      else
      statement.setString(3, fileName);    
      statement.setString(4, "upload/"+ fileName);
      statement.setString(5, encryption);
      statement.setString(6, password);
      statement.setString(7, extension);
      statement.setString(8, size);
      statement.setString(9, description);
      statement.setString(10, alerts);
      statement.setString(11, parentid.trim());
        int result=statement.executeUpdate();
        if(result==1)
        {
             // redirects client to message page
        getServletContext().getRequestDispatcher("/fileDetails.jsp?fileid=F"+(lastNo+1)).forward(
                request, response);
        }
        else
        {
            PrintWriter out=response.getWriter();
            //out.print("insert into file values('F"+(lastNo+1)+"',?,?,?,?,?,?,?,?,?,?,now(),0,"+(lastNo+1)+",?);");
        }
            }
        } catch (Exception ex) {
            PrintWriter out=response.getWriter();
            out.print(""+ex);
        }
       
    }
    
    private static Datacenter createDatacenter(String name,LinkedList<Storage> hdList){

		// Here are the steps needed to create a PowerDatacenter:
		// 1. We need to create a list to store one or more
		//    Machines
		List<Host> hostList = new ArrayList<Host>();

		// 2. A Machine contains one or more PEs or CPUs/Cores. Therefore, should
		//    create a list to store these PEs before creating
		//    a Machine.
		List<Pe> peList1 = new ArrayList<Pe>();

		int mips = 1000;

		// 3. Create PEs and add these into the list.
		//for a quad-core machine, a list of 4 PEs is required:
		peList1.add(new Pe(0, new PeProvisionerSimple(mips))); // need to store Pe id and MIPS Rating
		peList1.add(new Pe(1, new PeProvisionerSimple(mips)));
		peList1.add(new Pe(2, new PeProvisionerSimple(mips)));
		peList1.add(new Pe(3, new PeProvisionerSimple(mips)));

		//Another list, for a dual-core machine
		List<Pe> peList2 = new ArrayList<Pe>();

		peList2.add(new Pe(0, new PeProvisionerSimple(mips)));
		peList2.add(new Pe(1, new PeProvisionerSimple(mips)));

		//4. Create Hosts with its id and list of PEs and add them to the list of machines
		int hostId=0;
		int ram = 2048; //host memory (MB)
		long storage = 1000000; //host storage
		int bw = 10000;

		hostList.add(
    			new Host(
    				hostId,
    				new RamProvisionerSimple(ram),
    				new BwProvisionerSimple(bw),
    				storage,
    				peList1,
    				new VmSchedulerTimeShared(peList1)
    			)
    		); // This is our first machine

		hostId++;

		hostList.add(
    			new Host(
    				hostId,
    				new RamProvisionerSimple(ram),
    				new BwProvisionerSimple(bw),
    				storage,
    				peList2,
    				new VmSchedulerTimeShared(peList2)
    			)
    		); // Second machine


		//To create a host with a space-shared allocation policy for PEs to VMs:
		//hostList.add(
    	//		new Host(
    	//			hostId,
    	//			new CpuProvisionerSimple(peList1),
    	//			new RamProvisionerSimple(ram),
    	//			new BwProvisionerSimple(bw),
    	//			storage,
    	//			new VmSchedulerSpaceShared(peList1)
    	//		)
    	//	);

		//To create a host with a oportunistic space-shared allocation policy for PEs to VMs:
		//hostList.add(
    	//		new Host(
    	//			hostId,
    	//			new CpuProvisionerSimple(peList1),
    	//			new RamProvisionerSimple(ram),
    	//			new BwProvisionerSimple(bw),
    	//			storage,
    	//			new VmSchedulerOportunisticSpaceShared(peList1)
    	//		)
    	//	);


		// 5. Create a DatacenterCharacteristics object that stores the
		//    properties of a data center: architecture, OS, list of
		//    Machines, allocation policy: time- or space-shared, time zone
		//    and its price (G$/Pe time unit).
		String arch = "x86";      // system architecture
		String os = "Linux";          // operating system
		String vmm = "Xen";
		double time_zone = 10.0;         // time zone this resource located
		double cost = 3.0;              // the cost of using processing in this resource
		double costPerMem = 0.05;		// the cost of using memory in this resource
		double costPerStorage = 0.1;	// the cost of using storage in this resource
		double costPerBw = 0.1;			// the cost of using bw in this resource
		LinkedList<Storage> storageList = new LinkedList<Storage>();	//we are not adding SAN devices by now

                storageList=hdList;
		DatacenterCharacteristics characteristics = new DatacenterCharacteristics(
                arch, os, vmm, hostList, time_zone, cost, costPerMem, costPerStorage, costPerBw);


		// 6. Finally, we need to create a PowerDatacenter object.
		Datacenter datacenter = null;
		try {
			datacenter = new Datacenter(name, characteristics, new VmAllocationPolicySimple(hostList), storageList, 0);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return datacenter;
    }
}

