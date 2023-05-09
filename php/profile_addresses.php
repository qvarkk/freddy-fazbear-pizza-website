<div class="addresses">
  <?php
    $counter = 0;
    $address_query = $db->query("SELECT * FROM general.addresses WHERE user_id = ".$_SESSION['user_id']);
    foreach ($address_query as $row) {
      $counter++;
      echo('
      <div class="address">
        <p class="address-header">'.$row['address'].'</p>
        <p class="address-country">'.$row['city'].', '.$row['country'].'</p>
        <button class="details-btn address-details-btn">Details</button>
      </div>
      ');
    }

    if ($counter == 0) {
      echo('<p class="total-para">Total of 0 addresses found...</p>');
    }
  ?>
</div>