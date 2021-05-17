<?php
 
    $servername = "127.0.0.1";
    $username = "root";
    $password = "";
    $dbname = "defiphoto";
    $tableUser = "utilisateur"; 
	$tableProg = "progression";
	$tableQuestion = "question";
	$tableReponse = "reponse";
 
	//Quand le script est appellé, on reçoit un map qui contient une valeur attaché à la clef 'action'. Avec cette valeur, on choisi quel fonction executer
    $action = $_POST["action"]; 
     
    // On crée et test la connection à la base de données
    $conn = new mysqli($servername, $username, $password, $dbname);
    if($conn->connect_error){
        die("Connection Failed: " . $conn->connect_error);
        return;
    }
 
    // On reçoit une liste de tout les utilisateurs
    if("GET_ALL" == $action){
        $db_data = array();
        $sql = "SELECT id, nom, prenom, type, password, id_prof, nom_stage from $tableUser ORDER BY id DESC";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }
            // Send back the complete records as a json
            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }
	//On reçoit une liste de toute la progression de chaque élève
	if("GET_ALL_PROG" == $action){
        $db_data = array();
        $sql = "SELECT id, metier, metier_rep, equipement, equipement_rep, tache, tache_rep, individu, individu_rep, environnement, environnement_rep, ressource, ressource_rep from $tableProg ORDER BY id DESC";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }
            // Send back the complete records as a json
            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }
	//On reçoit une liste de toutes les questions
	if("GET_ALL_QUESTION" == $action){
        $db_data = array();
        $sql = "SELECT id, id_question, id_prof, id_eleve, question, type, datetime, reponse_id from $tableQuestion ORDER BY datetime DESC";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }
            // Send back the complete records as a json
            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }
	if("GET_ALL_REPONSE" == $action){
        $db_data = array();
        $sql = "SELECT id, reponse, image_name, id_eleve from $tableReponse ORDER BY id DESC";
        $result = $conn->query($sql);
        if($result->num_rows > 0){
            while($row = $result->fetch_assoc()){
                $db_data[] = $row;
            }
            // Send back the complete records as a json
            echo json_encode($db_data);
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }
 
    // On ajoute un untilisateur à la base de données.
    if("ADD_USER" == $action){
        // App will be posting these values to this server
        $id = (int)$_POST["id"];
        $nom = $conn -> real_escape_string($_POST["nom"]);
		$prenom = $conn -> real_escape_string($_POST["prenom"]);
		$password = $_POST["password"];
        $type = $_POST["type"];
		$id_prof = $_POST["id_prof"];
        $nom_stage = $conn -> real_escape_string($_POST["nom_stage"]);
        $sql = "INSERT INTO $tableUser (id, nom, prenom,type, password, id_prof, nom_stage) VALUES ('$id', '$nom', '$prenom','$type','$password', '$id_prof', '$nom_stage')";
        $result = $conn->query($sql);
		//Si l'utilisateur est un élève, on crée un rang dans la progression
		if ($type == 'É'){
			$sql = "INSERT INTO $tableProg (id) VALUES ('$id')";
			$result = $conn->query($sql);
		}
        echo "success";
        $conn->close();
        return;
    }
	//On ajoute une question à la base de données
	if("ADD_REPONSE" == $action){
		$id = (int)$_POST["id"];
        $reponse = $conn -> real_escape_string($_POST["reponse"]);
		$image_name = $_POST["image_name"];
        $id_eleve = (int)$_POST["id_eleve"];
		$type = $_POST["type"];
        $sql = "INSERT INTO $tableReponse (id, reponse, image_name, id_eleve) VALUES ('$id','$reponse', '$image_name', '$id_eleve')";
        $result = $conn->query($sql);
		switch($type) {
			case 'M': $sql = "UPDATE $tableProg SET metier_rep=(metier_rep + 1) WHERE id=$id_eleve";
			break;
			case 'É': $sql = "UPDATE $tableProg SET equipement_rep=(equipement_rep + 1) WHERE id=$id_eleve";
			break;
			case 'T': $sql = "UPDATE $tableProg SET tache_rep=(tache_rep + 1) WHERE id=$id_eleve";
			break;
			case 'I': $sql = "UPDATE $tableProg SET individu_rep=(individu_rep + 1) WHERE id=$id_eleve";
			break;
			case 'E': $sql = "UPDATE $tableProg SET environnement_rep=(environnement_rep + 1) WHERE id=$id_eleve";
			break;
			case 'R': $sql = "UPDATE $tableProg SET ressource_rep=(ressource_rep + 1) WHERE id=$id_eleve";
			break;
		}
		$result = $conn->query($sql);
        $conn->close();
        return;
    }
	if("ADD_QUESTION" == $action){
        // App will be posting these values to this server
		$id_question = (int)$_POST["id_question"];
		$id_prof = (int)$_POST["id_prof"];
        $id_eleve = (int)$_POST["id_eleve"];
		$question = $conn -> real_escape_string($_POST["question"]);
        $type = $_POST["type"];
        $sql = "INSERT INTO $tableQuestion (id_question, id_prof, id_eleve, question, type, datetime) VALUES ('$id_question', '$id_prof', '$id_eleve', '$question','$type', NOW())";
        $result = $conn->query($sql);	
		switch($type) {
			case 'M': $sql = "UPDATE $tableProg SET metier=(metier + 1) WHERE id=$id_eleve";
			break;
			case 'É': $sql = "UPDATE $tableProg SET equipement=(equipement + 1) WHERE id=$id_eleve";
			break;
			case 'T': $sql = "UPDATE $tableProg SET tache=(tache + 1) WHERE id=$id_eleve";
			break;
			case 'I': $sql = "UPDATE $tableProg SET individu=(individu + 1) WHERE id=$id_eleve";
			break;
			case 'E': $sql = "UPDATE $tableProg SET environnement=(environnement + 1) WHERE id=$id_eleve";
			break;
			case 'R': $sql = "UPDATE $tableProg SET ressource=(ressource + 1) WHERE id=$id_eleve";
			break;
		}
		$result = $conn->query($sql);
        $conn->close();
        return;
    }
	if("UPDATE_QUESTION" == $action){
        $reponse_id = (int)$_POST["reponse_id"];
		$id = (int)$_POST["id"];
        $sql = "UPDATE $tableQuestion SET reponse_id='$reponse_id' WHERE id=$id";
        $result = $conn->query($sql);
        $conn->close();
        return;
    }
	if("UPDATE_QUESTION_TEXT" == $action){
        $question = $_POST["question"];
		$id = (int)$_POST["id"];
        $sql = "UPDATE $tableQuestion SET question='$question' WHERE id=$id";
        $result = $conn->query($sql);
        $conn->close();
        return;
    }
	
    // On supprime une utilisateur dans la basse de données
    if('DELETE_USER' == $action){
        $id = $_POST['id'];
        $sql = "DELETE FROM $tableUser WHERE id = $id"; // don't need quotes since id is an integer.
        if($conn->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }
		$sql = "DELETE FROM $tableProg WHERE id = $id"; // don't need quotes since id is an integer.
		$result = $conn->query($sql);
        $conn->close();
        return;
    }
	if('DELETE_QUESTION' == $action){
        $id = $_POST['id'];
		$id_eleve = $_POST['id_eleve'];
		$type = $_POST['type'];
		$reponse_id = $_POST['reponse_id'];
		$rep = $_POST['rep'];
        $sql = "DELETE FROM $tableQuestion WHERE id = $id"; // don't need quotes since id is an integer.
        if($conn->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }
		switch($type) {
			case 'M': $sql = "UPDATE $tableProg SET metier=(metier - 1) WHERE id=$id_eleve";
			break;
			case 'É': $sql = "UPDATE $tableProg SET equipement=(equipement - 1) WHERE id=$id_eleve";
			break;
			case 'T': $sql = "UPDATE $tableProg SET tache=(tache - 1) WHERE id=$id_eleve";
			break;
			case 'I': $sql = "UPDATE $tableProg SET individu=(individu - 1) WHERE id=$id_eleve";
			break;
			case 'E': $sql = "UPDATE $tableProg SET environnement=(environnement - 1) WHERE id=$id_eleve";
			break;
			case 'R': $sql = "UPDATE $tableProg SET ressource=(ressource - 1) WHERE id=$id_eleve";
			break;
		}// don't need quotes since id is an integer.
		$result = $conn->query($sql);
		if ($rep === "true"){
			switch($type) {
			case 'M': $sql = "UPDATE $tableProg SET metier_rep=(metier_rep - 1) WHERE id=$id_eleve";
			break;
			case 'É': $sql = "UPDATE $tableProg SET equipement_rep=(equipement_rep - 1) WHERE id=$id_eleve";
			break;
			case 'T': $sql = "UPDATE $tableProg SET tache_rep=(tache_rep_rep - 1) WHERE id=$id_eleve";
			break;
			case 'I': $sql = "UPDATE $tableProg SET individu_rep=(individu_rep - 1) WHERE id=$id_eleve";
			break;
			case 'E': $sql = "UPDATE $tableProg SET environnement_rep=(environnement_rep - 1) WHERE id=$id_eleve";
			break;
			case 'R': $sql = "UPDATE $tableProg SET ressource_rep=(ressource_rep - 1) WHERE id=$id_eleve";
			break;
		}$result = $conn->query($sql);
		}
		$sql = "DELETE FROM $tableReponse WHERE id = $reponse_id";
		$result = $conn->query($sql);
        $conn->close();
        return;
    }
 
?>