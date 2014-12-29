<?
require_once('classes/ybdbtable.php');

class LocationIP extends Location
{
	var $id = null;
	var $shop_location_id = null;
	var $hostname = null;
	var $active = null;
	var $created = null;
	var $created_by = null;
	var $created_by_ip = null;
	var $created_by_alias = null;
	var $modified = null;
	var $modified_by = null;
	var $modified_by_ip = null;
	
	function __construct() {
		$this->created_by = '0';
		$this->modified_by = '0';
	}
	
	function load($id) {
		global $database_YBDB, $YBDB, $prefix_YBDB;

		if ($id!=null) {
			$recordQuery = "SELECT *, INET_NTOA(created_by_ip) as created_by_ip, INET_NTOA(modified_by_ip) as modified_by_ip FROM ".$prefix_YBDB."shop_location_ip WHERE id='".$id."' ORDER BY created DESC";
			mysql_select_db($database_YBDB, $YBDB);
			$results = mysql_query($recordQuery, $YBDB) or die(mysql_error());		
			$row = mysql_fetch_assoc($results) or die(mysql_error());

			$this->id = $row[id];	
			$this->shop_location_id = $row[shop_location_id];
			$this->hostname = $row[hostname];
			$this->active = $row[active];
			$this->created = $row[created];
			$this->created_by = $row[created_by];
			$this->created_by_ip = $row[created_by_ip];
			$this->created_by_alias = $row[created_by_alias];
			$this->modified = $row[modified];
			$this->modified_by = $row[modified_by];
			$this->modified_by_ip = $row[modified_by_ip];
 
			//print_r($this);
			
			//parent::load($this->shop_location_id);
		}
	}		

	function loadCurrent() {
		global $database_YBDB, $YBDB, $prefix_YBDB;

		$retval = true;

		$IP = current_ip_address(true);
		
		$recordQuery = "SELECT id FROM ".$prefix_YBDB."shop_location_ip as shop_location_ip WHERE shop_location_ip.created_by_ip = '$IP' AND active='1' ORDER BY created DESC;";
		mysql_select_db($database_YBDB, $YBDB);
		$results = mysql_query($recordQuery, $YBDB) or die(mysql_error()." loadCurrent(): $recordQuery");		
	
		if (mysql_num_rows($results)<1) {
			$retval = false;
		} else {
			$row = mysql_fetch_assoc($results) or die(mysql_error()." loadCurrent(): mysql_fetch_assoc(results)");
			$this->load($row[id]);
		}

		return $retval;
	}

	function loadCurrentHostname() {
		global $database_YBDB, $YBDB, $prefix_YBDB;

		$retval = false;

		$recordQuery = "SELECT shop_location_id, hostname FROM ".$prefix_YBDB."shop_locations as shop_locations WHERE active='1'";
                mysql_select_db($database_YBDB, $YBDB);
                $results = mysql_query($recordQuery, $YBDB) or die(mysql_error()." loadCurrent(): $recordQuery");

		while ($row = mysql_fetch_assoc($results)) {
			if (gethostbyname($row[hostname])==current_ip_address(false)) {
				$retval = true;
				$this->shop_location_id = $row[shop_location_id];
				$this->hostname = $row[hostname];

				$updateQuery = "UPDATE ".$prefix_YBDB."shop_location_ip SET active='0' WHERE hostname='".$this->hostname."'";
				mysql_query($updateQuery, $YBDB) or die(mysql_error().$updateQuery);
				
				$this->active = 1;
				$this->save();
			}		
		} 

		return $retval;
	}

	function exists($id) {
		global $database_YBDB, $YBDB, $prefix_YBDB;
		
		$exists = false;
		
		$existsQuery = "SELECT id FROM ".$prefix_YBDB."shop_location_ip WHERE id='".$id."'";			   
		mysql_select_db($database_YBDB, $YBDB);
		$row = mysql_query($existsQuery, $YBDB) or die(mysql_error());		

		if (mysql_num_rows($row)!=0) {
			$exists = true;
		}
		
		return $exists;
	}

	function save() {
		global $database_YBDB, $YBDB, $prefix_YBDB;
		
		$success = true;
				
		$insertQuery = sprintf("INSERT INTO ".$prefix_YBDB."shop_location_ip (shop_location_id, hostname, active, created, created_by, created_by_ip, created_by_alias) VALUES (%s,%s,%s,%s,%s,%s,%s)",
					   GetSQLValueString($this->shop_location_id, "text"),
					   GetSQLValueString($this->hostname, "text"),
					   GetSQLValueString($this->active, "int"),
					   GetSQLValueString(current_datetime(), "date"),
					   GetSQLValueString($this->created_by, "int"),
					   GetSQLValueString(current_ip_address(true), "int"),
					   GetSQLValueString($this->created_by_alias, "text"));
					   //GetSQLValueString(current_datetime(), "text"),
					   //GetSQLValueString($this->modified_by, "text"),
					   //GetSQLValueString(current_ip_address(true), "text"));
					   
		$updateQuery = sprintf("UPDATE ".$prefix_YBDB."shop_location_ip SET shop_location_id=%s, hostname=%s, active=%s, modified=%s, modified_by=%s, modified_by_ip=%s WHERE id=%s",	
					   GetSQLValueString($this->shop_location_id, "text"),
					   GetSQLValueString($this->hostname, "text"),
					   GetSQLValueString($this->active, "int"),
					   //GetSQLValueString(current_datetime(), "date"),
					   //GetSQLValueString($this->created_by, "int"),
					   //GetSQLValueString(current_ip_address(true), "int"),
					   //GetSQLValueString($this->created_by_alias, "text"));
					   GetSQLValueString(current_datetime(), "text"),
					   GetSQLValueString($this->modified_by, "int"),
					   GetSQLValueString(current_ip_address(true), "text"),
					   GetSQLValueString($this->id, "int"));
		
		// Does a record exist?			   
		if (!$this->exists($this->id)) {
			mysql_query($insertQuery, $YBDB) or die(mysql_error().$query);
			$this->id = mysql_insert_id();			
		} else {
			//TODO: Before we blow away the old values, conflict resolution is required.
			mysql_query($updateQuery, $YBDB) or die(mysql_error().$query);
		}

		return $success;
	}
}

?>
