 
<?php

$conn = oci_connect('username','password', '//dbserver.engr.scu.edu/db11g');
if($conn) {
  
 // $branchName = $_GET['branchName'];
 // $firstName = $_GET['firstName'];
 // $lastName = $_GET['lastName'];

  $city = $_GET['city'];
  $rooms = $_GET['rooms'];
  $lowest = $_GET['lowest'];
  $highest = $_GET['highest'];


  $curs = oci_new_cursor($conn);
  $stid = oci_parse($conn, "begin :r := query_4(:city, :rooms, :lowest, :highest); end;");
  oci_bind_by_name($stid, ":r", $curs, -1, OCI_B_CURSOR);
  oci_bind_by_name($stid, ":city", $city);
  oci_bind_by_name($stid, ":rooms", $rooms);
  oci_bind_by_name($stid, ":lowest", $lowest);
  oci_bind_by_name($stid, ":highest", $highest);



  oci_execute($stid);

 oci_execute($curs);  // Execute the REF CURSOR like a normal statement id

  $returnArray['posts'] = array();
  while (($row = oci_fetch_array($curs, OCI_ASSOC+OCI_RETURN_NULLS)) != false) {
	$tempArray = array();
	$tempArray['address'] = $row['ADDRESS'];
	$tempArray['rooms'] = $row['ROOMS'];
	$tempArray['rent'] = $row['RENT'];

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

 
 
 
