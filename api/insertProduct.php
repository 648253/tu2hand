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
				
		$idSeller = $_GET['idSeller'];
		$nameSeller = $_GET['nameSeller'];
		$namePd = $_GET['namePd'];
		$pricePd = $_GET['pricePd'];
		$detailPd = $_GET['detailPd'];
		$imagesPd = $_GET['imagesPd'];

						
		$sql = "INSERT INTO `product`(`id`, `idSeller`, `nameSeller`, `namePd`, `pricePd`, `detailPd`, `imagesPd`) VALUES (Null,'$idSeller','$nameSeller','$namePd','$pricePd','$detailPd','$imagesPd')";

		$result = mysqli_query($link, $sql);

		if ($result) {
			echo "true";
		} else {
			echo "false";
		}

	} else echo "Success";
   
}
	mysqli_close($link);
?>