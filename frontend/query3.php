<?php

$conn = oci_connect('username','password', '//dbserver.engr.scu.edu/db11g');
if($conn) {
  
 // $branchName = $_GET['branchName'];
 // $firstName = $_GET['firstName'];
 // $lastName = $_GET['lastName'];

  $branchName = $_GET['branchName'];;
  $firstName = $_GET['firstName'];
  $lastName = $_GET['lastName'];


  $curs = oci_new_cursor($conn);
  $stid = oci_parse($conn, "begin :r := query_3(:branchName, :firstName, :lastName); end;");
  oci_bind_by_name($stid, ":r", $curs, -1, OCI_B_CURSOR);
  oci_bind_by_name($stid, ":branchName", $branchName);
  oci_bind_by_name($stid, ":firstName", $firstName);
  oci_bind_by_name($stid, ":lastName", $lastName);



  oci_execute($stid);

 oci_execute($curs);  // Execute the REF CURSOR like a normal statement id

  $returnArray['posts'] = array();
  while (($row = oci_fetch_array($curs, OCI_ASSOC+OCI_RETURN_NULLS)) != false) {
	$tempArray = array();
	$tempArray['address'] = $row['ADDRESS'];
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

 
 
 
