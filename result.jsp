<html>
<head>
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>  
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>  
</head>

<body>


<button id="get">your ans are</button>
     <script>
	     $(document).ready(function(){
			 var newHTML=[];
			 $('#get').on('click', function(){
            var myArray = sessionStorage.getItem('myArray');
			for (var i = 0; i < myArray.length; i++) {
    newHTML.push('<span>'+i+'-'+ myArray[i] + '</span><br/>');
}
$("#result").html(newHTML.join(""));
});			 
		 });
	 </script>
	 <div>
	 <table>
	 </table>
	 </div>
</body>
</html>