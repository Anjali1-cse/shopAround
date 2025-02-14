<%-- 
    Document   : dispatched_order
    Created on : Mar 26, 2013, 9:36:44 PM
    Author     : user
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0//EN" "http://www.w3.org/TR/REC-html40/strict.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script>
         function snd()
         {
             var o_id=document.form1.srch.value;
             if(o_id=="")
                 alert("Enter Order No");
             else
                  window.location.replace("dispatched_order_search.jsp?o_id="+o_id);
         }
  
         function dlt(o_id)
                {
                    var r=confirm("Are you sure!");
                    if (r==true)
                      {
                        window.location.replace("delete_order.jsp?o_id="+o_id);
                      }
                }
        </script>
    </head>
    <body>
        <div class="shell">
            <div style="min-height: 600px">
        <%@include file="header.jsp"%>
        <%@include file="drop_down_menu.jsp"%>
        <br><br><br><br>
        <center><p style="color: red; font-size: 15px"><u><b>DISPATCHED ORDERS</b></u></p></center>
        <form name="form1">
            <table width="300" height="40" border="0" align="right">
                <tr>
                    <td align="right">
                    <input type="text" placeholder="Enter Order No" style="height: 25px; border:solid 1px #999999;"  size="35" name="srch">
                    <input type="button" value="Search" onclick="snd()" style="width: 60px; height: 28px; border:solid 1px #999999; background-color: #990000; color: white; font-size: 12px">
                </td>
                </tr>
            </table>
       </form>  
        <br>
        
        <%
        Connection con=null;
           Statement st=null;
           ResultSet rs=null;
           Statement st1=null;
           ResultSet rs1=null;
           Statement st2=null;
           ResultSet rs2=null;
           Statement st3=null;
           ResultSet rs3=null; 
           Statement st4=null;
           ResultSet rs4=null;
           
           
           try{
               Class.forName("oracle.jdbc.driver.OracleDriver");
               con=DriverManager.getConnection
                  ("jdbc:oracle:thin:@127.0.0.1:1521:xe","eshopping","nolin");
               st=con.createStatement();
               st1=con.createStatement();
               st2=con.createStatement();
               st3=con.createStatement();
               st4=con.createStatement();
          
               String dispatched="dispatched"; 
               rs=st.executeQuery("select * from order_item where status='"+dispatched+"' order by o_id desc");
        %>
        
        
              <table width="960" border="0">
                  <tr>
    <th width="35" height="65" scope="col" style="border:solid 2px #dedede; color: #000000">Order No</th>
    <th width="35" scope="col" style="border:solid 2px #dedede; color: #000000">Date</th>
    
    <th width="90" scope="col" style="border:solid 2px #dedede; color: #000000">Item Name</th>
    <th width="60" scope="col" style="border:solid 2px #dedede; color: #000000">Category</th>
    <th width="62" scope="col" style="border:solid 2px #dedede; color: #000000">Brand</th>
    <th width="20" scope="col" style="border:solid 2px #dedede; color: #000000">Quantity</th>
    
    <th width="60" scope="col" style="border:solid 2px #dedede; color: #000000">Sub Total</th>
    <th width="60" scope="col" style="border:solid 2px #dedede; color: #000000">Grand Total</th>
    <th width="20" scope="col" style="border:solid 2px #dedede; color: #000000">Details</th>
    <th width="20" scope="col" style="border:solid 2px #dedede; color: #000000">Delete</th>
    
  </tr>
  
  <%
               while(rs.next())
               {     
                 int rc=0;
                 rs1=st1.executeQuery("select total_price from cart1 where cart_id='"+rs.getString(2)+"'");
                 rs1.next();
                 rs2=st2.executeQuery("select i_name,c_id,brand_name,quantity,price from item,cart_item1 where item.i_id=cart_item1.i_id and cart_item1.cart_id='"+rs.getString(2)+"'");     
                 while(rs2.next()){
                     rs4=st4.executeQuery("select c_name from category where c_id='"+rs2.getString(2)+"'");
                     rs4.next();
                     String category=rs4.getString(1);
                 if(rc==0){
               %>   
          <tr>
            <td height="37" align="center">ORD0<%=rs.getString(1)%></td>
            <td align="center"><%=rs.getString(3).substring(0, 10) %></td>
            <td align="center"><%=rs2.getString(1)%></td>
            <td align="center"><%=category%></td>
            <td align="center"><%=rs2.getString(3)%></td>
            <td align="center"><%=rs2.getString(4)%></td>
            <td align="center"><%=rs2.getString(5)%></td>
            <td align="center"><%=rs1.getString(1) %></td>
            <td align="center"><a href="place_order.jsp?o_id=<%=rs.getString(1)%>">Details</a></td>
            <td align="center"><a href="#" onclick="dlt(<%=rs.getString(1)%>)">Delete</a></td>
          </tr>
              <% } 
                   else if(rc>0)
                   {
                    %>     
             <tr>
            <td height="37" align="center"></td>
            <td align="center"></td>
            <td align="center"><%=rs2.getString(1)%></td>
            <td align="center"><%=category%></td>
            <td align="center"><%=rs2.getString(3)%></td>
            <td align="center"><%=rs2.getString(4)%></td>
            <td align="center"><%=rs2.getString(5)%></td>
            <td align="center"></td>
          </tr>
                <% }
                       rc++; }
              } 
               } catch(Exception e){}
              finally
              {
                  try{
                     con.close();
                  }catch(Exception e){}
              }   
                %>
          
  </table>
                 
        
            </div>
        <%@include file="footer.jsp"%>
        </div>
        
        <%
if(session.getAttribute("del")=="suc_del")
        {
                   %><script language="javascript">alert("Successfully deleted");</script><%
                   session.removeAttribute("del");
        }
else if(session.getAttribute("del")=="cant_del")     
        {
                   %><script language="javascript">alert("Cant delete");</script><%
                   session.removeAttribute("del");
        }
        %>
        
    </body>
</html>
