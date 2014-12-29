<?
require_once('classes/ybdbtable.php');

class ShopHours extends YBDBTable
{
	var $shop_visit_id = null;
	var $contact_id = null;
	var $shop_id = null;
	var $shop_user_role = null;
	var $project_id = null;
	var $time_in = null;
	var $time_out = null;
	var $comment = null;
	var $created = null;
	var $created_by = null;
	var $created_by_ip = null;
	var $created_by_alias = null;
	var $modified = null;
	var $modified_by = null;
	var $modified_by_ip = null;
	
	// Hack for Shop
	var $et = null;  // Estimated Time
	var $at = null;  // Acutual Time
	var $full_name = null;
	var $first_name = null;
	
	function __construct() {
		$this->created_by = '0';
		$this->modified_by = '0';
		$this->time_in = '0000-00-00 00:00:00';
		$this->time_out = '0000-00-00 00:00:00';
	}
	
	function load($shop_visit_id) {
		global $database_YBDB, $YBDB, $prefix_YBDB;

		if ($shop_visit_id!=null) {

			$recordQuery = "SELECT *, INET_NTOA(created_by_ip) as created_by_ip, INET_NTOA(modified_by_ip) as modified_by_ip, TIME_FORMAT(TIMEDIFF(time_out, time_in),'%k:%i') as et, TIME_FORMAT(TIMEDIFF(modified, created),'%k:%i') as at FROM ".$prefix_YBDB."shop_hours WHERE shop_visit_id='".$shop_visit_id."' ORDER BY created DESC";
			mysql_select_db($database_YBDB, $YBDB);
			$results = mysql_query($recordQuery, $YBDB) or die(mysql_error());		
			$row = mysql_fetch_assoc($results) or die(mysql_error());
			
			$this->shop_visit_id = $row[shop_visit_id];
			$this->contact_id = $row[contact_id];
			$this->shop_id = $row[shop_id];
			$this->shop_user_role = $row[shop_user_role];
			$this->project_id = $row[project_id];
			$this->time_in = $row[time_in];
			$this->time_out = $row[time_out];
			$this->comment = $row[comment];
			$this->created = $row[created];
			$this->created_by = $row[created_by];
			$this->created_by_ip = $row[created_by_ip];
			$this->created_by_alias = $row[created_by_alias];
			$this->modified = $row[modified];
			$this->modified_by = $row[modified_by];
			$this->modified_by_ip = $row[modified_by_ip];

			$this->et = $row[et];
			$this->at = $row[at];
 
			//print_r($this);
		}
	}	
	
	function exists($shop_visit_id=null) {
		global $database_YBDB, $YBDB, $prefix_YBDB;
		
		$exists = false;

		if (is_null($shop_visit_id)) {
			$existsQuery = "SELECT shop_visit_id FROM ".$prefix_YBDB."shop_hours WHERE contact_id='".$this->contact_id."' AND shop_id='".$this->shop_id."' AND shop_id='".$this->shop_id."' AND shop_user_role='".$this->shop_user_role."' AND project_id='".$this->project_id."' AND time_in='".$this->time_in."' AND time_out='".$this->time_out."'";			   
		} else {
			$existsQuery = "SELECT shop_visit_id FROM ".$prefix_YBDB."shop_hours WHERE shop_visit_id='".$shop_visit_id."'";			   
		}

		mysql_select_db($database_YBDB, $YBDB);
		$results = mysql_query($existsQuery, $YBDB) or die(mysql_error().$existsQuery);	
		if (mysql_num_rows($results)!=0) {	
			$row = mysql_fetch_object($results) or die(mysql_error().$existsQuery);
			if (isset($row->shop_visit_id)) {
				$this->load($row->shop_visit_id);
				$exists = true;
			}
		}

		return $exists;
	}
	
	function save($import=false) {
		global $database_YBDB, $YBDB, $prefix_YBDB;
		
		$success = true;

		if ($import) {
			$this->created = $this->time_in;
			$this->modified = $this->time_out;
		}


		$insertQuery = sprintf("INSERT INTO ".$prefix_YBDB."shop_hours (contact_id, shop_id, shop_user_role, project_id, time_in, time_out, comment, created, created_by, created_by_ip, created_by_alias) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",
						GetSQLValueString($this->contact_id, "int"),
						GetSQLValueString($this->shop_id, "int"),
						GetSQLValueString($this->shop_user_role, "text"),
						GetSQLValueString($this->project_id, "text"),
						GetSQLValueString($this->time_in, "date"),
						GetSQLValueString($this->time_out, "date"),
						GetSQLValueString($this->comment, "text"),
					   ($import?GetSQLValueString($this->created, "date"):GetSQLValueString(current_datetime(), "text")),
					   GetSQLValueString($this->created_by, "int"),
					   GetSQLValueString(current_ip_address(true), "int"),
					   GetSQLValueString($this->created_by_alias, "text"));
					   //GetSQLValueString($this->modified, "text"),
					   //GetSQLValueString($this->modified_by, "text"),
					   //GetSQLValueString($this->modified_by_ip, "text"));
					   
		$updateQuery = sprintf("UPDATE ".$prefix_YBDB."shop_hours SET contact_id=%s, shop_id=%s, shop_user_role=%s, project_id=%s, time_in=%s, time_out=%s, comment=%s, modified=%s, modified_by=%s, modified_by_ip=%s WHERE shop_visit_id=%s",					 	
						GetSQLValueString($this->contact_id, "int"),
						GetSQLValueString($this->shop_id, "int"),
						GetSQLValueString($this->shop_user_role, "text"),
						GetSQLValueString($this->project_id, "text"),
						GetSQLValueString($this->time_in, "date"),
						GetSQLValueString($this->time_out, "date"),
						GetSQLValueString($this->comment, "text"),
					   //GetSQLValueString(current_datetime(), "date"),
					   //GetSQLValueString($this->created_by, "int"),
					   //GetSQLValueString(current_ip_address(true), "int"),
					   //GetSQLValueString($this->created_by_alias, "text"));
					   ($import?GetSQLValueString($this->modified, "date"):GetSQLValueString(current_datetime(), "text")),
					   GetSQLValueString($this->modified_by, "int"),
					   GetSQLValueString(current_ip_address(true), "text"),
					   GetSQLValueString($this->shop_visit_id, "text"));
		
		// Does a record exist?			   
		if (!$this->exists($this->shop_visit_id)) {
			mysql_query($insertQuery, $YBDB) or die(mysql_error().$query);
			$this->shop_visit_id = mysql_insert_id();			
		} else {
			//TODO: Before we blow away the old values, conflict resolution is required.
			mysql_query($updateQuery, $YBDB) or die(mysql_error().$query);
		}

		return $success;
	}
}

?>
