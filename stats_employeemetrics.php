<?php 
require_once('Connections/YBDB.php');
require_once('Connections/database_functions.php'); 
$page_individual_history_log = INDIVIDUAL_HISTORY_LOG; 

$page = "stats_employeemetrics.php"; 

//error
switch ($_GET['error']) { 
case 'incorrectcode':
   $error_message = '<- Invalid code';
   break;
case 'timeexpired':
   $error_message = '<- Time expired - Reenter code';
   break;  
default:
   $error_message = '<- Enter Employee Code';
   break;
}

//default settings
$currency = 0;
$places = 1;

switch ($_GET['metric']) {
//Main Stats	
//case 'NetProductionPerHour':   This is the default
//   $metric = $_GET['metric'];
//   $title = "Net Production Value Per Hour ([Value of Fixed Bikes and Wheels - Pay] / Regular Hours)";
//   break;
case 'NetProductionToPayValueRatio':
   $metric = $_GET['metric'];
   $title = "Value Ratio - (Value of Bikes + Wheels Completed)/Regular Pay";
   break;   
case 'HoursPerBikeFixed':	//this is a sample error message.  insert error case here		
   $metric = $_GET['metric'];
   $title = "Hours Per Bike Fixed";
   break;
case 'HoursPerBikeSold':	//this is a sample error message.  insert error case here		
   $metric = $_GET['metric'];
   $title = "Hours Per Bike Sold";
   break;
case 'SalesPerHour':	//this is a sample error message.  insert error case here		
   $metric = $_GET['metric'];
   $title = "Sales Per Hour";
   $currency = 1;
   $places = 0;
   break;
//Hours
case 'Hours_All':	//this is a sample error message.  insert error case here		
   $metric = $_GET['metric'];
   $title = "Total Hours";
   break;
case 'Hours_NoSpec':	//this is a sample error message.  insert error case here		
   $metric = $_GET['metric'];
   $title = "Regular Hours";
   break;
case 'Hours_Spec':	//this is a sample error message.  insert error case here		
   $metric = $_GET['metric'];
   $title = "Special Hours";
   break;   
//Production Stats      
case 'AverageValueBikesFixed':	//this is a sample error message.  insert error case here		
   $metric = $_GET['metric'];
   $title = "Average Value of Bikes Fixed";
   $currency = 1;
   $places = 0;
   break;
case 'AverageValueNewPartsOnBikes':	//this is a sample error message.  insert error case here		
   $metric = $_GET['metric'];
   $title = "Average Value of New Parts on Bikes";
   $currency = 1;
   $places = 0;
   break;
case 'AverageNetValueBikesFixed':	//this is a sample error message.  insert error case here		
   $metric = $_GET['metric'];
   $title = "Average Net Balue of Bikes Fixed (Bike Price - New Parts)";
   $currency = 1;
   $places = 0;
   break;
case 'NetValueBikesFixedPerHour':	//this is a sample error message.  insert error case here		
   $metric = $_GET['metric'];
   $title = "Net Value of Bikes Fixed Per Hour";
   $currency = 1;
   break;   
case 'NumBikesFixed':	//this is a sample error message.  insert error case here		
   $metric = $_GET['metric'];
   $title = "Number of Bikes Fixed";
   $places = 0;
   break;
case 'AverageValueWheelsFixed':	//this is a sample error message.  insert error case here		
   $metric = $_GET['metric'];
   $title = "Average Value of Wheels Fixed";
   $currency = 1;
   $places = 0;
   break;
case 'NumWheelsFixed':	//this is a sample error message.  insert error case here		
   $metric = $_GET['metric'];
   $title = "Total Number of Wheels Fixed";
   $places = 0;
   break;
//Sales
case 'HoursPerBikeSold':	//this is a sample error message.  insert error case here		
   $metric = $_GET['metric'];
   $title = "Hours Per Bike Sold";
   $places = 0;
   break;
case 'NumBikesSold':	//this is a sample error message.  insert error case here		
   $metric = $_GET['metric'];
   $title = "Number of Bikes Sold";
   $places = 0;
   break;
default:
   $metric = 'NetProductionPerHour';
   $title = "Net Production Value Per Hour ([Value of Fixed Bikes and Wheels - Pay] / Regular Hours)";
   $currency = 1;
   break;
}

