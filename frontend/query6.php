<?php

$conn = oci_connect('username','password', '//dbserver.engr.scu.edu/db11g');
if($conn) {
  
  $propertyID = $_GET['propertyID'];
  $firstName = $_GET['firstName'];
  $lastName = $_GET['lastName'];
  $homePhone = $_GET['homePhone'];
  $workPhone = $_GET['workPhone'];
  $contactFirstName = $_GET['contactFirstName'];
  $contactLastName = $_GET['contactLastName'];
  $contactPhone = $_GET['contactPhone'];
  $startDate = $_GET['startDate'];
  $endDate = $_GET['endDate'];
  $depositAmount = $_GET['deposit'];

//  $startDate = date_create($startDate);
//  $endDate = date_create($endDate);
  
//  $startDate = date_format($startDate, 'Y/m/d');
//  $endDate = date_format($endDate, 'Y/m/d');


  $stid = oci_parse($conn, "begin query_6(:a, :b, :c, :d, :e, :f, :g, :h, :i, :j); end;");
  oci_bind_by_name($stid, ":a", $propertyID);
  oci_bind_by_name($stid, ":b", $firstName);
  oci_bind_by_name($stid, ":c", $lastName);
  oci_bind_by_name($stid, ":d", $homePhone);
  oci_bind_by_name($stid, ":e", $workPhone);
  oci_bind_by_name($stid, ":f", $contactFirstName);
  oci_bind_by_name($stid, ":g", $contactLastName);
  oci_bind_by_name($stid, ":h", $contactPhone);
  oci_bind_by_name($stid, ":i", $startDate);
  oci_bind_by_name($stid, ":j", $endDate);


  if (oci_execute($stid) == true) {
    $returnArray['posts'] = array();
    $tempArray = array();
    $tempArray['status'] = 'Success';
    array_push($returnArray['posts'], $tempArray);
    echo json_encode($returnArray);
  }
  else {
    $returnArray['posts'] = array();
    $tempArray = array();
    $tempArray['status'] = 'Failure';
    array_push($returnArray['posts'], $tempArray);
    echo json_encode($returnArray);
  }



} else {
       $e = oci_error;
       print "<br> connection failed:";
       print htmlentities($e['message']);
       exit;
}
OCILogoff($conn);
?>

 
 
