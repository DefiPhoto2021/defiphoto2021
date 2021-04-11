var mysql = require('mysql');

var con = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  database: "defiphoto"
});


/* <?php
 
    $servername = "127.0.0.1";
    $username = "root";
    $password = "";
    $dbname = "defiphoto";
    $table = "utilisateur"; // lets create a table named Employees.
	$tableProg = "progression";
 
    // we will get actions from the app to do operations in the database...
    $action = $_POST["action"]; 
     
    // Create Connection
    $conn = new mysqli($servername, $username, $password, $dbname);
    // Check Connection
    if($conn->connect_error){
        die("Connection Failed: " . $conn->connect_error);
        return;
    }
 
    // Get all employee records from the database
    if("GET_ALL" == $action){
        $db_data = array();
        $sql = "SELECT id, nom, prenom, type, password, id_prof, nom_stage from $table ORDER BY id DESC";
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
	if("GET_ALL_PROG" == $action){
        $db_data = array();
        $sql = "SELECT id, metier, metier_rep, equipement, equipement_rep, tache, tache_rep, individu, individu_rep, envrionnement, envrionnement_rep, ressource, ressource_rep from $tableProg ORDER BY id DESC";
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
 
    // Add an Employee
    if("ADD_USER" == $action){
        // App will be posting these values to this server
        $id = (int)$_POST["id"];
        $nom = $_POST["nom"];
		$prenom = $_POST["prenom"];
		$password = $_POST["password"];
        $type = $_POST["type"];
		$id_prof = $_POST["id_prof"];
        $nom_stage = $_POST["nom_stage"];
        $sql = "INSERT INTO $table (id, nom, prenom,type, password, id_prof, nom_stage) VALUES ('$id', '$nom', '$prenom','$type','$password', '$id_prof', '$nom_stage')";
        $result = $conn->query($sql);
		if ($type == 'É'){
			$sql = "INSERT INTO $tableProg (id) VALUES ('$id')";
			$result = $conn->query($sql);
		}
        echo "success";
        $conn->close();
        return;
    }
 
    // Remember - this is the server file.
    // I am updating the server file.
    // Update an Employee
    if("UPDATE_EMP" == $action){
        // App will be posting these values to this server
        $emp_id = $_POST['emp_id'];
        $username = $_POST["username"];
        $password = $_POST["password"];
        $sql = "UPDATE $table SET username = '$username', password = '$password' WHERE id = $emp_id";
        if($conn->query($sql) === TRUE){
            echo "success";
        }else{
            echo "error";
        }
        $conn->close();
        return;
    }
 
    // Delete an Employee
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
 
?> */