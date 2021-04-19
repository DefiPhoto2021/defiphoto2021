<?php 
//mon but c'est de faire une fonction qui permet d'associer les tables pour les choses qu'ils ont en commun 
//- associer le ID à toutes les bases de données:
//- eleves à prof
//- progression à l'individu
//- questions au prof et à l'élève

//le plus simple : associer le prof à l'élève
if (JOIN_ID == $action){
/*      $db_data = array();
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
        return; */


/*     // write query for all pizzas
	$sql = 'SELECT title, ingredients, id FROM pizzas ORDER BY created_at';

	// get the result set (set of rows)
	$result = mysqli_query($conn, $sql);

	// fetch the resulting rows as an array
	$pizzas = mysqli_fetch_all($result, MYSQLI_ASSOC);

	// free the $result from memory (good practise)
	mysqli_free_result($result);

	// close connection
	mysqli_close($conn); */

    $sql = "SELECT id_prof
    FROM utilisateur"

    //ici, on garde $conn pour connection, on remplace $pizza par $db_data[], on garde $result
}



?>