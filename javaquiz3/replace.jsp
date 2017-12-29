<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>replaceWith demo</title>
  <style>
  button {
    display: block;
    margin: 3px;
    color: red;
    width: 200px;
  }
  div {
    color: red;
    border: 2px solid blue;
    width: 200px;
    margin: 3px;
    text-align: center;
  }
  </style>
  <script src="https://code.jquery.com/jquery-1.10.2.js"></script>
</head>
<body>
 
<button>First</button>
<button>Second</button>
<button>Third</button>
 
<script>
$( "button" ).click(function() {
  $( this ).replaceWith( "<div>vinay</div>" );
});
</script>
 
</body>
</html>