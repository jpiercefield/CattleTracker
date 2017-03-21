<html>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/prefixfree/1.0.7/prefixfree.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>

<head>
<title>PHP TEST </title>

	<script>
		$(document).ready(function(){
			$("#load_button").click(function(e){
				e.preventDefault();
				$.ajax({
					type:"POST",
					url:"pfunctions.php",
					dataType:"text",
					cache:false,
					data:{
						type:"feeder",
					},
					success: function(text){
						$("#land").html(text)
						//alert("successful")
					},
					error: function(text){
						$("#land").html(text);
					},
				})
			})
		})	
	</script>
</head>
<body>
<div class = "Query">
<button type = "submit" id="load_button">Load</button>
</div>
<div class = "Landing" id="land"</div>
</body>
</html>
