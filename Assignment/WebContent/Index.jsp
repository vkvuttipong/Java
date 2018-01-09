<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.File" %>
<%@ page import=" java.io.FileWriter" %>
<%@ page import="java.io.FileReader" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.io.IOException" %>
<%@ page import="java.util.concurrent.TimeUnit" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.JSONArray" %>
 
 <%!
 
 public class calculator_price 
 {	
	public final Double Casemoreone  = 1.00;
	public final Double Seconds  = 60.00; 
	public final Double Minutes  = 60.00; 
	public Double Cal_Zero() 
	{
		final Double Price = 3.00;	
		return Price;	
    }
	public Double Cal_MoreZero(long diffHours,long diffMinutes,long diffSeconds) 
	{
		Double Price  ;
		Double SummarySecBath = ((diffSeconds * Casemoreone) / Seconds);
		Double SummaryMinutes = Minutes * diffHours;
		Double SummaryTime = SummaryMinutes+ diffMinutes;
		Double Summaryprice = (SummaryTime - 1) + 3;
		Price = Summaryprice +SummarySecBath ;
		return Price;	
    }
}
%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
table, th, td {
    border: 1px solid black;
    border-collapse: collapse;
}
th, td {
    padding: 15px;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title> Assignment JSP</title>
</head>

<body>
 <h2>The cost of each customer. : <br></h2>
 <p> You can click to export the file .Json Data .: In Path D:\App\promotion2.json</p>
 
 
 


 <table style="width:100%"  >
 
   <tr>
    <th>No.</th> 
    <th>Date</th>
    <th>Start Time</th>
    <th>End Time</th>
    <th>Mobile Number</th> 
    <th>Promotion</th> 
    <th>Price (Bath)</th>
   
   
  </tr>
	<% 
	String path = "D:\\App\\promotion1.log";
	File file = new File(path);
	 FileWriter fileWrite = new FileWriter("D:\\App\\promotion2.json");
	calculator_price Gen = new calculator_price();
	String getdate,getstarttime,getendtime,getmobile,getpro;
	
	Double Resultcal;
	Integer gethour, Getmin, Getsec;

	String OutPrice;
    Integer LineNumber = 0;
    String[] linestr;
    Double Price;  
   
	try {
		
		BufferedReader br = new BufferedReader(new FileReader(file));
		String line;
		
		while ((line = br.readLine()) != null) 
		
		   {
			
			LineNumber += 1;	
			Date startTime = null;
	        Date endTime = null;
			linestr = line.split("\\|");
			getdate = linestr[0];
			getstarttime =  linestr[1];
            getendtime = linestr[2];
            getmobile = linestr[3];
            getpro = linestr[4];
            
           // String str = "08:03:10 pm";
            SimpleDateFormat formatter = new SimpleDateFormat("HH:mm:ss");
            Date dateS = (Date)formatter.parse(getstarttime);
            Date dateE = (Date)formatter.parse(getendtime);
					
			long diff = dateE.getTime() - dateS.getTime();
			long diffSeconds = diff / 1000 % 60;        
			long diffMinutes = diff / (60 * 1000) % 60;        
			long diffHours = diff / (60 * 60 * 1000); 			
			long seconds = TimeUnit.MILLISECONDS.toSeconds(diff);
			long minutes = TimeUnit.MILLISECONDS.toMinutes(diff); 		 
			 
			 if ( (diffHours <= 0)  && (diffMinutes <= 0)  )  //
			 {
				 Price = 3.00;
				 	
				 	Price = Gen.Cal_Zero();			 
			 }
			 else
			 {		
				    Price = Gen.Cal_MoreZero(diffHours, diffMinutes, diffSeconds); 
             }
			 
			// out.println("Price " + Price +" Bath "+ "<br>" );
			 String PriceString = String.format ("%,.2f", Price);
			 
			 %>
			  
			 <tr>
			     <td> <%= LineNumber %></td>  
			     <td> <%= getdate %></td>  
			     <td> <%= getstarttime %></td>
			     <td> <%= getendtime %></td>
			     <td> <%= getmobile %></td>        
			     <td> <%= getpro %></td>  
                 <td> <%= PriceString %></td>
 
              </tr>
				
			 <% 
			 
			 JSONObject obj = new JSONObject();
				obj.put("MobileNo", getmobile);
				obj.put("Price", PriceString);		
			    fileWrite.write(obj.toJSONString());
			 
		}
		fileWrite.close();
		%>
 
		
		<% 
	 
		
			 

	//	JSONObject obj = new JSONObject();
	//	obj.put("Name", "crunchify.com");
	//	obj.put("Author", "App Shah");
 
		//JSONArray company = new JSONArray();
		//company.add("Compnay: eBay");
		//company.add("Compnay: Paypal");
		//company.add("Compnay: Google");
		//obj.put("Company List", company);
		
		 
		 
			// try-with-resources statement based on post comment below :)
			//try (FileWriter file = new FileWriter("/Users/<username>/Documents/file1.txt")) {
			//	file.write(obj.toJSONString());
				
				
			//}
		
		
		br.close();
	} catch (IOException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		out.println("err" +e.toString());
	}

	%>
 
    </table>
</body>
</html>