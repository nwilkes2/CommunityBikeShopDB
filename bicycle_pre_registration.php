<meta http-equiv="content-type" content="text/html;charset=utf-8">
<?php 
require_once('Connections/YBDB.php'); 
require_once('Connections/database_functions.php');

switch ($_GET['error']) {
case 'success':
   $error_message = 'Your Registration has been saved! </span><span class="yb_standard"> The Collective is required by law to register every bike sold.  We use this information soely for this purpose and it is kept entirely private.</span><span class="yb_heading3red">';
   break;
default:
   $error_message = 'Enter or Update Bicycle Registration Information - ALL of the * fields are required.</span><br><span class="yb_standard"> The Collective is required by law to register every bike sold.  We use this information soely for this purpose and it is kept entirely private.</span><span class="yb_heading3red">';
   break;
}

$registration = new BicycleRegistration();

$registration->registration_number = $_POST['registration_number'];
$registration->owner_first_name = $_POST['owner_first_name'];
$registration->owner_middle_name = $_POST['owner_middle_name'];
$registration->owner_last_name = $_POST['owner_last_name'];
$registration->owner_address = $_POST['owner_address'];
$registration->owner_city = $_POST['owner_city'];
$registration->owner_zip = $_POST['owner_zip'];
$registration->owner_phone = $_POST['owner_phone'];
$registration->owner_DOB = $_POST['owner_DOB'];
$registration->owner_license_id = $_POST['owner_license_id'];
$registration->owner_license_state = $_POST['owner_license_state'];
$registration->licenseType($_POST['owner_license_type']);  //NOTE: This is a function.
$registration->bike_make = $_POST['bike_make'];
$registration->bike_model = $_POST['bike_model'];
$registration->bike_style = $_POST['bike_style'];
$registration->bike_type = $_POST['bike_type'];
$registration->bike_speeds = $_POST['bike_speeds'];
$registration->bike_colors = $_POST['bike_colors'];
$registration->bike_serial = $_POST['bike_serial'];
// $registration->ncic_check = $_POST['ncic_check'];
// $registration->county_check = $_POST['county_check'];
// $registration->created = $_POST['created'];
// $registration->created_by = $_POST['created_by'];
// $registration->created_by_ip = $_POST['created_by_ip'];
// $registration->created_by_alias = $_POST['created_by_alias'];
// $registration->modified = $_POST['modified'];
// $registration->modified_by = $_POST['modified_by'];
// $registration->modified_by_ip = $_POST['modified_by_ip'];

//if (isset($registration->registration_number)) {
if ($_POST['password'] != "") {
	if ($_POST['password'] == "diethief") {
		//TODO: fix this hack
			
		if ($registration->bike_type=="Other" && $_POST['bike_type_other']!="") { $registration->bike_type = $_POST['bike_type_other']; }
		if ($registration->bike_style=="Other" && $_POST['bike_style_other']!="") { $registration->bike_style = $_POST['bike_style_other']; }

		if ($registration->save()) {
			header( 'Location: bicycle_registration_pdf.php?registration_number='.$registration->registration_number );
			//$error_message = 'Your Registration has been saved! </span><span class="yb_standard"> The Collective is required by law to register every bike sold.  We use this information soely for this purpose and it is kept entirely private.</span><span class="yb_heading3red">';
		} else {
			$error_message = 'Something is wrong with your registration. </span><span class="yb_standard"> Were ALL the fields filled in?  If they are it means someone has already tried to register this number, please ask for a paper form and fill that out.</span><span class="yb_heading3red">';
		}
	} else {
			$error_message = 'The Authorized password was INCORRECT.  </span><span class="yb_standard"> Please try again. </span><span class="yb_heading3red">';
	}
}
//}

?>

<?php include("include_header.html"); ?>

	<script type="text/javascript">
		warning = true;
	</script>
