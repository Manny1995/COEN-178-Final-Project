<?php

$conn = oci_connect('username','password', '');
if($conn) {
  $p = $_GET['branchNo'];
 
  $curs = oci_new_cursor($conn);
  $stid = oci_parse($conn, "begin :r := query_1(:p); end;");
  oci_bind_by_name($stid, ":r", $curs, -1, OCI_B_CURSOR);
  oci_bind_by_name($stid, ":p", $p);


  oci_execute($stid);

 oci_execute($curs);  // Execute the REF CURSOR like a normal statement id

  $returnArray['posts'] = array();
  while (($row = oci_fetch_array($curs, OCI_ASSOC+OCI_RETURN_NULLS)) != false) {
	$tempArray = array();
	$tempArray['address'] = $row['ADDRESS'];
	$tempArray['fullName'] = $row['FULLNAME'];
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

 
