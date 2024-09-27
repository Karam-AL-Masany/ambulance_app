<?php
        include "connect/connect.php";

        
 
$type = @$_POST['type'];
$quantity = @$_POST['quantity'];
$count = @$_POST['count'];
$userId = @$_POST['userId'];
$date = @$_POST['date'];
$bookingCase = @$_POST['bookingCase'];
$bookingActive = @$_POST['bookingActive'];
$img = uploadImage("cnicImg");

 if($img != "fail"){
  $max = mysqli_query($con,"select id from bookings");
  for($i = 1 ; $row = mysqli_fetch_array($max)  ; $i++){
       $lastId = $i + 1  ;
  }
  if(empty($lastId)) $lastId = 1 ;
  $lastId .= "";


  $stmt = "INSERT into `bookings` (`id`,`type`,`quantity`,`count`,`img`,`date`,`userId`,`bookingCase`,`bookingActive`) values 
                              ('$lastId','$type','$quantity','$count','$img','$date','$userId','$bookingCase','$bookingActive'); ";
  $response = array();
  
    if(!empty($type) && !empty($userId)){   
    $run = mysqli_query($con,$stmt);   
  if($run){
  $response["status"] = "success";  
  } else {
      $response["status"] = "failed";  
     }
  } 
} else {
    $response["status"] = "failed";  
 }    

echo json_encode($response);  

function uploadImage($requestName){
  global $error ;

  $name = rand(1000 , 10000) . @$_FILES[$requestName]['name'];
  $tmp =  @$_FILES[$requestName]['tmp_name'];
  $size =  @$_FILES[$requestName]['size'];

  $type = substr($name ,strpos($name,'.')+1);
  $type = strtolower($type);
  $allowType = array("jpg","jpeg","png","gif");

  if(!empty($name) && !in_array($type,$allowType)){    
      $error[] = "type error" ;
  }
  if($size/1024/1204 > 5){
      $error[] = "size error" ;
  }

      if(empty($error) && !empty($name)){
      move_uploaded_file($tmp , "img/".$name);
      return $name ;
      //echo "upload done " ;
      //header("refresh:3;url = upload.php");
      } else {
          return "fail" ;
          // foreach($error as $data){
          // echo $data . "<br>";
          // }
      }    
}


      ?>
