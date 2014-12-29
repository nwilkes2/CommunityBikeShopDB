<?
require_once('classes/ybdbtable.php');

class Contact extends YBDBTable
{
	var $contact_id = null;
	var $first_name = null;
	var $middle_initial = null;
	var $last_name = null;
	var $email = null;
	var $phone = null;
	var $address1 = null;
	var $address2 = null;
	var $city = null;
	var $state = null;
	var $country = null;
	var $receive_newsletter = null;
	var $date_created = null;
	var $invited_newsletter = null;
	var $DOB = null;
	var $pass = null;
	var $zip = null;
	var $hidden = null;
	var $admin = null;
	var $location_name = null;
	var $location_type = null;
	var $interests = null;
	var $created = null;
	var $created_by = null;
	var $created_by_ip = null;
	var $created_by_alias = null;
	var $modified = null;
	var $modified_by = null;
	var $modified_by_ip = null;

	var $shop_hours = array();

	function __construct() {
		$this->receive_newsletter = '1';
		$this->invited_newsletter = '0';
		$this->DOB = '0000-00-00';
		$this->created_by = '0';
		$this->modified_by = '0';
		$this->admin = '0';
		$this->hidden = '0';
		$this->interests = 'eab=0 tfk=0 valet=0 shop=0';
	}