switch ($_GET['period']) {
case 'Year':
   $period = $_GET['period'];
   break;	
case 'Quarter':
   $period = $_GET['period'];
   break;	
//case 'Month':
//   $period = $_GET['period'];
//   break;
//case 'Week':	//this is a sample error message.  insert error case here		
//   $period = $_GET['period'];
//   break;
default:
   $period = 'Quarter';
   break;
}

//CheckDetailCode     isset($_POST["MM_update"]) =========================================================
if ((isset($_POST["MM_insert"])) && ($_POST["MM_insert"] == "CheckDetailCode")) {
	session_start();	
	$employeedetail = "_employeedetail";
	$error = "";
	switch ($_POST['EmployeeDetailCode']) {
	case '3267':
	   	$_SESSION['employee'] = "BW";
		$_SESSION['ContactID'] = "10019";
	   	break;
	case '5478':
	   	$_SESSION['employee'] = "Conti";
		$_SESSION['ContactID'] = "4009";
	   	break;	
	case '4398':
	   	$_SESSION['employee'] = "John";
	   	$_SESSION['ContactID'] = "1755";
	   	break;	
	case '2145':
	   	$_SESSION['employee'] = "Pete";
	   	$_SESSION['ContactID'] = "107";
	   	break;
	case '8745':
	   	$_SESSION['employee'] = "Savanna";
		$_SESSION['ContactID'] = "554";
	   	break;
	default:
   		$employeedetail = "";
   		$_SESSION['employee'] = "None";
		$_SESSION['timestamp'] = "None";
		$error = "error=incorrectcode";
   		break;}	
	
	$_SESSION['timestamp'] = time();
			
  	header("Location: stats_employeemetrics$employeedetail.php?$error");   //$editFormAction
}


mysql_select_db($database_YBDB, $YBDB);
$query_Recordset1 = "select v.Year AS Year,v.$period AS $period,
sum(if((v.ContactID = 10019),v.$metric,0)) AS BW,
sum(if((v.ContactID = 4009),v.$metric,0)) AS Conti,
sum(if((v.ContactID = 107),v.$metric,0)) AS Pete,
sum(if((v.ContactID = 554),v.$metric,0)) AS Savanna, 
sum(if((v.ContactID = 1755),v.$metric,0)) AS John 
from view_EmployeeMetrics5_by$period" . "_HoursCalc v
group by `v`.`Year` DESC,`v`.`$period` DESC;";
$Recordset1 = mysql_query($query_Recordset1, $YBDB) or die(mysql_error());
$totalRows_Recordset1 = mysql_num_rows($Recordset1);
$row_Recordset1 = mysql_fetch_assoc($Recordset1); //Loads first record so latest date is not visable.  Statistics available at close of period.

?>

