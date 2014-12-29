<?
require_once('classes/ybdbtable.php');

class Location extends YBDBTable
{
	var $shop_location_id = null;
	var $date_established = null;
	var $active = null;
	var $hostname = null;
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
	
	function load($shop_location_id) {
		global $database_YBDB, $YBDB, $prefix_YBDB;

		if ($shop_location_id!=null) {
			$recordQuery = "SELECT *, INET_NTOA(created_by_ip) as created_by_ip, INET_NTOA(modified_by_ip) as modified_by_ip FROM ".$prefix_YBDB."shop_locations WHERE shop_location_id='".$shop_location_id."' ORDER BY created DESC";
			mysql_select_db($database_YBDB, $YBDB);
			$results = mysql_query($recordQuery, $YBDB) or die(mysql_error());		
			$row = mysql_fetch_assoc($results) or die(mysql_error());
			
			$this->shop_location_id = $row[shop_location_id];
			$this->date_established = $row[date_established];
			$this->active = $row[active];
			$this->hostname = $row[hostname];
			$this->created = $row[created];
			$this->created_by = $row[created_by];
			$this->created_by_ip = $row[created_by_ip];
			$this->created_by_alias = $row[created_by_alias];
			$this->modified = $row[modified];
			$this->modified_by = $row[modified_by];
			$this->modified_by_ip = $row[modified_by_ip];
 
			//print_r($this);
		}
	}

	function exists($shop_location_id) {
		global $database_YBDB, $YBDB, $prefix_YBDB;
		
		$exists = false;
		
		$existsQuery = "SELECT shop_location_id FROM ".$prefix_YBDB."shop_locations WHERE shop_location_id='".$shop_location_id."'";			   
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
				
		$insertQuery = sprintf("INSERT INTO ".$prefix_YBDB."shop_locations (shop_location_id, date_established, active, hostname, created, created_by, created_by_ip, created_by_alias) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)",
					   GetSQLValueString($this->shop_location_id, "text"),
					   GetSQLValueString($this->date_established, "date"),
					   GetSQLValueString($this->active, "int"),
					   GetSQLValueString($this->hostname, "text"),
					   GetSQLValueString(current_datetime(), "date"),
					   GetSQLValueString($this->created_by, "int"),
					   GetSQLValueString(current_ip_address(true), "int"),
					   GetSQLValueString($this->created_by_alias, "text"));
					   //GetSQLValueString(current_datetime(), "text"),
					   //GetSQLValueString($this->modified_by, "text"),
					   //GetSQLValueString(current_ip_address(true), "text"));
					   
		$updateQuery = sprintf("UPDATE ".$prefix_YBDB."shop_locations SET shop_location_id=%s, date_established=%s, active=%s, hostname=%s, modified=%s, modified_by=%s, modified_by_ip=%s WHERE shop_location_id=%s",	
					   GetSQLValueString($this->shop_location_id, "text"),			
					   GetSQLValueString($this->date_established, "date"),
					   GetSQLValueString($this->active, "int"),
					   GetSQLValueString($this->hostname, "text"),
					   //GetSQLValueString(current_datetime(), "date"),
					   //GetSQLValueString($this->created_by, "int"),
					   //GetSQLValueString(current_ip_address(true), "int"),
					   //GetSQLValueString($this->created_by_alias, "text"));
					   GetSQLValueString(current_datetime(), "text"),
					   GetSQLValueString($this->modified_by, "int"),
					   GetSQLValueString(current_ip_address(true), "text"),
					   GetSQLValueString($this->shop_location_id, "text"));
		
		// Does a record exist?			   
		if (!$this->exists($this->shop_location_id)) {
			mysql_query($insertQuery, $YBDB) or die(mysql_error().$query);
			$this->shop_location_id = mysql_insert_id();			
		} else {
			//TODO: Before we blow away the old values, conflict resolution is required.
			mysql_query($updateQuery, $YBDB) or die(mysql_error().$query);
		}	

		return $success;
	}
}

?>