	function load($contact_id) {
		global $database_YBDB, $YBDB, $prefix_YBDB;

		if ($contact_id!=null && is_numeric($contact_id) && $contact_id>0) {
			$recordQuery = "SELECT *, INET_NTOA(created_by_ip) as created_by_ip, INET_NTOA(modified_by_ip) as modified_by_ip FROM ".$prefix_YBDB."contacts WHERE contact_id='".$contact_id."' ORDER BY created DESC";
			mysql_select_db($database_YBDB, $YBDB);
			$results = mysql_query($recordQuery, $YBDB) or die(mysql_error());		
			$row = mysql_fetch_assoc($results) or die(mysql_error());
			
			$this->contact_id = $row[contact_id];			
			$this->first_name = $row[first_name];
			$this->middle_initial = $row[middle_initial];
			$this->last_name = $row[last_name];
			$this->email = $row[email];
			$this->phone = $row[phone];
			$this->address1 = $row[address1];
			$this->address2 = $row[address2];
			$this->city = $row[city];
			$this->state = $row[state];
			$this->country = $row[country];
			$this->receive_newsletter = $row[receive_newsletter];
//			$this->date_created = $row[date_created];
			$this->invited_newsletter = $row[invited_newsletter];
			$this->DOB = $row[DOB];
			$this->pass = $row[pass];
			$this->zip = $row[zip];
			$this->hidden = $row[hidden];
			$this->admin = $row[admin];
			$this->location_name = $row[location_name];
			$this->location_type = $row[location_type];
			$this->interests = $row[interests];
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

	function mergeHours($contact_id) {
		global $database_YBDB, $YBDB, $prefix_YBDB;

		if ($contact_id!=null && is_numeric($contact_id) && $contact_id>0) {
			mysql_select_db($database_YBDB, $YBDB);
			$updateQuery = "UPDATE `".$prefix_YBDB."shop_hours` SET contact_id=".$this->contact_id.", modified='".current_datetime()."', modified_by_ip=".current_ip_address(true)." WHERE contact_id=".$contact_id;
			mysql_query($updateQuery, $YBDB) or die(mysql_error().$updateQuery);
		}
	}

	function delete($delete) {
		$this->hidden = $delete;
		return $this->save();
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
WHERE shop_hours.contact_id = ".$this->contact_id." ORDER BY hours_rank, time_in ASC;";

		mysql_select_db($database_YBDB, $YBDB);
		$results = mysql_query($selectQuery, $YBDB) or die($selectQuery.' '.mysql_error());		
		while($row = mysql_fetch_assoc($results))
		{
			$shopHours = new ShopHours();
			$tmpContact = new Contact();

			$shopHours->load($row[shop_visit_id]);
			$tmpContact->load($row[contact_id]);

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

	function fixPhoneFormats() {
		//This function is currently broken, it leaves phones numbers in a 801--12-- format

		/*global $database_YBDB, $YBDB, $prefix_YBDB;

		mysql_select_db($database_YBDB, $YBDB);

		$updateQuery = "UPDATE ".$prefix_YBDB."contacts SET phone = REPLACE(phone,'.','')";
		mysql_query($updateQuery, $YBDB) or die(mysql_error().$updateQuery);

		$updateQuery = "UPDATE ".$prefix_YBDB."contacts SET phone = REPLACE(phone,' ','')";
		mysql_query($updateQuery, $YBDB) or die(mysql_error().$updateQuery);

		$updateQuery = "UPDATE ".$prefix_YBDB."contacts SET phone = REPLACE(phone,'-','')";
		mysql_query($updateQuery, $YBDB) or die(mysql_error().$updateQuery);

		$updateQuery = "UPDATE ".$prefix_YBDB."contacts SET phone = REPLACE(phone,'(','')";
		mysql_query($updateQuery, $YBDB) or die(mysql_error().$updateQuery);

		$updateQuery = "UPDATE ".$prefix_YBDB."contacts SET phone = REPLACE(phone,')','')";
		mysql_query($updateQuery, $YBDB) or die(mysql_error().$updateQuery);

		$updateQuery = "UPDATE ".$prefix_YBDB."contacts SET phone = CONCAT(SUBSTRING(phone,1,3),'-',SUBSTRING(phone,4,3),'-',SUBSTRING(phone,7,4))";
 		mysql_query($updateQuery, $YBDB) or die(mysql_error().$updateQuery);
*/	
}

	function exists($contact_id) {
		global $database_YBDB, $YBDB, $prefix_YBDB;
		
		$exists = false;
		
		$existsQuery = "SELECT contact_id FROM ".$prefix_YBDB."contacts WHERE contact_id='".$contact_id."'";			   
		mysql_select_db($database_YBDB, $YBDB);
		$row = mysql_query($existsQuery, $YBDB) or die(mysql_error());		

		if (mysql_num_rows($row)!=0) {
			$exists = true;
		}
		
		return $exists;
	}

	function lookup($search_term, $field) {
		global $database_YBDB, $YBDB, $prefix_YBDB;
		
		$exists = 0;

	//	if ($search_term!="") {

			$existsQuery = "SELECT contact_id FROM ".$prefix_YBDB."contacts WHERE ";

			switch ($field) {
			    case 'phone':
				$search_term = preg_replace('/(\W*)/', '', $search_term); // strip out all non-numeric characters
				$search_term = substr($search_term,0,3).'-'.substr($search_term,3,3).'-'.substr($search_term,6,4);
				$existsQuery .= "phone='".$search_term."'";	
			        break;
			    case 'email':
				$existsQuery .= "email='".$search_term."'";	
				break;
			    case 'name':
				$exploded_name = explode(" ", $search_term);
				if (sizeof($exploded_name) == 2 ) {
					$existsQuery .= "first_name like '%".$exploded_name[0]."%' AND last_name like '%".$exploded_name[1]."%'";
				} elseif (sizeof($exploded_name) == 3 ) {
					$existsQuery .= "first_name like '%".$exploded_name[0]."%' AND last_name like '%".$exploded_name[2]."%'";
				}
				break;
			    default:
				break;
			}

			if (isset($existsQuery)) {
				mysql_select_db($database_YBDB, $YBDB);
				$results = mysql_query($existsQuery, $YBDB) or die(mysql_error().$existsQuery);	
				if (mysql_num_rows($results)!=0) {	
					$row = mysql_fetch_object($results) or die(mysql_error().$existsQuery);
					if (isset($row->contact_id)) {
						//$this->contact_id = $row->contact_id;
						$exists = $row->contact_id;
					}
				}
			}
	//	}

		return $exists;
	}	
	
	function validPassword($password) {
		global $database_YBDB, $YBDB, $prefix_YBDB, $secret;
		
		$success = false;
		
		// Select the current password from the database
		if (isset($password)) {
			$recordQuery = "SELECT DECODE(pass,'".$secret."') as pass FROM ".$prefix_YBDB."contacts WHERE contact_id='".$this->contact_id."'";			   
			mysql_select_db($database_YBDB, $YBDB);
			$results = mysql_query($recordQuery, $YBDB) or die(mysql_error());		
			$row = mysql_fetch_assoc($results) or die(mysql_error());	
			
			if ($password == $row[pass]) {
				$success = true;
			}
		}
		
		return $success;
	}

	function savePassword($new_password) {
		global $database_YBDB, $YBDB, $prefix_YBDB, $secret;
		
		$success = true;
		
		// Select the current password from the database
		if (isset($new_password)) {
			mysql_select_db($database_YBDB, $YBDB);
			
			$recordQuery = "SELECT DECODE(pass,'".$secret."') FROM ".$prefix_YBDB."contacts WHERE contact_id='".$this->contact_id."'";			
			$results = mysql_query($recordQuery, $YBDB) or die(mysql_error());		
			$row = mysql_fetch_assoc($results) or die(mysql_error());	
			
			//echo $recordQuery;
			
			// If the current encrypted password is NOT the same as the one we want to save, then save
			
			if ($new_password != $row[pass]) {
				$updateQuery = sprintf("UPDATE ".$prefix_YBDB."contacts SET pass=ENCODE(%s,'".$secret."') WHERE contact_id='%s'",					
						GetSQLValueString($new_password, "text"),
						GetSQLValueString($this->contact_id, "int"));
			//echo $updateQuery;						
				$results = mysql_query($updateQuery, $YBDB) or die(mysql_error());
			} else {
				$success = false;
			}
		} else {
			$success = false;
		}
		
		//echo $success;
		
		return $success;
	}
	
	function save() {
		global $database_YBDB, $YBDB, $prefix_YBDB;
		
		$success = true;
		
		// NOTE: The Password is NOT saved here, see savePassword()
				
		$insertQuery = sprintf("INSERT INTO ".$prefix_YBDB."contacts (contact_id, first_name, middle_initial, last_name, email, phone, address1, address2, city, state, country, receive_newsletter, invited_newsletter, DOB, zip, hidden, admin, location_name, location_type, interests, created, created_by, created_by_ip, created_by_alias) VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)",
						GetSQLValueString($this->contact_id, "int"),
						GetSQLValueString($this->first_name, "text"),
						GetSQLValueString($this->middle_initial, "text"),
						GetSQLValueString($this->last_name, "text"),
						GetSQLValueString($this->email, "text"),
						GetSQLValueString($this->phone, "text"),
						GetSQLValueString($this->address1, "text"),
						GetSQLValueString($this->address2, "text"),
						GetSQLValueString($this->city, "text"),
						GetSQLValueString($this->state, "text"),
						GetSQLValueString($this->country, "text"),
						GetSQLValueString($this->receive_newsletter, "int"),
						//GetSQLValueString($this->date_created, "text"),
						GetSQLValueString($this->invited_newsletter, "int"),
						GetSQLValueString($this->DOB, "text"),
						//GetSQLValueString($this->pass, "text"),
						GetSQLValueString($this->zip, "text"),
						GetSQLValueString($this->hidden, "int"),
						GetSQLValueString($this->admin, "int"),
						GetSQLValueString($this->location_name, "text"),
						GetSQLValueString($this->location_type, "text"),
						GetSQLValueString($this->interests, "text"),
						GetSQLValueString(current_datetime(), "date"),
						GetSQLValueString($this->created_by, "int"),
						GetSQLValueString(current_ip_address(true), "int"),
						GetSQLValueString($this->created_by_alias, "text"));
						//GetSQLValueString(current_datetime(), "text"),
						//GetSQLValueString($this->modified_by, "int"),
						//GetSQLValueString(current_ip_address(true), "text"));
					   
		$updateQuery = sprintf("UPDATE ".$prefix_YBDB."contacts SET first_name=%s, middle_initial=%s, last_name=%s, email=%s, phone=%s, address1=%s, address2=%s, city=%s, state=%s, country=%s, receive_newsletter=%s, invited_newsletter=%s, DOB=%s, zip=%s, hidden=%s, admin=%s, location_name=%s, location_type=%s, interests=%s, modified=%s, modified_by=%s, modified_by_ip=%s WHERE contact_id=%s",					 	
						GetSQLValueString($this->first_name, "text"),
						GetSQLValueString($this->middle_initial, "text"),
						GetSQLValueString($this->last_name, "text"),
						GetSQLValueString($this->email, "text"),
						GetSQLValueString($this->phone, "text"),
						GetSQLValueString($this->address1, "text"),
						GetSQLValueString($this->address2, "text"),
						GetSQLValueString($this->city, "text"),
						GetSQLValueString($this->state, "text"),
						GetSQLValueString($this->country, "text"),
						GetSQLValueString($this->receive_newsletter, "int"),
//						GetSQLValueString($this->date_created, "text"),
						GetSQLValueString($this->invited_newsletter, "int"),
						GetSQLValueString($this->DOB, "text"),
						// GetSQLValueString($this->pass, "text"),
						GetSQLValueString($this->zip, "text"),
						GetSQLValueString($this->hidden, "int"),
						GetSQLValueString($this->admin, "int"),
						GetSQLValueString($this->location_name, "text"),
						GetSQLValueString($this->location_type, "text"),
						GetSQLValueString($this->interests, "text"),     
						//GetSQLValueString(current_datetime(), "date"),
					   //GetSQLValueString($this->created_by, "int"),
					   //GetSQLValueString(current_ip_address(true), "int"),
					   //GetSQLValueString($this->created_by_alias, "text"));
					   GetSQLValueString(current_datetime(), "text"),
					   GetSQLValueString($this->modified_by, "int"),
					   GetSQLValueString(current_ip_address(true), "text"),
					   GetSQLValueString($this->contact_id, "int"));
		
		// Does a record exist?			   
		if (!$this->exists($this->contact_id)) {
			mysql_query($insertQuery, $YBDB) or die(mysql_error().$insertQuery);
			$this->contact_id = mysql_insert_id();			
		} else {
			//TODO: Before we blow away the old values, conflict resolution is required.
			mysql_query($updateQuery, $YBDB) or die(mysql_error().$updateQuery);
		}

		return $success;
	}
	
	function joinMailmanList($email) {
		global $mailmain_list;
		$retval = true;
		if($email=='') { $email = $this->email; }
		if ($email<>'')
		{
			$maillist_address = $mailmain_list;
			$subject = "";
			$body = "";
			$headers = "From: $email";
	
			if (!mail("$maillist_address", "$subject", "$body", "$headers")) {
	//			print "The subscription request failed. Perhaps the email is not valid or the mail server could not be contacted.";
				$retval = false;
			}
		} else {
			$retval = false;
		}
		return $retval;
	}

	function fullName($order = "last") {
		$retval = null;
		switch ($order) {
		    case 'first':
			$retval = $this->first_name;
			if ($this->middle_initial != "") { $retval .= " ".$this->middle_initial.'.'; }
			if ($this->last_name != "") { $retval .= " ".$this->last_name; }
		        break;
		    case 'last':
		    default:
			$retval = $this->last_name;
			if ($this->first_name != "") { $retval .= ", ".$this->first_name; }
			if ($this->middle_initial != "") { $retval .= " ".$this->middle_initial.'.'; }
		        break;
		}

		return ucwords($retval);
	}

	function getEmployeeHours($formatted=false, $type="logged", $start_date="0000-00-00", $end_date="0000-00-00") {
		global $database_YBDB, $YBDB, $prefix_YBDB;
		$volunteer_hours = '00:00:00';

		if (isset($this->contact_id))
		{
			if ($start_date == "0000-00-00") { $start_date = date('Y')."-01-01"; }
			if ($end_date == "0000-00-00") { $end_date = date('Y')."-21-31"; }
			$recordQuery = null;
			switch ($type) {
			    case "actual":
			        $recordQuery = "SELECT SEC_TO_TIME( SUM( TIME_TO_SEC( modified ) - TIME_TO_SEC( created ) ) ) AS hours FROM ".$prefix_YBDB."shop_hours WHERE contact_id='".$this->contact_id."' AND shop_user_role = 'EMPLOYEE' AND DATE(created) >= '$start_date' AND DATE(modified) <= '$end_date' AND modified != '0000-00-00 00:00:00'";
			        break;
			    case "logged":
			    default:
			        $recordQuery = "SELECT SEC_TO_TIME( SUM( TIME_TO_SEC( time_out ) - TIME_TO_SEC( time_in ) ) ) AS hours FROM ".$prefix_YBDB."shop_hours WHERE contact_id='".$this->contact_id."' AND shop_user_role = 'EMPLOYEE' AND DATE(time_in) >= '$start_date' AND DATE(time_out) <= '$end_date' AND time_out != '0000-00-00 00:00:00'";
			        break;
			}

			//echo $recordQuery;
			mysql_select_db($database_YBDB, $YBDB);
			$results = mysql_query($recordQuery, $YBDB) or die(mysql_error());		
			$row = mysql_fetch_assoc($results) or die(mysql_error());
			if ($row[hours]>0) {
				$volunteer_hours = $row[hours];

				if ($formatted) {
					list($H, $i, $s) = split('[:]', $volunteer_hours);
			
					$volunteer_rate = 5.00;

					$volunteer_credit = ($H*$volunteer_rate) + (($i*($volunteer_rate/.6))/100);
					$volunteer_credit = round($volunteer_credit, 2);

					$volunteer_hours = "$H:$i hrs = $$volunteer_credit";
				}
			}
		}
		return $volunteer_hours;
	}
	
	function getVolunteerHoursForDay($formatted=false, $type="logged", $volunteer_date="0000-00-00") {
		return $this->getVolunteerHours($formatted, $type, $volunteer_date, $volunteer_date);
	}

	function getVolunteerHours($formatted=false, $type="logged", $start_date="0000-00-00", $end_date="0000-00-00") {
		global $database_YBDB, $YBDB, $prefix_YBDB;
		$volunteer_hours = '00:00:00';

		if (isset($this->contact_id))
		{
			if ($start_date == "0000-00-00") { $start_date = date('Y')."-01-01"; }
			if ($end_date == "0000-00-00") { $end_date = date('Y')."-21-31"; }
			$recordQuery = null;
			switch ($type) {
			    case "actual":
			        $recordQuery = "SELECT SEC_TO_TIME( SUM( TIME_TO_SEC( modified ) - TIME_TO_SEC( created ) ) ) AS hours FROM ".$prefix_YBDB."shop_hours WHERE contact_id='".$this->contact_id."' AND shop_user_role != 'EMPLOYEE' AND DATE(created) >= '$start_date' AND DATE(modified) <= '$end_date' AND modified != '0000-00-00 00:00:00'";
			        break;
			    case "logged":
			    default:
			        $recordQuery = "SELECT SEC_TO_TIME( SUM( TIME_TO_SEC( time_out ) - TIME_TO_SEC( time_in ) ) ) AS hours FROM ".$prefix_YBDB."shop_hours WHERE contact_id='".$this->contact_id."' AND shop_user_role != 'EMPLOYEE' AND DATE(time_in) >= '$start_date' AND DATE(time_out) <= '$end_date' AND time_out != '0000-00-00 00:00:00'";
			        break;
			}

			//echo $recordQuery;
			mysql_select_db($database_YBDB, $YBDB);
			$results = mysql_query($recordQuery, $YBDB) or die(mysql_error());		
			$row = mysql_fetch_assoc($results) or die(mysql_error());
			if ($row[hours]>0) {
				$volunteer_hours = $row[hours];

				if ($formatted) {
					list($H, $i, $s) = split('[:]', $volunteer_hours);
			
					$volunteer_rate = 5.00;

					$volunteer_credit = ($H*$volunteer_rate) + (($i*($volunteer_rate/.6))/100);
					$volunteer_credit = round($volunteer_credit, 2);

					$volunteer_hours = "$H:$i hrs = $$volunteer_credit";
				}
			}
		}
		return $volunteer_hours;
	}	

	function getUsedHours($formatted=false) {
		global $database_YBDB, $YBDB, $prefix_YBDB;
		$used_hours = '00:00:00';

		if (isset($this->contact_id))
		{
			$recordQuery = "SELECT SEC_TO_TIME( SUM( TIME_TO_SEC( used_hours ) ) ) as used_hours FROM ".$prefix_YBDB."work_trade WHERE contact_id='".$this->contact_id."' AND created > '".date('Y')."-01-01 00:00:00' AND created <= '".date('Y')."-12-31 00:00:00'";

			mysql_select_db($database_YBDB, $YBDB);
			$results = mysql_query($recordQuery, $YBDB) or die(mysql_error());		
			$row = mysql_fetch_assoc($results) or die(mysql_error());

			if ($row[used_hours]>0) {
				$used_hours = $row[used_hours]; 
			//	echo "UsedHours:".$row[used_hours]; 

				if ($formatted) {
					list($H, $i, $s) = split('[:]', $used_hours);
			
					$volunteer_rate = 5.00;

					$volunteer_credit = ($H*$volunteer_rate) + (($i*($volunteer_rate/.6))/100);
					$volunteer_credit = round($volunteer_credit, 2);
	
					$used_hours = "$H:$i hrs = $$volunteer_credit";

				}
			}
		}

		return $used_hours;
	}

	function getRemainingHours($formatted=false) {
		$remaining_hours = '00:00:00';

	//	echo $this->getVolunteerHours()."<br>".$this->getUsedHours()."<br>";

		if ($this->getVolunteerHours()!="00:00:00" && isset($this->contact_id))
		{
		    list($hours, $minutes) = split(':', $this->getVolunteerHours()); 
		    $volunteer_minutes = ($hours * 60) + $minutes;
     
		    list($hours, $minutes) = split(':', $this->getUsedHours()); 
		    $used_minutes = ($hours * 60) + $minutes; 

		    $remaining_minutes = $volunteer_minutes - $used_minutes;

		    $remaining_hours = floor($remaining_minutes / 60);
		    $remaining_minutes -= $remaining_hours * 60;

/*		    $seconds = $volunteer_hours - $used_hours; 
		    $minutes = ($seconds / 60) % 60;

		    if (strlen($minutes)==1) { $minutes = "0".$minutes; }
		    $hours = round($seconds / (60 * 60)); 

 */		    $remaining_hours = $remaining_hours.":".$remaining_minutes.":00";
 
			if ($formatted) {
				list($H, $i, $s) = split('[:]', $remaining_hours);
			
				$volunteer_rate = 5.00;

				$volunteer_credit = ($H*$volunteer_rate) + (($i*($volunteer_rate/.6))/100);
				$volunteer_credit = round($volunteer_credit, 2);

				$remaining_hours = "$H:$i hrs = $$volunteer_credit";

			}
		}
		return $remaining_hours;		

	}


}

?>