<?php include("include_header.html"); ?>

        <table>
        	<tr><td><?php echo "Main Stats: 
        	<a href=\"$page?metric=NetProductionPerHour&period=$period\">Net Production Per Hour</a>,
        	<a href=\"$page?metric=NetProductionToPayValueRatio&period=$period\">Net Production To Pay Ratio</a>, 
        	<a href=\"$page?metric=HoursPerBikeFixed&period=$period\">Hours Per Bike Fixed</a>, 
        	<a href=\"$page?metric=SalesPerHour&period=$period\">Sales Per Hour</a><br>
        	Hours: 
        	<a href=\"$page?metric=Hours_All&period=$period\">Total Hours</a>,
        	<a href=\"$page?metric=Hours_NoSpec&period=$period\">Regular Hours</a>,
        	<a href=\"$page?metric=Hours_Spec&period=$period\">Special Hours</a><br>
        	Production Figures:
        	<!--<a href=\"$page?metric=AverageValueBikesFixed&period=$period\">Average Value Bikes Fixed</a>,
        	<!--<a href=\"$page?metric=AverageValueNewPartsOnBikes&period=$period\">Avg Value New Parts on Bikes</a>,-->
        	<a href=\"$page?metric=AverageNetValueBikesFixed&period=$period\">Avg Net Value Bikes Fixed</a>,
        	<a href=\"$page?metric=NetValueBikesFixedPerHour&period=$period\">Net Value of Bikes Fixed Per Hour</a>,
        	<a href=\"$page?metric=NumBikesFixed&period=$period\">Number of Bikes Fixed</a>,
        	<a href=\"$page?metric=AverageValueWheelsFixed&period=$period\">Average Value of Wheels Fixed</a>,
        	<a href=\"$page?metric=NumWheelsFixed&period=$period\">Number of Wheels Fixed</a><br>
        	Sales Stats:
        	<a href=\"$page?metric=HoursPerBikeSold&period=$period\">Hours Per Bike Sold</a>,
        	<a href=\"$page?metric=NumBikesSold&period=$period\">Number of Bikes Sold</a><br><br>
        	
        	View by: 
        	<a href=\"$page?metric=$metric&period=Year\">Year</a>
        	<a href=\"$page?metric=$metric&period=Quarter\">Quarter</a>
        	<!--,<a href=\"$page?metric=$metric&period=Month\">Month</a>
        	<!--,<a href=\"$page?metric=$metric&period=Week\">Week</a>-->"?>
        	
        	<form id="form1" name="form1" method="post" action="">
        		View Employee Details: 
        		<input name="EmployeeDetailCode" type="text" value="" size="20" maxlength="20" autocomplete="off">
        		<input type="submit" name="Submit" value="Load">
                <input type="hidden" name="MM_insert" value="CheckDetailCode">
                <span class = "yb_standardred"><?php echo $error_message;?></span>
        	</form>
        	</td></tr>
        	<tr valign="top"><td><span class="yb_heading3red"><?php echo $title; ?></span></td></tr>
        <tr>
          <td>
          	
            <table id="metrics"  border="1" cellpadding="1" cellspacing="0">
              <tr valign="top" bgcolor="#99CC33" class="yb_standardCENTER">
                <td width="100" height="35">Year</td>
			    <td width="100"><?php echo $period?></td>
			    <td width="100">BW<br />
		        <td width="100">Conti<br />
		        <td width="100">John<br />
		        <td width="100">Pete<br />
		        <td width="100">Savanna<br />
		      </tr>
		      
              <form method="post" name="FormUpdate_<?php echo $row_Recordset1['shop_id']; ?>" action="<?php echo $editFormAction; ?>">
                <?php while ($row_Recordset1 = mysql_fetch_assoc($Recordset1)) { //do { 
			  if(1 == 2) {?>
                <tr valign="bottom" bgcolor="#CCCC33">
                  <td>&nbsp;</td>
			      <td>&nbsp;</td>
			      <td>&nbsp;</td>
			      <td>&nbsp;</td>
			    </tr>
                <input type="hidden" name="MM_insert" value="FormEdit">
                <input type="hidden" name="shop_id" value="<?php echo $row_Recordset1['shop_id']; ?>">
              </form>
		    <?php } else { // end if EDIT RECORD ?>
              <tr class=yb_standardRIGHT>
			    <td><?php echo $row_Recordset1['Year']; ?></td>
			    <td><?php echo $row_Recordset1["$period"]; ?></td>
			    <td><?php echo formatnum($row_Recordset1['BW'],$currency,$places);  ?></td>
			    <td><?php echo formatnum($row_Recordset1['Conti'],$currency,$places); ?></td>
			    <td><?php echo formatnum($row_Recordset1['John'],$currency,$places); ?></td>
			    <td><?php echo formatnum($row_Recordset1['Pete'],$currency,$places); ?></td>
			    <td><?php echo formatnum($row_Recordset1['Savanna'],$currency,$places); ?></td>
		      </tr>
              <?php
		  } // end if EDIT RECORD 
		  } // end WHILE count of recordset ?>
          </table>	  </td>
	  </tr>
        </table>
		
		<?php include("include_footer.html"); ?>
<?php
mysql_free_result($Recordset1);
?>
