<?
require_once('classes/ybdbtable.php');

class CommunityServiceLetter extends YBDBTable
{
	var $id = null;
	var $contact_id = null;
	var $hours = null;
	var $start_date = null;
	var $end_date = null;
	var $salutation = null;
	var $case_number = null;		
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
		$this->used_hours = '00:00:00';
		$this->items_cost = '0.00';
	}
	
	function load($id) {
		global $database_YBDB, $YBDB, $prefix_YBDB;

		if ($shop_visit_id!=null) {
			$recordQuery = "SELECT *, INET_NTOA(created_by_ip) as created_by_ip, INET_NTOA(modified_by_ip) as modified_by_ip FROM ".$prefix_YBDB."community_service_letters WHERE id='".$id."' ORDER BY created DESC";
			mysql_select_db($database_YBDB, $YBDB);
			$results = mysql_query($recordQuery, $YBDB) or die(mysql_error().$recordQuery);		
			$row = mysql_fetch_assoc($results) or die(mysql_error().$recordQuery);
			
			$this->id = $row[id];			
			$this->contact_id = $row[contact_id];
			$this->hours = $row[hours];
			$this->start_date = $row[start_date];
			$this->end_date = $row[end_date];						
			$this->salutation = $row[salutation];
			$this->case_number = $row[case_number];
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

	function exists($id) {
		global $database_YBDB, $YBDB, $prefix_YBDB;
		
		$exists = false;
		
		$existsQuery = "SELECT id FROM ".$prefix_YBDB."community_service_hours WHERE id='".$id."'";			   
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
				
		$insertQuery = sprintf("INSERT INTO ".$prefix_YBDB."community_service_hours (contact_id, hours, start_date, end_date, salutation, case_number, created, created_by, created_by_ip, created_by_alias) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s)",
						GetSQLValueString($this->contact_id, "int"),
						GetSQLValueString($this->hours, "date"),
						GetSQLValueString($this->start_date, "date"),
						GetSQLValueString($this->end_date, "date"),
						GetSQLValueString($this->salutation, "text"),
						GetSQLValueString($this->case_number, "text"),												
					   GetSQLValueString(current_datetime(), "date"),
					   GetSQLValueString($this->created_by, "int"),
					   GetSQLValueString(current_ip_address(true), "int"),
					   GetSQLValueString($this->created_by_alias, "text"));
					   //GetSQLValueString($this->modified, "text"),
					   //GetSQLValueString($this->modified_by, "text"),
					   //GetSQLValueString($this->modified_by_ip, "text"));
					   
		$updateQuery = sprintf("UPDATE ".$prefix_YBDB."community_service_letters SET contact_id=%s, hours=%s, start_date=%s, end_date=%s, salutation=%s, case_number=%s, modified=%s, modified_by=%s, modified_by_ip=%s WHERE id=%s",					 	
						GetSQLValueString($this->contact_id, "int"),
						GetSQLValueString($this->hours, "date"),
						GetSQLValueString($this->start_date, "date"),
						GetSQLValueString($this->end_date, "date"),
						GetSQLValueString($this->salutation, "text"),
						GetSQLValueString($this->case_number, "text"),
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
