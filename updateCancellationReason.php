<?php

if (isset($_POST['f_submit'])) {

    require_once("conn.php");

    $var_reason = $_POST['f_reason'];
    $var_date = $_POST['f_date'];
    $var_airline=$_POST['f_airline'];
    $var_flight_number = $_POST['f_flight_number'];
    $var_orgin_airport = $_POST['f_origin_airport'];
    $var_destination_airport = $_POST['f_destination_airport'];
    $var_scheduled_departure = $_POST['f_scheduled_departure'];

    $query = "CALL updatecancellationreason('$var_reason', '$var_date','$var_airline',$var_flight_number,'$var_orgin_airport','$var_destination_airport','$var_scheduled_departure')";
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

<h1> Update Cancellation Reason</h1>

<form method="post">
    <label class="co" for="id_reason">New Reason</label>
    <input type="text" name="f_reason" id="id_reason">

    <label class="co" for="id_date">Date</label>
    <input type="date" name="f_date" id="id_date">

    <label class="co" for="id_airline">Airline</label>
    <input type="text" name="f_airline" id="id_airline">

    <label class="co" for="id_flight_number">Flight Number</label>
    <input type="text" name="f_flight_number" id="id_flight_number">

    <label class="co" for="id_origin_airport">Origin Airport</label>
    <input type="text" name="f_origin_airport" id="id_origin_airport">

    <label class="co" for="id_destination_airport">Desitination Airport</label>
    <input type="text" name="f_destination_airport" id="id_destination_airport">

    <label class="co" for="id_scheduled_departure">Schedule Departure</label>
    <input type="time" name="f_scheduled_departure" id="id_scheduled_departure">

    <input type="submit" name="f_submit" value="Submit">
</form>
<?php
if (isset($_POST['f_submit'])) {
    if ($result) {
        ?>
        <h3> Cancellation reason is updated successfully.</h3>
        <?php
    } else {
        ?>
        <h3> Sorry, there was an error. Cancellation reason data was not updated. </h3>
        <?php
    }
}
?>



</body>
</html>