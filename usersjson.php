
<?php 
require_once('Connections/YBDB.php');
require_once('Connections/database_functions.php'); 

function generate_list2($querySQL,$list_value,$list_text, $form_name, $default_value)
{
	global $database_YBDB, $YBDB;
	mysql_select_db($database_YBDB, $YBDB);
	$recordset = mysql_query($querySQL, $YBDB) or die(mysql_error());
	$row_recordset = mysql_fetch_assoc($recordset);
	$totalRows_recordset = mysql_num_rows($recordset);
	$default_delimiter = '';
	
	echo "[\n";

	do 
	{ 
		echo '{';
		echo '  "value": "' . $row_recordset[$list_value] . '",';
		echo '  "name": "' . $row_recordset[$list_text] . '",';
		echo '  "combo": "' . $row_recordset[$list_text] . '                                                           ~' . $row_recordset[$list_value] . '"';
		echo '}, ';
	} 
		
	while ($row_recordset = mysql_fetch_assoc($recordset));
 		$rows = mysql_num_rows($recordset);

 	if($rows > 0) 
	{
      		mysql_data_seek($recordset, 0);
	  	$row_recordset = mysql_fetch_assoc($recordset);
	}

	mysql_free_result($recordset);
	
	echo '{';
	echo '  "value": " ",';
	echo '  "name": " "';
	echo '} ';

	echo "\n ]";
}

?>

<?php 

	$separt = array(", ", ",");
	$mainStr2 = str_replace($separt, " ", $_GET['hi']);

	$parts = explode(" ", $mainStr2);

	$part1 = $parts[0];
	$part2 = $parts[1];

	$querySQL = "";

	if ($part2 == "")
		$querySQL = "SELECT LEFT(TRIM(CONCAT(last_name, ', ', first_name, ' ',middle_initial)), 20) AS full_name, contact_id, hidden FROM contacts WHERE (first_name <> '' OR last_name <> '') AND (last_name like '%" . $_GET['hi'] . "%' OR first_name like '%" . $_GET['hi'] . "%') AND hidden <> 1 ORDER BY last_name, first_name, middle_initial";
	else	
		$querySQL = "SELECT LEFT(TRIM(CONCAT(last_name, ', ', first_name, ' ',middle_initial)), 20) AS full_name, contact_id, hidden FROM contacts WHERE (first_name <> '' OR last_name <> '') AND (last_name like '%" . $part1 . "%' OR first_name like '%" . $part1 . "%') AND (last_name like '%" . $part2 . "%' OR first_name like '%" . $part2 . "%') AND hidden <> 1 ORDER BY last_name, first_name, middle_initial";

	$list_value = "contact_id";
	$list_text = "full_name";
	generate_list2($querySQL,$list_value,$list_text,"none", "");
?>