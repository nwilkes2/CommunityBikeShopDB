<?
require_once('classes/ybdbtable.php');

class BicycleRegistration extends YBDBTable
{
	var $id = null;
	var $registration_number = null;					 	 	 	 	 	 	 
	var $owner_first_name = null;
	var $owner_middle_name = null;
	var $owner_last_name = null;
	var $owner_address = null;
	var $owner_city = null;
	var $owner_zip = null;
	var $owner_phone_home = null;
	var $owner_phone_cell = null;
	var $owner_phone_work = null;
	var $owner_DOB = null;
	var $owner_is_male = null;
	var $owner_is_female = null;
	var $owner_email = null;
	var $owner_license_id = null;
	var $owner_license_state = null;
	var $owner_is_license = null;
	var $owner_is_id = null;
	var $bike_make = null;
	var $bike_model = null;
	var $bike_style = null;
	var $bike_type = null;
	var $bike_speeds = null;
	var $bike_colors = null;
	var $bike_serial = null;
	var $ncic_check = null;
	var $county_check = null;
	var $created = null;
	var $created_by = null;
	var $created_by_ip = null;
	var $created_by_alias = null;
	var $modified = null;
	var $modified_by = null;
	var $modified_by_ip = null;
	
	function __construct() {
		$this->owner_is_license = '0';
		$this->owner_is_id = '0';	
		$this->owner_is_male = '0';
		$this->owner_is_female = '0';
		$this->ncic_check = '0';
		$this->county_check = '0';
		$this->created_by = '0';
		$this->modified_by = '0';
	}

