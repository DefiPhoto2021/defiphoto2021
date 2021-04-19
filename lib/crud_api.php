<?php
 
    $servername = "127.0.0.1";
    $username = "root";
    $password = "";
    $dbname = "defiphoto";
    $tableUser = "utilisateur"; 
	$tableProg = "progression";
	$tableQuestion = "question";
 
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
        $sql = "SELECT id, id_prof, id_eleve, question, type, datetime from $tableQuestion ORDER BY datetime DESC";
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
        $nom = $_POST["nom"];
		$prenom = $_POST["prenom"];
		$password = $_POST["password"];
        $type = $_POST["type"];
		$id_prof = $_POST["id_prof"];
        $nom_stage = $_POST["nom_stage"];
        $sql = "INSERT INTO $tableUser (id, nom, prenom,type, password, id_prof, nom_stage) VALUES ('$id', '$nom', '$prenom','$type','$password', '$id_prof', '$nom_stage')";
        $result = $conn->query($sql);
		//Si l'utilisateur est un élève, on crée une rangé dans la progression
		if ($type == 'É'){
			$sql = "INSERT INTO $tableProg (id) VALUES ('$id')";
			$result = $conn->query($sql);
		}
        echo "success";
        $conn->close();
        return;
    }
	//On ajoute une question à la base de données
	if("ADD_QUESTION" == $action){
        // App will be posting these values to this server
		$id = (int)$_POST["id"];
        $id_prof = (int)$_POST["id_prof"];
        $id_eleve = $_POST["id_eleve"];
		$question = $_POST["question"];
        $type = $_POST["type"];
        $sql = "INSERT INTO $tableQuestion (id, id_prof, id_eleve, question,type, datetime) VALUES ('$id','$id_prof', '$id_eleve', '$question','$type', NOW())";
        $result = $conn->query($sql);
        echo "success";
        $conn->close();
        return;
    }
 
 
    // On supprime une utilisateur dans la basse de données
    if('DELETE_USER' == $action){
        $id = $_POST['id'];
        $sql = "DELETE FROM $table WHERE id = $id"; // don't need quotes since id is an integer.
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
 
?>