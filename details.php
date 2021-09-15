<?php

require_once("conn.php"); // database connection is here

//////Displaying Data/////////////
$id=(int)$_GET['id'];        // Collecting data from query string

$query="CALL getByid(:id)";
try
{
    // Create a prepared statement. Prepared statements are a way to eliminate SQL INJECTION.
    $prepared_stmt = $dbo->prepare($query);
    //bind the value saved in the variable $var_director to the place holder :ph_director
    // Use PDO::PARAM_STR to sanitize user string.
    $prepared_stmt->bindValue(':id', $id, PDO::PARAM_INT);
    // Fetch all the values based on query and save that to variable $result
    $prepared_stmt->execute();
    $result=$prepared_stmt->fetchAll();


}
catch (PDOException $ex)
{ // Error in database processing.
    echo $sql . "<br>" . $error->getMessage(); // HTTP 500 - Internal Server Error
}

?>
<html>
<body background="img3.png" style=" background-repeat:no-repeat ;background-size:100% 100%;
		background-attachment: fixed;">
<!-- Any thing inside the HEAD tags are not visible on page.-->
<head>
    <!-- THe following is the stylesheet file. The CSS file decides look and feel -->
    <link rel="stylesheet" type="text/css" href="pages.css" />
</head>
<!-- Everything inside the BODY tags are visible on page.-->
<body>
<h1> Airline Delay Tracker</h1>
<div id="navbar">
    <ul>
        <li><a href="index.html">Home</a></li>
        <li><a href="searchFlight.php">Search Flights</a></li>
        <li><a href="insertAirport.php">Insert Airports</a></li>
        <li><a href="insertAirline.php">Insert Airline</a></li>
        <li><a href="updateCancellationReason.php">Update Reason</a></li>
        <li><a href="deleteRecord.php" style="color:navajowhite">Delete Record</a></li>

    </ul>
</div>


<!-- This is the start of the form. This form has one text field and one button.
  See the project.css file to note how form is stylized.-->

              <!-- THen create a table like structure. See the project.css how table is stylized. -->
                <!-- Create the first row of table as table head (thead). -->
                   <!-- The top row is table head with four columns named -- ID, Title ... -->
<?php
foreach($result as $row) {?>
        <tr style="background-color: aliceblue">
            <td><?php echo print_r($row);?></td></tr>
    <?php } ?>


</body>
</html>


