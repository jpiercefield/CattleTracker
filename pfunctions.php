<?php
	session_start();

	$type = $_POST['type'];
	if($type == '24'){
		getData(1);
	}else if($type == '7'){
		getData(7);
	}
	//print($type);
	//foo();
	//get24();

	function login(){
		$host="localhost";
		$username = "root";
		$password = "CattleTrax11!";
		$db_name = "cattletrax";

		try{
			$db = new PDO("mysql:host=$host;dbname=$db_name", $username, $password);
			$db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
			return $db;
		}catch(PDOException $e){
			print($e->getMessage());
		}
	}
	function getData($value){
		$db = login();

		try{
			$stmt = $db->prepare('SELECT * FROM feeder where DATEDIFF(NOW(), last_visit_date) between 0 and :value');
			$stmt->bindParam(':value', $value, PDO::PARAM_INT);
			$stmt->execute();
			//$header = $stmt->fetch(PDO::FETCH_ASSOC);
/*			Don't believe I need this if we're parsing in jquery
			foreach ($header as $field => $value){
				echo json_encode($field);
			}*/
			//$stmt = $db->query('SELECT * FROM feeder where DATEDIFF(NOW(), last_visit_date) between 0 and 30');
			$rows = array();
			while($row = $stmt->fetch(PDO::FETCH_ASSOC)){
				$rows[] = $row;
				//echo json_encode(echo $row['ref_id'] ." ". $row['num_visits'] . $row['last_visit_date']."\n");
				
			}
			print json_encode($rows);
		}catch(PDOException $e){
			$arr = array('error' => $e->getMessage());
			//print json_encode($arr);
		}
		
	}
	function foo(){
		print("shitbags");
	}
?>

