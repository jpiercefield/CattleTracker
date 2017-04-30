<?php
	//header('Content-type: application/json');
	session_start();

	$type = $_POST['type'];
	if($type == '24'){
		getData(1);
	}else if($type == '7'){
		getData(7);
	}else if ($type == '30'){
		getData(30);
	}
	if($type == 'db_search'){
		search();
	}
	if($type=='cow_data') {
		cow_data();
	}
	if($type == 'cow_edit'){
		cow_edit();
	}
	if($type == 'bull_data'){
		bull_data();
	}
	if($type == 'bull_edit'){
		bull_edit();
	}
	if($type=='calf_data'){
		calf_data();
	}
	if($type=='calf_edit'){
		calf_edit();
	}
	if($type == 'vacc_search'){
		vacc_search();
	}
	if($type == 'cow_add'){
		cow_add();
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
		try{  //Need to prepare statement dependent upon what values have been entered.  Tag/animal/herd/pasture
				//can i make everything equal to % value %.  Then, if empty field, I pull all of that field
			$stmt = $db->prepare('SELECT vit.*, ani.* FROM vitals as vit INNER JOIN animal as ani on vit.vital_id = ani.animal_id WHERE ani.tag_id LIKE :tag AND ani.herd_id LIKE :herd AND ani.animal_id LIKE :animal AND ani.pasture_id LIKE :pasture AND ani.a_type LIKE :a_type');
			$tag = "%".$_POST['tag_id']."%";
			$animal = "%".$_POST['animal_id']."%";
			$herd = "%".$_POST['herd_num']."%";
			$pasture = "%".$_POST['pasture_num']."%";
			$a_type = "%".$_POST['animal_type']."%";
			$stmt->bindParam(':animal', $animal);
			$stmt->bindParam(':pasture', $pasture);
			$stmt->bindParam(':tag', $tag);
			$stmt->bindParam(':herd', $herd);
			$stmt->bindParam(':a_type', $a_type);
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

	function vacc_search(){
		$db=login();
		try{  //Need to prepare statement dependent upon what values have been entered.  Tag/animal/herd/pasture
				//can i make everything equal to % value %.  Then, if empty field, I pull all of that field
			$stmt = $db->prepare('SELECT count(*) as count, a_type from animal where herd_id = :herd_id group by a_type');
			$herd_id = "%".$_POST['herd_id']."%";
			$stmt->bindParam(':herd_id', $herd_id);
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
	function cow_add(){
		$db=login();
		$return = array('message' =>'Cow Saved!');
		$new_animal_id = $_POST['new_animal_id'];
		$due_date = date('Y-m-d', strtotime($_POST['due_date']));
		$tag_id = $_POST['tag_id'];
		$pregnant = $_POST['pregnant'];
		$DOB = date('Y-m-d', strtotime($_POST['DOB']));
		$med_cond = $_POST['med_cond'];
		$pasture = $_POST['pasture'];
		$herd = $_POST['herd'];
		$weight = $_POST['weight'];
		$rfid = $_POST['rfid'];

		$q1 = 'insert into animal(animal_id, tag_id, herd_id, pasture_id, rfid) values (:animal_id, :tag_id, :herd_id, :pasture_id, :rfid)';
		$q2 = 'insert into cow(cow_id, pregnant, due_date) values (:animal_id, :pregnant, :due_date)';
		$q3 = 'insert into vitals(vital_id, weight, DOB, medical_cond) values (:animal_id, :weight, :DOB, :medical_cond)';

	try{
		$stmt1 = $db->prepare($q1);
		$stmt1->execute(array(":animal_id"=>$new_animal_id,":tag_id"=>$tag_id, ":herd_id"=>$herd, ":pasture_id"=>$pasture, ":rfid"=>$rfid));

		$stmt2 = $db->prepare($q2);
		$stmt2->execute(array(":animal_id"=> $new_animal_id, ":pregnant"=>$pregnant, ":due_date"=>$due_date));

		$stmt3 = $db->prepare($q3);
		$stmt3->execute(array(":animal_id"=>$new_animal_id, ":weight"=>$weight, ":DOB"=>$DOB, ":medical_cond"=>$med_cond));



		print json_encode($return);
	}catch(PDOException $e){
		$return = array('message' => $e->getMessage());
		print json_encode($return);
		}				


	}
	function cow_data(){
		$db=login();
		try {
			$stmt = $db->prepare('SELECT cow.cow_id, animal.tag_id, vitals.weight, animal.herd_id, animal.rfid, animal.pasture_id, cow.due_date, vitals.DOB, vitals.medical_cond, cow.pregnant FROM cow JOIN animal ON cow.cow_id = animal.animal_id JOIN vitals ON vitals.vital_id = animal.animal_id WHERE animal.animal_id = :tag');
			$tag = $_POST['tag_id'];
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
	function bull_data(){
		$db=login();
		try {
			$stmt = $db->prepare('SELECT bull.bull_id, animal.tag_id, vitals.weight, animal.rfid, animal.herd_id, animal.pasture_id,  vitals.DOB, vitals.medical_cond, bull.castrated, bull.num_sired, bull.bull_index FROM bull JOIN animal ON bull.bull_id = animal.animal_id JOIN vitals ON vitals.vital_id = animal.animal_id WHERE animal.animal_id = :tag');
			$tag = $_POST['tag_id'];
			$stmt->bindParam(':tag', $tag);
			$stmt->execute();
			$rows = array();
			while($row = $stmt->fetch(PDO::FETCH_ASSOC)){
				$rows[] = $row;
			}
			print json_encode($rows);	
		}catch(PDOException $e){
			$arr = array('message' => $e->getMessage());
			print json_encode($arr);
			}	
	}
	function calf_data(){
		$db=login();
		try {
			$stmt = $db->prepare('SELECT calf.calf_id, animal.rfid, animal.tag_id, vitals.weight, animal.herd_id, animal.pasture_id,  vitals.DOB, vitals.medical_cond, calf.birth_weight, calf.body_index, calf.sex, calf.wean_weight, calf.wean_index FROM calf JOIN animal ON calf.calf_id = animal.animal_id JOIN vitals ON vitals.vital_id = animal.animal_id WHERE animal.animal_id = :tag');
			$tag = $_POST['tag_id'];
			$stmt->bindParam(':tag', $tag);
			$stmt->execute();
			$rows = array();
			while($row = $stmt->fetch(PDO::FETCH_ASSOC)){
				$rows[] = $row;
			}
			print json_encode($rows);	
		}catch(PDOException $e){
			$arr = array('message' => $e->getMessage());
			print json_encode($arr);
			}	
	}
	function cow_edit(){
		$db=login();
		
		
		$return = array('message' =>'Changes Saved!');
		$old_animal_id = $_POST['old_animal_id'];
		$new_animal_id = $_POST['new_animal_id'];
		$due_date = date('Y-m-d', strtotime($_POST['due_date']));
		$tag_id = $_POST['tag_id'];
		$pregnant = $_POST['pregnant'];
		$DOB = date('Y-m-d', strtotime($_POST['DOB']));
		$med_cond = $_POST['med_cond'];
		$pasture = $_POST['pasture'];
		$herd = $_POST['herd'];
		$weight = $_POST['weight'];
		$rfid = $_POST['rfid'];

		$q1 = 'update vitals set weight = :wei, DOB = :db, medical_cond = :med_con where vital_id = :animal_id';
		$q2 = 'update cow set due_date = :due_date, pregnant = :pregnant where cow_id = :animal_id';
		$q3 = 'update animal set tag_id = :tag_id, herd_id = :herd, pasture_id = :pasture, rfid = :rfid where animal_id = :animal_id';
		$q4 = 'update animal set animal_id = :new_animal_id where animal_id = :old_animal_id';

	try{
		$stmt = $db->prepare($q1);
		$stmt->execute(array(":wei" => $weight, ":db" => $DOB, ":med_con" => $med_cond, ":animal_id" => $old_animal_id));
		$stmt2 = $db->prepare($q2);
		$stmt2->execute(array(":due_date" => $due_date, ":pregnant" => $pregnant, ":animal_id" => $old_animal_id));
		$stmt3 = $db->prepare($q3);
		$stmt3->execute(array(":tag_id" => $tag_id, ":herd"=>$herd, ":pasture"=> $pasture, ":rfid"=>$rfid,":animal_id" => $old_animal_id));

		$stmt4 = $db->prepare($q4);
		$stmt4->execute(array(":new_animal_id" => $new_animal_id, ":old_animal_id" => $old_animal_id));


		print json_encode($return);
	}catch(PDOException $e){
		$return = array('message' => $e->getMessage());
		print json_encode($return);
		}				

	}

	function bull_edit(){
		$db = login();
		$return = array('message' =>'Changes Saved!');
		$old_animal_id =$_POST['old_animal_id'];
		$new_animal_id =$_POST['new_animal_id'];
		$tag_id = 		$_POST['tag_id'];
		$DOB = 			date('Y-m-d', strtotime($_POST['DOB']));
		$med_cond = 	$_POST['med_cond'];
		$pasture = 		$_POST['pasture'];
		$herd = 		$_POST['herd'];
		$weight = 		$_POST['weight'];
		$castrated = 	$_POST['castrated'];
		$index = 		$_POST['index'];
		$numSired = 	$_POST['numSired'];
		$rfid =			$_POST['rfid'];

		$q1 = 'update vitals set weight = :wei, DOB = :db, medical_cond = :med_con where vital_id = :animal_id';

		$q2 = 'update bull set castrated = :castrated, num_sired = :numSired, bull_index = :index where bull_id = :animal_id';

		$q3 = 'update animal set tag_id = :tag_id, herd_id = :herd, pasture_id = :pasture, rfid = :rfid where animal_id = :animal_id';

		$q4 = 'update animal set animal_id = :new_animal_id where animal_id = :old_animal_id';

	try{
		$stmt = $db->prepare($q1);
		$stmt->execute(array(":wei" => $weight, ":db" => $DOB, ":med_con" => $med_cond, ":animal_id" => $old_animal_id));

		$stmt2 = $db->prepare($q2);
		$stmt2->execute(array(":castrated" => $castrated, ":numSired" => $numSired, ":index"=>$index, ":animal_id"=>$old_animal_id));

		$stmt3 = $db->prepare($q3);
		$stmt3->execute(array(":tag_id" => $tag_id, ":herd"=>$herd, ":pasture"=> $pasture, ":rfid" => $rfid, ":animal_id" => $old_animal_id));

		$stmt4 = $db->prepare($q4);
		$stmt4->execute(array(":new_animal_id" => $new_animal_id, ":old_animal_id" => $old_animal_id));


		print json_encode($return);
	}catch(PDOException $e){
		$return = array('message' => $e->getMessage());
		print json_encode($return);
		}				

	}

function calf_edit(){
		$db = login();
		$return = array('message' =>'Changes Saved!');
		$old_animal_id =$_POST['old_animal_id'];
		$new_animal_id =$_POST['new_animal_id'];
		$tag_id = 		$_POST['tag_id'];
		$DOB = 			date('Y-m-d', strtotime($_POST['DOB']));
		$med_cond = 	$_POST['med_cond'];
		$pasture = 		$_POST['pasture'];
		$herd = 		$_POST['herd'];
		$weight = 		$_POST['weight'];
		$body_index =	$_POST['bodyIndex'];
		$birth_weight = $_POST['birthWeight'];
		$sex	=		$_POST['sex'];
		$wean_weight =	$_POST['weanWeight'];
		$wean_index =	$_POST['weanIndex'];
		$rfid	=		$_POST['rfid'];

		$q1 = 'update vitals set weight = :wei, DOB = :db, medical_cond = :med_con where vital_id = :animal_id';

		$q2 = 'UPDATE calf set sex = :sex, birth_weight = :birth_weight, body_index = :body_index, wean_weight = :wean_weight, wean_index = :wean_index where calf_id = :animal_id';

		$q3 = 'update animal set tag_id = :tag_id, herd_id = :herd, pasture_id = :pasture, rfid = :rfid where animal_id = :animal_id';

		$q4 = 'update animal set animal_id = :new_animal_id where animal_id = :old_animal_id';

	try{
		$stmt = $db->prepare($q1);
		$stmt->execute(array(":wei" => $weight, ":db" => $DOB, ":med_con" => $med_cond, ":animal_id" => $old_animal_id));

		$stmt2 = $db->prepare($q2);
		$stmt2->execute(array(":sex"=>$sex, ":birth_weight"=>$birth_weight, ":body_index"=>$body_index, ":wean_weight"=>$wean_weight, ":wean_index"=>$wean_index, ":animal_id"=>$old_animal_id));

		$stmt3 = $db->prepare($q3);
		$stmt3->execute(array(":tag_id" => $tag_id, ":herd"=>$herd, ":pasture"=> $pasture, ":rfid"=>$rfid, ":animal_id" => $old_animal_id));

		$stmt4 = $db->prepare($q4);
		$stmt4->execute(array(":new_animal_id" => $new_animal_id, ":old_animal_id" => $old_animal_id));


		print json_encode($return);
	}catch(PDOException $e){
		$return = array('message' => $e->getMessage());
		print json_encode($return);
		}				

	}	

?>

	
  