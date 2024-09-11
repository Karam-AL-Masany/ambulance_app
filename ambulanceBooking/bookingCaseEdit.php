<?php
        include "connect/connect.php";
        $id = @$_POST['id'];
        $bookingCase = @$_POST['bookingCase'];


$stmt = "UPDATE `bookings` SET `bookingCase`='$bookingCase' WHERE `id`='$id' ;";
$response = array();
   
  $run = mysqli_query($con,$stmt);   
if($run){
$response["status"] = "success";  
} else {
    $response["status"] = "failed";  
}
echo json_encode($response);       


      ?>
