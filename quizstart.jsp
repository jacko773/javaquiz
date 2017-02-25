<%@ page import="java.sql.*"%>
<% String database=request.getParameter("db");
   String table=request.getParameter("tablenum"); 
   
%>
 <!DOCTYPE html>  
<html lang="en">  
<head>  
  <title></title>  
  <meta name="viewport" content="width=device-width, initial-scale=1">  
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">     
</head>  
<body>  
<jsp:include page="header.jsp"/>  
<div class="fluid-container">
     <div class="col-md-10"style="border-right:1px solid #E5E7E9  ">
	
         <div class="ques" style="height:480px">
		 
         </div>
		 
         <div>                  
             <ul class="pager">  
                 <li id="previous1"><a class='i' href="#">&laquo; Previous</a></li>  
                 <li id="next"><a href="#">save & Next                    &raquo;</a></li>
                 <li id="submit"><a href="#">&laquo; submit &raquo;</a></li>				 
             </ul>  
         </div>  
     </div> 
	 
     <div class="col-md-2">
	 
     </div>
</div> 
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>  
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>  
<script>
     $(document).ready(function(){
		 var arr=[];
		 var quesno=1;
		 if(quesno==1){
			 $('.i').bind('click', function(e){
        e.preventDefault();
     });
		 }
		 var tab="<%=table%>";
		 var database="<%=database%>";
		 $("#next").click(function(){
			 if(quesno<10){
			 if($("input[name='gender']:checked").val()){
			 arr[quesno]=(($('input:radio[name=gender]:checked').val()).toString());
			 }
			 quesno+=1;
			  $.get("question.jsp",{db:database,tablenum:tab,quesnum:quesno},function(data){
             $(".ques").html(data);
			 var v=arr[quesno];
                 if(v=='A'){
					 $('input:radio[name=gender]:nth(0)').attr('checked',true);			
				 }else if(v=='B'){
					 $('input:radio[name=gender]:nth(1)').attr('checked',true);
				 }else if(v=='C'){
					 $('input:radio[name=gender]:nth(2)').attr('checked',true);
				 }else if(v=='D'){
					 $('input:radio[name=gender]:nth(3)').attr('checked',true);
				 }
			 
    });	
			 }	
			 if(quesno==10){
				 if($("input[name='gender']:checked").val()){
			 arr[quesno]=(($('input:radio[name=gender]:checked').val()).toString());
			 }
			 }
		});	
     $("#previous1").click(function(){
		 if(quesno>1){
			 quesno-=1;	               			 
			  $.get("question.jsp",{db:database,tablenum:tab,quesnum:quesno},function(data){
             $(".ques").html(data);
			  var v=arr[quesno];
                 if(v=='A'){
					 $('input:radio[name=gender]:nth(0)').attr('checked',true);			
				 }else if(v=='B'){
					 $('input:radio[name=gender]:nth(1)').attr('checked',true);
				 }else if(v=='C'){
					 $('input:radio[name=gender]:nth(2)').attr('checked',true);
				 }else if(v=='D'){
					 $('input:radio[name=gender]:nth(3)').attr('checked',true);
				 }		 			 
    });		
		 }	
		});	

     $(window).load(function() {
       $.get("question.jsp",{db:database,tablenum:tab,quesnum:quesno},function(data){
             $(".ques").html(data);	
     
});		
	});
	$("#submit").click(function(){
		sessionStorage.setItem('myArray',arr);
		window.location.href = "result.jsp";
	});
	});
</script>
</body>  
</html>  