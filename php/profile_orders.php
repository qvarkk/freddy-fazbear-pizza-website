<div class="orders">
  <?php
  $counter = 0;
    $orders_query = $db->query("SELECT * FROM general.orders WHERE user_id = ".$_SESSION['user_id']);
    foreach ($orders_query as $row) {
      $counter++;
      echo('
        <div class="order">
          <p class="order-price">$'.$row['price'].'</p>
          <p class="order-header">Order №'.$row['id'].'</p>
          <p class="order-time">'.substr($row['time'], 0, 19).'</p>
          <button class="details-btn orders-details-btn">Details</button>
        </div>
      ');
    }

    if ($counter == 0) {
      echo('<p class="total-para">Total of 0 orders found...</p>');
    }
  ?>
</div>