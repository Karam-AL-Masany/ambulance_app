<?php
        include "connect/connect.php";

$id = @$_POST['id'] ;

$stmt = mysqli_query($con,"SELECT * from `users` where `id` = '$id' ; ");
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