<table>
  <tr valign="top">
    <td   align="left"><span class="yb_heading3red"><?php echo $error_message; ?></span></td>
	  </tr>
  <tr>
    <td align="center">
      
      <form method="post" id="form" name="form" class="form" onsubmit="return validate(this)" action="<?php echo $editFormAction; ?>" autocomplete="off">
        <table width="500" border="1" cellpadding="1" cellspacing="0" bordercolor="#CCCCCC">
          <tr valign="baseline" class="odd">
            <td width="200" align="right" nowrap>Registration Number:</td>
			<td><img src="media/system/images/bike_reg_sticker.jpg"><br><input type="text" id="registration_number" name="registration_number" value="<?php echo $registration->registration_number; ?>" size="25" autocomplete="off"> <font color="red">*</font><input type="submit" name="search" id="search" value="Find Exisiting Bike Info"><br>You must include the red "T"</td>
		  </tr>
          <tr valign="baseline">
            <td nowrap colspan="2"><strong>Owner's Information</strong></td>
		  </tr>
          <tr valign="baseline" class="odd">
            <td nowrap align="right">First Name:</td>
			<td><input type="text" id="owner_first_name" name="owner_first_name" value="<?php echo $registration->owner_first_name; ?>" size="25"> <font color="red">*</font></td>
		  </tr>
          <tr valign="baseline">
            <td nowrap align="right">Middle Name:</td>
			<td><input id="owner_middle_name" name="owner_middle_name" type="text" value="<?php echo $registration->owner_middle_name; ?>" size="25" maxlength="25"></td>
		  </tr>
          <tr valign="baseline" class="odd">
            <td nowrap align="right">Last Name:</td>
			<td><input type="text" id="owner_last_name" name="owner_last_name" value="<?php echo $registration->owner_last_name; ?>" size="25"> <font color="red">*</font></td>
		  </tr>
          <tr valign="baseline">
            <td nowrap align="right">Address:</td>
			<td><input type="text" id="owner_address" name="owner_address" value="<?php echo $registration->owner_address; ?>" size="25"> <font color="red">*</font></td>
	      </tr>
          <tr valign="baseline" class="odd">
            <td nowrap align="right">City:</td>
			<td><input type="text" id="owner_city" name="owner_city" value="<?php echo $registration->owner_city; ?>" size="25"> <font color="red">*</font></td>
	      </tr>
          <tr valign="baseline">
            <td nowrap align="right">ZIP:</td>
			<td><input type="text" id="owner_zip" name="owner_zip" value="<?php echo $registration->owner_zip; ?>" size="10"> <font color="red">*</font></td>
	      </tr>
          <tr valign="baseline" class="odd">
            <td nowrap align="right">Phone:</td>
			<td><input type="text" id="owner_phone" name="owner_phone" value="<?php echo $registration->owner_phone; ?>" size="25"> <font color="red">*</font></td>
		  </tr>	
		  <tr valign="baseline">
            <td nowrap align="right">Date of Birth: </td>
			<td>
				<?php

				$myCalendar = new tc_calendar("owner_DOB", true);
				$myCalendar->setIcon("media/calendar/images/iconCalendar.gif");
				list($Y, $m, $d) = split('[-]', $registration->owner_DOB);
				$myCalendar->setDate($d, $m, $Y);
				$myCalendar->setPath("media/calendar/");
				$myCalendar->setYearInterval(1930, 2011);
				$myCalendar->dateAllow('1930-01-01', '2011-12-31');
				$myCalendar->writeScript();

				?><font color="red">*</font></td>
		  </tr>
          <tr valign="baseline" class="odd">
            <td nowrap colspan="2"><strong>Identification</strong> - The police can use your ID to determine your current address if they recover your bike.</td>
		  </tr>			  
		  <tr valign="baseline">
            <td nowrap align="right">Drivers License or ID: </td>
			<td><input type="text" id="owner_license_id" name="owner_license_id" value="<?php echo $registration->owner_license_id; ?>" size="25" /></td>
		  </tr>
		  <tr valign="baseline" class="odd">
            <td nowrap align="right">State: </td>
			<td><input type="text" id="owner_license_state" name="owner_license_state" value="<?php echo $registration->owner_license_state; ?>" size="25" />
			</td>
		  </tr>	
		  <tr valign="baseline">
            <td nowrap align="right">Type: </td>
			<td><input type="radio" id="owner_license_type" name="owner_license_type" value="License" <? echo ($registration->licenseType()=="LICENSE" ? "checked" : "") ?>> License
				<input type="radio" id="owner_license_type" name="owner_license_type" value="ID" <? echo ($registration->licenseType()=="ID" ? "checked" : "") ?>> ID
			</td>				
		  </tr>
          <tr valign="baseline" class="odd">
            <td nowrap colspan="2"><strong>Bicycle Information</strong></td>
		  </tr>		  	
		  <tr valign="baseline">
            <td nowrap align="right">Make: </td>
			<td><input type="text" id="bike_make" name="bike_make" value="<?php echo $registration->bike_make; ?>" size="25" /> <font color="red">*</font>
			<br>ex: Specialized </td>
		  </tr>	
		  <tr valign="baseline" class="odd">
            <td nowrap align="right">Model: </td>
			<td><input type="text" id="bike_make" name="bike_model" value="<?php echo $registration->bike_model; ?>" size="25" /> <font color="red">*</font>
			<br>ex: RockHopper </td>
		  </tr>	
		  <tr valign="baseline">
            <td nowrap align="right">Style: <font color="red">*</font></td>
	    <td>
		<input type="radio" id="bike_style" name="bike_style" value="Mens" <? echo ($registration->bike_style=="Mens" ? "checked" : "") ?>> Men
		<br><input type="radio" id="bike_style" name="bike_style" value="Womens" <? echo ($registration->bike_style=="Womens" ? "checked" : "") ?>> Women
		<br><input type="radio" id="bike_style" name="bike_style" value="Boy" <? echo ($registration->bike_style=="Boy" ? "checked" : "") ?>> Boy
		<br><input type="radio" id="bike_style" name="bike_style" value="Girl" <? echo ($registration->bike_style=="Girl" ? "checked" : "") ?>> Girl
		<br><input type="radio" id="bike_style" name="bike_style" value="Unisex" <? echo ($registration->bike_style=="Unisex" ? "checked" : "") ?>> Unisex
		<br><input type="radio" id="bike_style" name="bike_style" value="Other" <? echo ($_POST['bike_style']=="Other" ? "checked" : "") ?>> Other: <input type="text" name="bike_style_other" value="<?php echo $_POST['bike_style_other']; ?>" size="25" />				
	    </td>	
	</tr>	
	<tr valign="baseline" class="odd">
            <td nowrap align="right">Type: <font color="red">*</font></td>
            <td><input type="radio" name="bike_type" value="Mountain"  <? echo ($registration->bike_type=="Mountain" ? "checked" : "") ?>> Mountain
				<br><input type="radio" id="bike_type" name="bike_type" value="Road" <? echo ($registration->bike_type=="Road" ? "checked" : "") ?>> Road
				<br><input type="radio" id="bike_type" name="bike_type" value="Touring" <? echo ($registration->bike_type=="Touring" ? "checked" : "") ?>> Touring
				<br><input type="radio" id="bike_type" name="bike_type" value="BMX" <? echo ($registration->bike_type=="BMX" ? "checked" : "") ?>> BMX
				<br><input type="radio" id="bike_type" name="bike_type" value="Cruiser" <? echo ($registration->bike_type=="Cruiser" ? "checked" : "") ?>> Cruiser
				<br><input type="radio" id="bike_type" name="bike_type" value="Other" <? echo ($_POST['bike_type']=="Other" ? "checked" : "") ?>> Other: <input type="text" name="bike_type_other" value="<?php echo $_POST['bike_type_other']; ?>" size="25" />				
			</td>
		  </tr>	
		  <tr valign="baseline">
            <td nowrap align="right">Speeds: </td>
			<td>
			<select id="bike_speeds" name="bike_speeds">
				<option value="0">Select One
				<option value="1" <? echo ($registration->bike_speeds=="1" ? "selected" : "") ?> >1
				<option value="2" <? echo ($registration->bike_speeds=="2" ? "selected" : "") ?> >2
				<option value="3" <? echo ($registration->bike_speeds=="3" ? "selected" : "") ?> >3
				<option value="4" <? echo ($registration->bike_speeds=="4" ? "selected" : "") ?> >4
				<option value="5" <? echo ($registration->bike_speeds=="5" ? "selected" : "") ?> >5
				<option value="6" <? echo ($registration->bike_speeds=="6" ? "selected" : "") ?> >6
				<option value="7" <? echo ($registration->bike_speeds=="7" ? "selected" : "") ?> >7
				<option value="8" <? echo ($registration->bike_speeds=="8" ? "selected" : "") ?> >8
				<option value="9" <? echo ($registration->bike_speeds=="9" ? "selected" : "") ?> >9
				<option value="10" <? echo ($registration->bike_speeds=="10" ? "selected" : "") ?> >10
				<option value="11" <? echo ($registration->bike_speeds=="11" ? "selected" : "") ?> >11
				<option value="12" <? echo ($registration->bike_speeds=="12" ? "selected" : "") ?> >12
				<option value="13" <? echo ($registration->bike_speeds=="13" ? "selected" : "") ?> >13
				<option value="14" <? echo ($registration->bike_speeds=="14" ? "selected" : "") ?> >14
				<option value="15" <? echo ($registration->bike_speeds=="15" ? "selected" : "") ?> >15
				<option value="16" <? echo ($registration->bike_speeds=="16" ? "selected" : "") ?> >16
				<option value="17" <? echo ($registration->bike_speeds=="17" ? "selected" : "") ?> >17
				<option value="18" <? echo ($registration->bike_speeds=="18" ? "selected" : "") ?> >18
				<option value="19" <? echo ($registration->bike_speeds=="19" ? "selected" : "") ?> >19
				<option value="20" <? echo ($registration->bike_speeds=="20" ? "selected" : "") ?> >20
				<option value="21" <? echo ($registration->bike_speeds=="21" ? "selected" : "") ?> >21
				<option value="22" <? echo ($registration->bike_speeds=="22" ? "selected" : "") ?> >22
				<option value="23" <? echo ($registration->bike_speeds=="23" ? "selected" : "") ?> >23
				<option value="24" <? echo ($registration->bike_speeds=="24" ? "selected" : "") ?> >24
				<option value="25" <? echo ($registration->bike_speeds=="25" ? "selected" : "") ?> >25
				<option value="26" <? echo ($registration->bike_speeds=="26" ? "selected" : "") ?> >26
				<option value="27" <? echo ($registration->bike_speeds=="27" ? "selected" : "") ?> >27
				<option value="28" <? echo ($registration->bike_speeds=="28" ? "selected" : "") ?> >28
				<option value="29" <? echo ($registration->bike_speeds=="29" ? "selected" : "") ?> >29
				<option value="30" <? echo ($registration->bike_speeds=="30" ? "selected" : "") ?> >30					
			</select> <font color="red">*</font>
			<br>Multiply the number of gears on the cranks by the number of gears on the rear wheel.
			</td>
		  </tr>	
		  <tr valign="baseline" class="odd">
            <td nowrap align="right">Color(s): </td>
			<td><input type="text" id="bike_colors" name="bike_colors" value="<?php echo $registration->bike_colors; ?>" size="25" /> <font color="red">*</font></td>
		  </tr>	
		  <tr valign="baseline">
            <td nowrap align="right">Serial / Frame Number:<br><img src="media/system/images/bicycle_serial_number_locations.JPG" width="200"></td>
			<td><input type="text" id="bike_serial" name="bike_serial" value="<?php echo $registration->bike_serial; ?>" size="25" autocomplete="off"/> <font color="red">*</font>
			<br>Flip the bike upside down, look at bottom bracket shell, clean if necessary.
			<br><img src="media/system/images/bicycle_serial_number.jpg" width="200">
			<br>If you can't find a serial number, you need to go to the SLCPD to get one stamped on your frame.
		</td>
		  </tr>
		  <tr valign="baseline" class="odd">
            <td nowrap align="right"><span class="yb_heading3red">Authorized Password:</span></td>
			<td><input name="password" type="password" id="password" size="32"> <font color="red">*</font>
			<br>The Shop Manager has to do this.</td>
		  </tr>		  
          <tr valign="baseline">
            <td nowrap align="right">&nbsp;</td>
			<td><input type="submit" value="Register Bike"><?=current_ip_address();?></td>
		  </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
<p>&nbsp;</p>

<?php include("include_footer.html"); ?>
