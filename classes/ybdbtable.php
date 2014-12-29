<?
class YBDBTable
{
	//This function corrects the datatype for form submitted variables 
	function GetSQLValueString($theValue, $theType, $theDefinedValue = "", $theNotDefinedValue = "") 
	{
  		$theValue = (!get_magic_quotes_gpc()) ? addslashes($theValue) : $theValue;

		switch ($theType) {
			case "text":
				$theValue = ($theValue != "") ? "'" . $theValue . "'" : "NULL";
				break;    
			case "long":
			case "int":
				$theValue = ($theValue != "") ? intval($theValue) : "NULL";
				break;
			case "double":
				$theValue = ($theValue != "") ? "'" . doubleval($theValue) . "'" : "NULL";
				break;
			case "date":
				if(($theValue == 'current_time') || ($theValue == 'Current Date')){
					$theValue = current_datetime();
				}
				
				$theValue = ($theValue != "") ? "'" . $theValue . "'" : "NULL";
				break;
			case "defined":
				$theValue = ($theValue != "") ? $theDefinedValue : $theNotDefinedValue;
				break;
		}
		return $theValue;
	}
	
	//function to convert server time to local time.  To be used by all other current date / time requests. 
	function local_datetime(){
		global $hours_offset;
		return time() + ($hours_offset * 60 * 60);
						//offset hours; 60 mins; 60secs offset
	}

	//function converts the current date/time into h:m am format 
	function current_datetime(){
		return date("Y-m-d H:i:s",local_datetime());
	}
	
	//function converts the current date/time into YYYY-MM-DD am format 
	function current_date(){
		return date("Y-m-d",local_datetime());
	}
	
	//function converts the current date/time into h:m am format 
	function date_to_time($date_in){
		list($date, $time) = split('[ ]', $date_in);
		list($H, $i, $s) = split('[:]', $time);
		$time_out = date("g:i a", mktime((int)$H,(int)$i, (int)$s, 1,1,2000));
		return $time_out;
	}

	//takes a date in and adds current time if date has changed
	function date_update_wo_timestamp($date_in, $database_date){
		list($date, $time) = split('[ ]', $database_date);
		$timestamp_out = (($date == $date_in) ? $database_date : $date_in);
		return $timestamp_out;
	}
	
	function date_to_timestamp($date_in){
		list($date, $time) = split('[ ]', $start_time);
		list($Y, $m, $d) = split('[-]', $date);
		list($H, $i, $s) = split('[:]', $time);
		$time_out = mktime($H, $i, $s, $m, $d, $Y);
		return $time_out;
	}
	
	//
	function datetime_to_time($date_in){
		list($date, $time) = split('[ ]', $date_in);
		list($H, $i, $s) = split('[:]', $time);
		$time_out = date("H:i:s", mktime($H, $i, $s, 1,1,2000));
		return $time_out;
	}
	
	//
	function datetime_to_date($date_in){
		list($date, $time) = split('[ ]', $date_in);
		list($Y, $m, $d) = split('[-]', $date);
		$date_out = date("Y-m-d", mktime($H, $i, $s, $m,$d,$Y));
		return $date_out;
	}
	
	// Current IP Address
	function current_ip_address($isInt=false){
		$retval = $_SERVER['REMOTE_ADDR'];
		//echo "$retval: ";
		if ($isInt) {
			// Get INT value;
			global $database_YBDB, $YBDB;
			mysql_select_db($database_YBDB, $YBDB);
			$query = "SELECT INET_ATON('$retval');";
			$row = mysql_query($query) or die(mysql_error());
			$retval = mysql_result($row, 0) or die(mysql_error());
			//echo "$retval";
		}
		return $retval;	
	}

	function current_hostname_ip($domain){
		$retval = null;
		$ip = gethostbyname($domain);
		if($domain != $ip) {
			$retval = $ip;
		}
		return $retval;
	}

	function canEdit() {
		global $database_YBDB, $YBDB, $prefix_YBDB;
		
		$retval = true;
		
		// If the recorded IP address is not the same as the current, return false
		if ($this->created_by_ip != $this->current_ip_address())
		{
			$retval = false;
		}
		
		return $retval;
	}
}
?>
