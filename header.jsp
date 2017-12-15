<div class="header">
<div class="well" style="margin:0px;background-color:white">
    <div class="container">
    <div class="col-md-9">
	 <strong><font  size="5px" color="green">Java Quiz</font></strong>
	</div> 
	 <div class="col-md-3">
     <% String name1=(String)session.getAttribute("USER");
         if(name1==null){	
         }else{
	 %>
	 
	    <div class="col-md-7 col-sm-6">
	       <a data-toggle="dropdown" href="#dropdownmenu1"><% out.print("welcome@"+name1+"! "); %></a>
			<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1"> 
                <li role="presentation"> 
                      <a role="menuitem" tabindex="-1" href="#">profile</a>
				</li>	  
                 
                <li role="presentation"> 
                      <a role="menuitem" tabindex="-1" href="#">setting</a> 
                </li>				 
	        </ul>
		</div>
		<div class="col-md-5 col-sm-6 ">
		     <a href="logout.jsp">logout</a>
        </div>   			 
      	  
            <% }
                 %>    
     </div>
    </div>    
</div>

</div>
