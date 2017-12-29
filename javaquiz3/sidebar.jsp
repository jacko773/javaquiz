<html !DOCTYPE>
<head>
    <title>Bootstrap 3 Collapsible Sidebar</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="style.css">
</head>
<body>
<div class="wrapper">
	<div class="fluid-container">
		<div class="row">
		<div class="col-md-2">
				<nav id="sidebar">
					<div class="sidebar-header">
						<h3>Core java</h3>
					</div>

					<ul class="list-unstyled components">
						<li>
							<a href="#home" data-toggle="collapse" aria-expanded="false">Home</a>
							<ul class="collapse list-unstyled" id="home">
								<li><a href="#">Page</a></li>
								<li><a href="#">Page</a></li>
								<li><a href="#">Page</a></li>
							</ul>
						</li>
						<li><a href="#">About</a></li>
						<li> 
							<a href="#homeSubmenu" data-toggle="collapse" aria-expanded="false">Pages</a>
							<ul class="collapse list-unstyled" id="homeSubmenu">
								<li><a href="#">Page</a></li>
								<li><a href="#">Page</a></li>
								<li><a href="#">Page</a></li>
							</ul>
						</li>
						<li><a href="#">Portfolio</a></li>
						<li><a href="#">Contact</a></li>
					</ul>
				</nav>
		</div>
			<div class="col-md-10">
				<div id="content">
				</div>
			</div>
		</div>
	</div>
</div>

    <script src="https://code.jquery.com/jquery-1.12.0.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script>
		$(document).ready(function () {

    $('#sidebarCollapse').on('click', function () {
        $('#sidebar').toggleClass('active');
    });

});
	</script>
</body>
</html>