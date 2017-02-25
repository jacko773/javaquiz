<script>
	     $(document).ready(function(){
		     $("ul li:eq(1)").click(function(){
				 $(".content").html(Name:<input type="text" value"name"/>
				                    Password:<input type="password" value="password">  
				 
				);
			 });
			 
			 $("ul li:eq(0)").click(function(){
				 $(".content").html(Name:<input type="text" value"name"/>
				                    Password:<input type="password" value="password">  
				 
				);
			 });
			 $("ul li:eq(1)").hover(function(){
				$(this).css("backgroundColor","brown");
   			 });
		 
		 });
</script>