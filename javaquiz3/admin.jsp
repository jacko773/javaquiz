<!DOCTYPE html> 
<html lang="eng">
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
</head>
<body>
<jsp:include page="header.jsp"/><br/>
<div class="container">
<form action="uploadquestion.jsp" method="get" role="form">
<div class="col-md-6">

     <div class="col-md-12">
	 <label for="dbselect" style="color:pink">select the database:</label>
     <select class="form-control" id="dbselect" name="dbselect">
	    <option>cj30</option>
	    <option>cj60</option>
	    <option>cj120</option>
	    <option>aj30</option>
	    <option>aj60</option>
	    <option>aj120</option>	 
	 </select>
	 </div><br/><br/>
	 <div class="col-md-12">
	 <label for="quizno" style="color:pink">select the quiznumber:</label>
     <input type="text" class="form-control" name="quizno" id="quizno" placeholder="quizno as q1 or q2">
	 </div>
</div>
<div class="col-md-6">

 <div class="form-group">
     <textarea type="text" rows="6" class="form-control" name="ques" value="ques" placeholder="ques"></textarea>
 </div>  
 <div class="form-group">
     <input type="text" class="form-control" name="opt1"  placeholder="option A"></input>
 </div> 
 <div class="form-group">
     <input type="text" class="form-control" name="opt2"  placeholder="option B"></input>
 </div> 
 <div class="form-group">
     <input type="text" class="form-control" name="opt3"  placeholder="option C"></input>
 </div> 
 <div class="form-group">
     <input type="text" class="form-control" name="opt4"  placeholder="option D"></input>
 </div> 
 <div class="form-group">
     <input type="text" class="form-control" name="ans"  placeholder="correct option of the question"></input>
 </div> 
  <div class="form-group">
     <input type="text" class="form-control" name="explanation" placeholder="explanation of the ans"></input>
 </div> 
 <button type="submit" class="btn btn-success btn-block">submit</button>

</div>
</form>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>  
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script> 
</body>
</html>
