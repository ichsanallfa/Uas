<?php
header("Content-Type: application/json");
include "koneksi.php";

$id = $_POST['id'];

$query = mysqli_query($conn, "DELETE FROM riwayat_perawatan WHERE id='$id'");

echo json_encode([
    "status" => $query ? true : false,
    "message" => $query ? "Data dihapus" : mysqli_error($conn)
]);