	function load($registration_number) {
		global $database_YBDB, $YBDB, $prefix_YBDB;

		if ($registration_number!=null) {
			$recordQuery = "SELECT * FROM ".$prefix_YBDB."bike_registration WHERE registration_number='".$registration_number."' ORDER BY created DESC";
			mysql_select_db($database_YBDB, $YBDB);
			$results = mysql_query($recordQuery, $YBDB) or die(mysql_error());		
			$row = mysql_fetch_assoc($results) or die(mysql_error());

			$this->id = $row[id];
			$this->registration_number = $row[registration_number];					 	 	 	 	 	 	 
			$this->owner_first_name = $row[owner_first_name];
			$this->owner_middle_name = $row[owner_middle_name];
			$this->owner_last_name = $row[owner_last_name];
			$this->owner_address = $row[owner_address];
			$this->owner_city = $row[owner_city];
			$this->owner_zip = $row[owner_zip];
			$this->owner_phone_home = $row[owner_phone_home];
			$this->owner_phone_cell = $row[owner_phone_cell];
			$this->owner_phone_work = $row[owner_phone_work];
			$this->owner_DOB = $row[owner_DOB];
			$this->owner_is_male = $row[owner_is_male];
			$this->owner_is_female = $row[owner_is_female];
			$this->owner_email = $row[owner_email];
			$this->owner_license_id = $row[owner_license_id];
			$this->owner_license_state = $row[owner_license_state];
			$this->owner_is_license = $row[owner_is_license];
			$this->owner_is_id = $row[owner_is_id];
			$this->bike_make = $row[bike_make];
			$this->bike_model = $row[bike_model];
			$this->bike_style = $row[bike_style];
			$this->bike_type = $row[bike_type];
			$this->bike_speeds = $row[bike_speeds];
			$this->bike_colors = $row[bike_colors];
			$this->bike_serial = $row[bike_serial];
			$this->ncic_check = $row[ncic_check];
			$this->county_check = $row[county_check];
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
	
	function save() {
		global $database_YBDB, $YBDB, $prefix_YBDB;
		
		$success = true;
				
		$insertQuery = sprintf("INSERT INTO ".$prefix_YBDB."bike_registration (registration_number, owner_first_name, owner_middle_name, owner_last_name, owner_address, owner_city, owner_zip, owner_phone_home, owner_phone_cell, owner_phone_work, owner_DOB, owner_is_male, owner_is_female, owner_email, owner_license_id, owner_license_state, owner_is_license, owner_is_id, bike_make, bike_model, bike_style, bike_type, bike_speeds, bike_colors, bike_serial, ncic_check, county_check, created, created_by, created_by_ip, created_by_alias) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",
					   GetSQLValueString($this->registration_number, "text"),					 	
					   GetSQLValueString($this->owner_first_name, "text"),
					   GetSQLValueString($this->owner_middle_name, "text"),
					   GetSQLValueString($this->owner_last_name, "text"),
					   GetSQLValueString($this->owner_address, "text"),
					   GetSQLValueString($this->owner_city, "text"),
					   GetSQLValueString($this->owner_zip, "text"),
					   GetSQLValueString($this->owner_phone_home, "text"),
					   GetSQLValueString($this->owner_phone_cell, "text"),
					   GetSQLValueString($this->owner_phone_work, "text"),
					   GetSQLValueString($this->owner_DOB, "text"),
					   GetSQLValueString($this->owner_is_male, "int"),
					   GetSQLValueString($this->owner_is_female, "int"),
					   GetSQLValueString($this->owner_email, "text"),
					   GetSQLValueString($this->owner_license_id, "text"),
					   GetSQLValueString($this->owner_license_state, "text"),
					   GetSQLValueString($this->owner_is_license, "int"),
					   GetSQLValueString($this->owner_is_id, "int"),
					   GetSQLValueString($this->bike_make, "text"),
					   GetSQLValueString($this->bike_model, "text"),
					   GetSQLValueString($this->bike_style, "text"),
					   GetSQLValueString($this->bike_type, "text"),
					   GetSQLValueString($this->bike_speeds, "text"),
					   GetSQLValueString($this->bike_colors, "text"),
					   GetSQLValueString($this->bike_serial, "text"),
					   GetSQLValueString($this->ncic_check, "int"),
					   GetSQLValueString($this->county_check, "int"),
					   GetSQLValueString(current_datetime(), "date"),
					   GetSQLValueString($this->created_by, "int"),
					   GetSQLValueString(current_ip_address(true), "int"),
					   GetSQLValueString($this->created_by_alias, "text"));
					   //GetSQLValueString($this->modified, "text"),
					   //GetSQLValueString($this->modified_by, "text"),
					   //GetSQLValueString($this->modified_by_ip, "text"));
					   
		$updateQuery = sprintf("UPDATE ".$prefix_YBDB."bike_registration SET owner_first_name=%s, owner_middle_name=%s, owner_last_name=%s, owner_address=%s, owner_city=%s, owner_zip=%s, owner_phone_home=%s, owner_phone_cell=%s, owner_phone_work=%s, owner_DOB=%s, $owner_is_male=%s, $owner_is_female=%s, $owner_email=%s, owner_license_id=%s, owner_license_state=%s, owner_is_license=%s, owner_is_id=%s, bike_make=%s, bike_model=%s, bike_style=%s, bike_type=%s, bike_speeds=%s, bike_colors=%s, bike_serial=%s, ncic_check=%s, county_check=%s, modified=%s, modified_by=%s, modified_by_ip=%s WHERE registration_number=%s",					 	
					   GetSQLValueString($this->owner_first_name, "text"),
					   GetSQLValueString($this->owner_middle_name, "text"),
					   GetSQLValueString($this->owner_last_name, "text"),
					   GetSQLValueString($this->owner_address, "text"),
					   GetSQLValueString($this->owner_city, "text"),
					   GetSQLValueString($this->owner_zip, "text"),
					   GetSQLValueString($this->owner_phone_home, "text"),
					   GetSQLValueString($this->owner_phone_cell, "text"),
					   GetSQLValueString($this->owner_phone_work, "text"),
					   GetSQLValueString($this->owner_DOB, "text"),
					   GetSQLValueString($this->owner_is_male, "int"),
					   GetSQLValueString($this->owner_is_female, "int"),
					   GetSQLValueString($this->owner_email, "text"),
					   GetSQLValueString($this->owner_license_id, "text"),
					   GetSQLValueString($this->owner_license_state, "text"),
					   GetSQLValueString($this->owner_is_license, "int"),
					   GetSQLValueString($this->owner_is_id, "int"),
					   GetSQLValueString($this->bike_make, "text"),
					   GetSQLValueString($this->bike_model, "text"),
					   GetSQLValueString($this->bike_style, "text"),
					   GetSQLValueString($this->bike_type, "text"),
					   GetSQLValueString($this->bike_speeds, "text"),
					   GetSQLValueString($this->bike_colors, "text"),
					   GetSQLValueString($this->bike_serial, "text"),
					   GetSQLValueString($this->ncic_check, "int"),
					   GetSQLValueString($this->county_check, "int"),
					   //GetSQLValueString(current_datetime(), "date"),
					   //GetSQLValueString($this->created_by, "int"),
					   //GetSQLValueString(current_ip_address(true), "int"),
					   //GetSQLValueString($this->created_by_alias, "text"));
					   GetSQLValueString(current_datetime(), "text"),
					   GetSQLValueString($this->modified_by, "int"),
					   GetSQLValueString(current_ip_address(true), "text"),
					   GetSQLValueString($this->registration_number, "text"));
		
		// Does a record exist?			   
//		if ($this->exists($this->registration_number)) {
			$query = $insertQuery;
/*		} else {
			//TODO: Before we blow away the old values, conflict resolution is required.
			$query = $updateQuery;
			$success = $false;
			*/
//		}

		if ($success) $row = mysql_query($query, $YBDB) or die(mysql_error());
		$this->id = mysql_insert_id() or die(mysql_error());

		return $success;
	}
	
	function exists($registration_number) {
		global $database_YBDB, $YBDB, $prefix_YBDB;
		
		$exists = false;
		
		$existsQuery = "SELECT id FROM ".$prefix_YBDB."bike_registration WHERE registration_number='".$registration_number."'";			   
		mysql_select_db($database_YBDB, $YBDB);
		$row = mysql_query($existsQuery, $YBDB) or die(mysql_error());		

		if (mysql_num_rows($row)!=0) {
			$exists = true;
		}
		
		return $exists;
	}

	function count($registration_number) {
		global $database_YBDB, $YBDB, $prefix_YBDB;
		
		$count = 0;
		
		$existsQuery = "SELECT id FROM ".$prefix_YBDB."bike_registration WHERE registration_number='".$registration_number."'";			   
		mysql_select_db($database_YBDB, $YBDB);
		$row = mysql_query($existsQuery, $YBDB) or die(mysql_error());		

		$count = mysql_num_rows($row);
		
		return count;
	}
	
	function licenseType($type=null) {
		$license = null;
		if ($type!=null) {
			$type = strtoupper($type);
			$license = $type;
			if ($type == 'LICENSE') {
				$this->owner_is_license = true;
			} else if ($type == 'ID') {
				$this->owner_is_id = true;	
			}
		} else {
			if ($this->owner_is_license) { $license = 'LICENSE'; }
			if ($this->owner_is_id) { $license = 'ID'; }
		}

		return $license;
	}

	function genderType($type=null) {
                $gender = null;
                if ($type!=null) {
                        $type = strtoupper($type);
                        $gender = $type;
                        if ($type == 'MALE') {
                                $this->owner_is_male = true;
                        } else if ($type == 'FEMALE') {
                                $this->owner_is_female = true;
                        }
                } else {
                        if ($this->owner_is_male) { $license = 'MALE'; }
                        if ($this->owner_is_female) { $license = 'FEMALE'; }
                }

                return $gender;
        }

}

?>
