<div class="header">
<div class="well" style="margin:0px;background-color:white">
    <div class="container">
    <div class="col-md-9">
	 <strong><font  size="5px" color="#006400">Java Quiz</font></strong>
	</div> 
	 <div class="col-md-3">
     <% String name1=(String)session.getAttribute("USER");
         if(name1==null){
	%>
			<ul class="nav navbar-nav navbar-right visible-lg">
			 <li><a href="index.jsp"><span class="glyphicon glyphicon-user"></span> sign up</a></li>
			 <li><a href="signin.jsp"><span class="glyphicon glyphicon-log-in"></span> login</a></li>			 
      </ul>
     <%  }else{
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
