
    <?php

$host = "localhost";
$user = "root";
$pass = "";
$db = "ambulancebooking";
$con = @mysqli_connect($host, $user, $pass, $db);

if (!$con) {
    echo json_encode ("failed connected");
} 


      ?>
