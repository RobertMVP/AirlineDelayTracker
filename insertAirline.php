<?php

if (isset($_POST['f_submit'])) {

    require_once("conn.php");

    $var_iata = $_POST['f_iata'];
    $var_airline = $_POST['f_airline'];

    $query = "CALL insertAirlines('$var_iata', '$var_airline')";

    try {
        $prepared_stmt = $dbo->prepare($query);
        $result = $prepared_stmt->execute();
    }

    catch(PDOException $ex)
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
  <h1> Airline Delay Tracker</h1>
  <body background="img2.png" style=" background-repeat:no-repeat ;background-size:100% 100%;
		background-attachment: fixed;">

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

<h1> Insert Airline </h1>

    <form method="post">
    	<label class="co" for="id_iata">IATA</label>
    	<input type="text" name="f_iata" id="id_iata">

    	<label class="co" for="id_airline">Airline</label>
    	<input type="text" name="f_airline" id="id_airline">
    	
    	<input type="submit" name="f_submit" value="Submit">
    </form>

    <?php
      if (isset($_POST['f_submit'])) {
        if ($result) {
    ?>
            <h3> Airline data was inserted successfully.</h3>
    <?php 
        } else { 
    ?>
          <h3> Sorry, there was an error. Airline data was not inserted. </h3>
    <?php 
        }
      } 
    ?>


    
  </body>
</html>