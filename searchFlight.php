<?php
// If the all the variables are set when the Submit button is clicked...
if (isset($_POST['field_submit'])) {
    // Refer to conn.php file and open a connection.
    require_once("conn.php");
    // Will get the value typed in the form text field and save into
    $var_airline = $_POST['airline'];
    $var_flight_number = $_POST['flight_number'];
    $var_tail_number=$_POST['tail_number'];
    $var_date=$_POST['date'];
    // Save the query into variable called $query. Note that :ph_director is a place holder
    $query = "SELECT flight_id,date, airline, flight_number, tail_number, scheduled_departure, origin_airport,destination_airport, status 
                FROM flight_main WHERE 1 ";


try
    {
        if($var_airline&&!empty($var_airline)){
            $query.="AND airline='$var_airline' ";
            // print($query);
        }if($var_flight_number&&!empty($var_flight_number)){
          $query.="AND flight_number=$var_flight_number ";
          // print($query);
      }
        if($var_tail_number&&!empty($var_tail_number)){
            $query.="AND tail_number='$var_tail_number' ";

        }
        if($var_date){
            $query.="AND date='$var_date' ";
        }
        $result = $dbo->query($query);

    }
    catch (PDOException $ex)
    { // Error in database processing.
      echo $sql . "<br>" . $error->getMessage(); // HTTP 500 - Internal Server Error
    }
}
?>

<html>
<body background="img2.png" style=" background-repeat:no-repeat ;background-size:100% 100%;
		background-attachment: fixed;">
<!-- Any thing inside the HEAD tags are not visible on page.-->
  <head>
    <!-- THe following is the stylesheet file. The CSS file decides look and feel -->
    <link rel="stylesheet" type="text/css" href="pages.css" />
  </head> 
<!-- Everything inside the BODY tags are visible on page.-->
  <body>
  <h1> Airline Delay Tracker </h1>

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
  <h1> Advanced Search For Flights</h1>

    <!-- This is the start of the form. This form has one text field and one button.
      See the project.css file to note how form is stylized.-->
    <form method="post">
        <label  class="co" for="id_airline">Airline</label>
        <input type="text" name="airline" id = "id_airline">
        <label  class="co" for="id_flight">Flight Number</label>
        <input type="text" name="flight_number" id = "id_flight">
        <label  class="co" for="id_flight">Tail Number</label>
        <input type="text" name="tail_number" id = "id_tail">
        <label  class="co" for="id_flight">Date</label>
        <input type="date" name="date" id = "id_date">
      <!-- The input type is a text field. Note the name and id. The name attribute
        is referred above on line 7. $var_director = $_POST['field_director']; id attribute is referred in label tag above on line 52-->

      <!-- The input type is a submit button. Note the name and value. The value attribute decides what will be dispalyed on Button. In this case the button shows Submit.
      The name attribute is referred  on line 3 and line 61. -->
      <input type="submit" name="field_submit" value="Submit">
    </form>
    
    <?php
      if (isset($_POST['field_submit'])) {
        // If the query executed (result is true) and the row count returned from the query is greater than 0 then...
        if ($result && $result->rowCount() > 0) { ?>
              <!-- first show the header RESULT -->
              <h2>Results</h2>
              <!-- THen create a table like structure. See the project.css how table is stylized. -->
              <table>
                <!-- Create the first row of table as table head (thead). -->
                <thead>
                   <!-- The top row is table head with four columns named -- ID, Title ... -->
                   <tr bgcolor="#f0f8ff">
                       <th>Date</th>
                       <th>Airline</th>
                       <th>Flight Number</th>
                       <th>Tail Number</th>
                       <th>Scheduled Departure</th>
                       <th>From</th>
                       <th>To</th>
                       <th>Status</th>
                       <th></th>

                   </tr>
                </thead>
                 <!-- Create rest of the the body of the table -->
                <tbody color="white">
                   <!-- For each row saved in the $result variable ... -->
                  <?php foreach ($result as $row) { ?>
                    <tr style="background-color: aliceblue">
                        <!-- Print (echo) the value of date in first column of table -->
                        <td><?php echo $row["date"]; ?></td>
                        <!-- Print (echo) the value of title in second column of table -->
                        <td><?php echo $row["airline"]; ?></td>
                        <!-- Print (echo) the value of movieYear in third column of table and so on... -->
                        <td><?php echo $row["flight_number"]; ?></td>
                        <td><?php echo $row["tail_number"]; ?></td>
                        <td><?php echo $row["scheduled_departure"]; ?></td>
                        <td><?php echo $row["origin_airport"]; ?></td>
                        <td><?php echo $row["destination_airport"]; ?></td>
                        <td><?php echo $row["status"]; ?></td>
                        <td><a href="details.php? id=<?php echo $row['flight_id']; ?>">Details</a>
                        </td>

                    <!-- End first row. Note this will repeat for each row in the $result variable-->
                    </tr>

                  <?php } ?>
                  <!-- End table body -->
                </tbody>
                <!-- End table -->
            </table>
            <!-- Button trigger modal -->

        <?php } else { ?>
          <!-- IF query execution resulted in error display the following message-->
          <h3>Sorry, no results found. </h3>
        <?php }
    } ?>


    
  </body>
</html>




