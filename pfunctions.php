<?php
	session_start();

	$type = $_POST['type'];
	if($type == '24'){
		getData(1);
	}else if($type == '7'){
		getData(7);
	}else if ($type == '30'){
		getData(30);
	}else if($type == 'db_search'){
		search();
	}


	function login(){
		//$host="149.149.150.136";
		//$username = "pjtinker";
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
			$rows = array();
			while($row = $stmt->fetch(PDO::FETCH_ASSOC)){
				$rows[] = $row;			
			}
			print json_encode($rows);
		}catch(PDOException $e){
			$arr = array('error' => $e->getMessage());
			print json_encode($arr);

		}
		
	}
	function search(){
		$db = login();
		try{
			$stmt = $db->prepare('SELECT vit.* FROM vitals as vit INNER JOIN animal as ani on vit.animal_id = ani.animal_id WHERE ani.tag_id LIKE :tag');
			if($_POST['tag_id'] > 0){
				$tag = "%".$_POST['tag_id']."%";
			}else{
				$tag = "%".$_POST['animal_id']."%";
			}
			$stmt->bindParam(':tag', $tag);
			$stmt->execute();
			$rows = array();
			while($row = $stmt->fetch(PDO::FETCH_ASSOC)){
				$rows[] = $row;
			}
			print json_encode($rows);
		}catch(PDOException $e){
			$arr = array('error' => $e->getMessage());
			print json_encode($arr);
		}

	}

?>

