<?php

$conn = oci_connect('username','password', '//dbserver.engr.scu.edu/db11g');
if($conn) {
  
  $firstName = $_GET['firstName'];
  $lastName = $_GET['lastName'];

  
  $curs = oci_new_cursor($conn);
  $stid = oci_parse($conn, "begin :r := query_7(:firstName, :lastName); end;");
  oci_bind_by_name($stid, ":r", $curs, -1, OCI_B_CURSOR);
  oci_bind_by_name($stid, ":firstName", $firstName);
  oci_bind_by_name($stid, ":lastName", $lastName);


  oci_execute($stid);

 oci_execute($curs);  // Execute the REF CURSOR like a normal statement id

  $returnArray['posts'] = array();
  while (($row = oci_fetch_array($curs, OCI_ASSOC+OCI_RETURN_NULLS)) != false) {
	$tempArray = array();
	$tempArray['leaseID'] = $row['LEASEID'];
	$tempArray['fullName'] = $row['FULLNAME'];
	$tempArray['homePhone'] = $row['HOMEPHONE'];
	$tempArray['workPhone'] = $row['WORKPHONE'];
	$tempArray['contactName'] = $row['CONTACTNAME'];
	$tempArray['contactPhone'] = $row['CONTACTPHONE'];
	$tempArray['startDate'] = $row['STARTDATE'];
	$tempArray['endDate'] = $row['ENDDATE'];
	$tempArray['depositAmount'] = $row['DEPOSITAMOUNT'];
	$tempArray['rentAmount'] = $row['RENTAMOUNT'];
	
	array_push($returnArray['posts'], $tempArray);
  }

   echo json_encode($returnArray);

} else {
       $e = oci_error;
       print "<br> connection failed:";
       print htmlentities($e['message']);
       exit;
}
OCILogoff($conn);
?>

 
 
