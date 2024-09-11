<?php
        include "connect/connect.php";
        $id = @$_POST['id'];
        $bookingActive = @$_POST['bookingActive'];


$stmt = "UPDATE `bookings` SET `bookingActive`='$bookingActive' WHERE `id`='$id' ;";
$response = array();
   
  $run = mysqli_query($con,$stmt);   
if($run){
$response["status"] = "success";  
} else {
    $response["status"] = "failed";  
}
echo json_encode($response);       


      ?>
