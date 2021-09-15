<?php

if (isset($_POST['f_submit'])) {

    require_once("conn.php");

    $var_iata = $_POST['f_iata'];
    $var_airport = $_POST['f_airport'];
    $var_city=$_POST['f_city'];
    $var_state = $_POST['f_state'];
    $var_country = $_POST['f_country'];
    $var_latitude = $_POST['f_latitude'];
    $var_longitude = $_POST['f_longitude'];

    $query = "CALL insertAirports('$var_iata', '$var_airport','$var_city','$var_state','$var_country','$var_latitude','$var_longitude')";

    try
    {
        $prepared_stmt = $dbo->prepare($query);
        $result = $prepared_stmt->execute();
    }
    catch (PDOException $ex)
    { // Error in database processing.
        echo $sql . "<br>" . $error->getMessage(); // HTTP 500 - Internal Server Error
    }
}

?>

<html>

<head>
    <!-- THe following is the stylesheet file. The CSS file decides look and feel -->
    <link rel="stylesheet" type="text/css" href="pages.css" />
</head>

<body background="img2.png" style=" background-repeat:no-repeat ;background-size:100% 100%;
		background-attachment: fixed;">
<h1> Airline Delay Tracker</h1>
<div id="navbar">
    <ul>
        <li><a href="index.html" style="color:navajowhite">Home</a></li>
        <li><a href="searchFlight.php" style="color:navajowhite">Search Flights</a></li>
        <li><a href="insertAirport.php" style="color:navajowhite">Insert Airports</a></li>
        <li><a href="insertAirline.php" style="color:navajowhite">Insert Airline</a></li>
        <li><a href="updateCancellationReason.php" style="color:navajowhite">Update Reason</a></li>
        <li><a href="deleteRecord.php" style="color:navajowhite">Delete Record</a></li>

    </ul>
</div>

<h1> Insert Airport </h1>

<form method="post">
    <label class="co" for="id_iata">IATA</label>
    <input type="text" name="f_iata" id="id_iata">

    <label class="co" for="id_airport">Airport Name</label>
    <input type="text" name="f_airport" id="id_airport">

    <label class="co" for="id_city">City</label>
    <input type="text" name="f_city" id="id_city">

    <label class="co" for="id_state">State</label>
    <input type="text" name="f_state" id="id_state">

    <label class="co" for="id_country">Country</label>
    <input type="text" name="f_country" id="id_country">

    <label class="co" for="id_latitude">latitude</label>
    <input type="text" name="f_latitude" id="id_latitude">

    <label class="co" for="id_longitude">longitude</label>
    <input type="text" name="f_longitude" id="id_longitude">

    <input type="submit" name="f_submit" value="Submit">
</form>
<?php
if (isset($_POST['f_submit'])) {
    if ($result) {
        ?>
        <h3> Airport data was inserted successfully.</h3>
        <?php
    } else {
        ?>
        <h3> Sorry, there was an error. Airport data was not inserted. </h3>
        <?php
    }
}
?>



</body>
</html>