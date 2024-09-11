    <?php
        include "connect/connect.php";
$email = @$_POST['email'];
$password = @$_POST['pass'];


$stmt = mysqli_query($con,"SELECT * from `users` WHERE `email` ='$email' AND `pass` = '$password' ; ");
$response = array();

if(!empty($email) && !empty($password)){

 if(@mysqli_num_rows($stmt) > 0 ){
    while($row = mysqli_fetch_array($stmt)){
      $response["status"] = "success";
      $response["data"] = $row ;
    }  
  } else {
      $response["status"] = "failed";  
    } 
    echo json_encode($response);
 }



     





      ?>
