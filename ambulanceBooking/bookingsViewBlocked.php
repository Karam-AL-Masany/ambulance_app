<?php
        include "connect/connect.php";

// $id = @$_POST['id'] ;

$stmt = mysqli_query($con,"SELECT bookings.id,bookings.bookingCase,bookings.type,bookings.date,bookings.quantity,bookings.img,bookings.count,users.fullName,users.phone,users.address,users.cnicImg from `bookings`,`users` where bookings.userId = users.id && bookings.bookingActive = 'blocked' ; ");
$data = array();
if(@mysqli_num_rows($stmt) > 0 ){
while($row = mysqli_fetch_array($stmt)){ 
    $data[] =  $row ;
}
 echo json_encode(array("status" => "success" , "data" => $data));
} else {
  echo json_encode(array("status" => "failed"));
} 

  


 



     





      ?>
