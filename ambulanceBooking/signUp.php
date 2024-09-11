<?php
        include "connect/connect.php";

        
 
$cnicNum = @$_POST['cnicNum'];
$email = @$_POST['email'];
$fullName = @$_POST['fullName'];
$phone = @$_POST['phone'];
$pass = @$_POST['pass'];
$address = @$_POST['address'];
$district = @$_POST['district'];
$type = @$_POST['type'];
$cnicImg = uploadImage("cnicImg");


//$cnicNum = 01010;
//$email = "aaa@gmail.com";
//$fullName ="kkkkkkkkkk";
//$phone = "777777777";
//$pass = "123";
//$address = "sawan";
//$district = "shooob";
//$type = "person";



if($cnicImg != "fail"){
  $max = mysqli_query($con,"select id from users");
  for($i = 1 ; $row = mysqli_fetch_array($max)  ; $i++){
       $lastId = $i + 1  ;
  }
  if(empty($lastId)) $lastId = 1 ;
  $lastId .= "";
  
  $stmt = "INSERT into `users` (`id`, `email` ,`cnicNum`,`fullName`,`phone`,`pass` ,`address`,`district`,`type` , `cnicImg`) values ('$lastId', '$email' ,'$cnicNum','$fullName','$phone','$pass','$address' , '$district','$type','$cnicImg') ; ";
  $response = array();
  
    if(!empty($fullName) && !empty($cnicNum) && !empty($pass) && !empty($type)){   
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
