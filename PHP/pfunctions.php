<?php
	session_start();

	$type = $_POST['type'];
	print($type)



	function login(){
		$host="localhost";
		$username = "root";
		$password = "LBell767";
		$db_name = "cattletrax";

		try{
			$db = new PDO("mysql:host=$host;dbname=$db_name", $username, $password);
			$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
			return $db;
		}catch(PDOException $e){
			print($e->getMessage());
		}
	}
?>