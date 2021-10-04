<?php
	include 'connected.php';
	header("Access-Control-Allow-Origin: *");

if (!$link) {
    echo "Error: Unable to connect to MySQL." . PHP_EOL;
    echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    
    exit;
}

if (!$link->set_charset("utf8")) {
    printf("Error loading character set utf8: %s\n", $link->error);
    exit();
	}

if (isset($_GET)) {
	if ($_GET['isAdd'] == 'true') {
				
		$name = $_GET['name'];
		$type = $_GET['type'];
		$address = $_GET['address'];
		$phone = $_GET['phone'];
		$username = $_GET['username'];
		$password = $_GET['password'];
		$img = $_GET['img'];
		$lat = $_GET['lat'];
		$lng = $_GET['lng'];
		
							
		$sql = "INSERT INTO `user`(`id`, `name`, `type`, `address`, `phone`, `username`, `password`, `img`, `lat`, `lng`) VALUES (Null,'$name','$type','$address','$phone','$username','$password','$img','$lat','$lng')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Welcome Suhai";
   
}
	mysqli_close($link);
?>