<?
require_once('classes/ybdbtable.php');

class WorkTrade extends YBDBTable
{
	var $id = null;
	var $contact_id = null;
	var $used_hours = null;
	var $items_cost = null;
	var $items_description = null;
	var $created = null;
	var $created_by = null;
	var $created_by_ip = null;
	var $created_by_alias = null;
	var $modified = null;
	var $modified_by = null;
	var $modified_by_ip = null;

	var $volunteer_rate = null; // per hour
	
	function __construct() {
		$this->created_by = '0';
		$this->modified_by = '0';
		$this->used_hours = '00:00:00';
		$this->items_cost = '0.00';
		$this->volunteer_rate = '5.00';
	}
	
	function load($id) {
		global $database_YBDB, $YBDB, $prefix_YBDB;

		if ($shop_visit_id!=null) {
			$recordQuery = "SELECT *, INET_NTOA(created_by_ip) as created_by_ip, INET_NTOA(modified_by_ip) as modified_by_ip FROM ".$prefix_YBDB."work_trade WHERE id='".$id."' ORDER BY created DESC";
			mysql_select_db($database_YBDB, $YBDB);
			$results = mysql_query($recordQuery, $YBDB) or die(mysql_error().$recordQuery);		
			$row = mysql_fetch_assoc($results) or die(mysql_error().$recordQuery);
			
			$this->id = $row[id];			
			$this->contact_id = $row[contact_id];
			$this->used_hours = $row[used_hours];
			$this->items_cost = $row[items_cost];
			$this->items_description = $row[items_description];
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

	function calcHours() {
		$retval = false; 

		if ($this->items_cost > 0) {
			$hours = floor($this->items_cost / $this->volunteer_rate);
			if (strlen($hours)==1) { $hours = "0".$hours; }

			$temp_cost = $this->items_cost - ($hours * $this->volunteer_rate);
			$minutes = ($temp_cost * 60)  / $this->volunteer_rate;
			if (strlen($minutes)==1) { $minutes = "0".$minutes; }

			$this->used_hours ="$hours:$minutes:00";

			$retval = true;
		}

		return $retval;
	}

	function exists($id) {
		global $database_YBDB, $YBDB, $prefix_YBDB;
		
		$exists = false;
		
		$existsQuery = "SELECT id FROM ".$prefix_YBDB."work_trade WHERE id='".$id."'";			   
		mysql_select_db($database_YBDB, $YBDB);
		$row = mysql_query($existsQuery, $YBDB) or die(mysql_error().$existsQuery);		

		if (mysql_num_rows($row)!=0) {
			$exists = true;
		}
		
		return $exists;
	}
	
	function save() {
		global $database_YBDB, $YBDB, $prefix_YBDB;
		
		$success = true;
				
		$insertQuery = sprintf("INSERT INTO ".$prefix_YBDB."work_trade (contact_id, used_hours, items_cost, items_description, created, created_by, created_by_ip, created_by_alias) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)",
						GetSQLValueString($this->contact_id, "int"),
						GetSQLValueString($this->used_hours, "date"),
						GetSQLValueString($this->items_cost, "float"),
						GetSQLValueString($this->items_description, "text"),
					   GetSQLValueString(current_datetime(), "date"),
					   GetSQLValueString($this->created_by, "int"),
					   GetSQLValueString(current_ip_address(true), "int"),
					   GetSQLValueString($this->created_by_alias, "text"));
					   //GetSQLValueString($this->modified, "text"),
					   //GetSQLValueString($this->modified_by, "text"),
					   //GetSQLValueString($this->modified_by_ip, "text"));
					   
		$updateQuery = sprintf("UPDATE ".$prefix_YBDB."work_trade SET contact_id=%s, used_hours=%s, items_cost=%s, items_description=%s, modified=%s, modified_by=%s, modified_by_ip=%s WHERE id=%s",					 	
						GetSQLValueString($this->contact_id, "int"),
						GetSQLValueString($this->used_hours, "date"),
						GetSQLValueString($this->items_cost, "float"),
						GetSQLValueString($this->items_description, "text"),
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
			mysql_query($insertQuery, $YBDB) or die(mysql_error().$insertQuery);
			$this->id = mysql_insert_id();			
		} else {
			//TODO: Before we blow away the old values, conflict resolution is required.
			mysql_query($updateQuery, $YBDB) or die(mysql_error().$updateQuery);
		}

		return $success;
	}
}

?>
