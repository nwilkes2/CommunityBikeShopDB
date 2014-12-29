<?php 
require_once('Connections/YBDB.php'); 
require_once('Connections/database_functions.php');
require('media/fpdf/fpdf.php');

$registration = new BicycleRegistration();

if (!$registration->exists($_GET['registration_number'])) {
	echo "Record ".$_GET['registration_number'].' not found.';
} else {
	$registration->load($_GET['registration_number']);
	//	print_r($registration);

	$cell_height = 13;
	$cell_width = 40;
	$cell_width_full = 0;
	$font_size = 13;

	$pdf=new FPDF();
	$pdf->AddPage();

	$pdf->SetFont('Arial','B',15);
	$pdf->Cell($cell_width_full,$cell_height,'Bike Registration Information',0,1,'C');
	$pdf->SetFont('Arial', '', $font_size);
	$pdf->Cell($cell_width_full,$cell_height,'Case Number __________________________',0,1,'R');
	$pdf->Cell(50,$cell_height,"Registration Number T");
	$pdf->SetFont('','U');
	$pdf->Cell($cell_width_full,$cell_height,$registration->registration_number,0,1);
	$pdf->SetFont('');
	$pdf->SetFont('Arial','B',$font_size);
	$pdf->Cell($cell_width_full,$cell_height,"Owner's Information",0,1);
	$pdf->SetFont('Arial','',$font_size);
	$pdf->Cell(45,$cell_height,'First:',0,0,'R');
	$pdf->SetFont('','U');
	$pdf->Cell(30,$cell_height,$registration->owner_first_name);
	$pdf->SetFont('');
	$pdf->Cell(20,$cell_height,'Middle:',0,0,'R');
	$pdf->SetFont('','U');
	$pdf->Cell(20,$cell_height,$registration->owner_middle_name);
	$pdf->SetFont('');
	$pdf->Cell(20,$cell_height,'Last:',0,0,'R');
	$pdf->SetFont('','U');
	$pdf->Cell(30,$cell_height,$registration->owner_last_name,0,1);
	$pdf->SetFont('');
	$pdf->Cell(45,$cell_height,'Address:',0,0,'R');
	$pdf->SetFont('','U');
	$pdf->Cell($cell_width,$cell_height,$registration->owner_address,0,1);
	$pdf->SetFont('');
	$pdf->Cell(45,$cell_height,'City:',0,0,'R');
	$pdf->SetFont('','U');
	$pdf->Cell($cell_width,$cell_height,$registration->owner_city);
	$pdf->SetFont('');
	$pdf->Cell($cell_width,$cell_height,'Zip:',0,0,'R');
	$pdf->SetFont('','U');
	$pdf->Cell($cell_width,$cell_height,$registration->owner_zip,0,1);
	$pdf->SetFont('');
	$pdf->Cell(45,$cell_height,'Home Phone:',0,0,'R');
	$pdf->SetFont('','U');
	$pdf->Cell($cell_width,$cell_height,$registration->owner_phone_home);
        $pdf->SetFont('');
        $pdf->Cell($cell_width,$cell_height,'Date of birth:',0,0,'R');
        $pdf->SetFont('','U');
        $pdf->Cell($cell_width,$cell_height,date('m-d-Y',strtotime($registration->owner_DOB)),0,1);
        $pdf->SetFont('');
        $pdf->Cell(45,$cell_height,'Cell Phone:',0,0,'R');
        $pdf->SetFont('','U');
        $pdf->Cell($cell_width,$cell_height,$registration->owner_phone_cell);
        $pdf->SetFont('');
        $pdf->Cell(45,$cell_height,'Female:',0,0,'R');
        $pdf->SetFont('','U');
        $pdf->Cell($cell_width,$cell_height,($registration->owner_is_female ? 'X' : '_'),0,1);
        $pdf->SetFont('');
	$pdf->Cell(45,$cell_height,'Work Phone:',0,0,'R');
        $pdf->SetFont('','U');
        $pdf->Cell($cell_width,$cell_height,$registration->owner_phone_work);
        $pdf->SetFont('');
        $pdf->Cell(45,$cell_height,'Male:',0,0,'R');
        $pdf->SetFont('','U');
        $pdf->Cell($cell_width,$cell_height,($registration->owner_is_male ? 'X' : '_'),0,1);
	$pdf->SetFont('');
	$pdf->Cell(45,$cell_height,'Drivers License or ID:',0,0,'R');
	$pdf->SetFont('','U');
	$pdf->Cell(15,$cell_height,$registration->owner_license_id);
	$pdf->SetFont('');
	$pdf->Cell($cell_width,$cell_height,'State',0,0,'R');
	$pdf->SetFont('','U');
	$pdf->Cell(20,$cell_height,$registration->owner_license_state);
	$pdf->SetFont('');
	$pdf->Cell(15,$cell_height,'License',0,0,'R');
	$pdf->SetFont('','U');
	$pdf->Cell(5,$cell_height,($registration->owner_is_license ? 'X' : '_'));
	$pdf->SetFont('');
	$pdf->Cell(10,$cell_height,'ID',0,0,'R');
	$pdf->SetFont('','U');
	$pdf->Cell(5,$cell_height,($registration->owner_is_id ? 'X' : '_'),0,1);
        $pdf->SetFont('');
        $pdf->Cell(45,$cell_height,'Email:',0,0,'R');
        $pdf->SetFont('','U');
        $pdf->Cell($cell_width,$cell_height,$registration->owner_email,0,1);
	$pdf->SetFont('');

	$pdf->Cell($cell_width_full,15,'',0,1);

	$pdf->Cell(45,$cell_height,'Make:',0,0,'R');
	$pdf->SetFont('','U');
	$pdf->Cell($cell_width_full,$cell_height,$registration->bike_make,0,1);
	$pdf->SetFont('');
	$pdf->Cell(45,$cell_height,'Model:',0,0,'R');
	$pdf->SetFont('','U');
	$pdf->Cell($cell_width_full,$cell_height,$registration->bike_model,0,1);
	$pdf->SetFont('');
	$pdf->Cell(45,$cell_height,'Style:',0,0,'R');
	$pdf->SetFont('','U');
	$pdf->Cell($cell_width,$cell_height,$registration->bike_style);
	$pdf->SetFont('');
	$pdf->Cell($cell_width,$cell_height,'Type:',0,0,'R');
	$pdf->SetFont('','U');
	$pdf->Cell($cell_width,$cell_height,$registration->bike_type,0,1);
	$pdf->SetFont('');
	$pdf->Cell(45,$cell_height,'Speeds:',0,0,'R');
	$pdf->SetFont('','U');
	$pdf->Cell($cell_width,$cell_height,$registration->bike_speeds);
	$pdf->SetFont('');
	$pdf->Cell($cell_width,$cell_height,'Color(s):',0,0,'R');
	$pdf->SetFont('','U');
	$pdf->Cell($cell_width,$cell_height,$registration->bike_colors,0,1);
	$pdf->SetFont('');
	$pdf->Cell(45,$cell_height,'Serial/Frame #:',0,0,'R');
	$pdf->SetFont('','U');
	$pdf->Cell($cell_width_full,$cell_height,$registration->bike_serial,0,1);
	$pdf->SetFont('');
	$pdf->Cell($cell_width_full,$cell_height,'NCIC check done:  Yes __ No __                    County Check done: Yes __ No __',0,1,'C');

	// $pdf->Image('http://www.slcbikecollective.org/templates/ja_sanidineii_light/images/logo.png',10,8,33);

	$filepath = $_SERVER['DOCUMENT_ROOT']."/tmp/";
	$filename = $registration->registration_number.".pdf";
	$result = $pdf->Output($filepath.$filename,'F');

	$to = $police_email; //define the receiver of the email
	$subject = "Bike Registration Number ".$registration->registration_number; //define the subject of the email
	$body = "This registration was generated by the $shop_name.";

	$sendit = new AttachmentEmail($police_email, $subject, $body, $filepath.$filename);
	if ($sendit -> mail())
	{
		header( 'Location: bicycle_registration_success.php' );
	} else {
		echo "Database record saved, Email failed.";
	}
	
}

?>


