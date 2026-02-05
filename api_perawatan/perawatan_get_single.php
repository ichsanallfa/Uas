<?php
include "koneksi.php";

$id = $_GET['id'];

$query = mysqli_query(
    $conn,
    "SELECT * FROM riwayat_perawatan WHERE id = '$id' LIMIT 1"
);

if (!$query) {
    echo json_encode([
        "status" => false,
        "message" => "Query gagal",
        "error" => mysqli_error($conn)
    ]);
    exit;
}

$data = mysqli_fetch_assoc($query);

if ($data) {
    echo json_encode([
        "status" => true,
        "data" => $data
    ]);
} else {
    echo json_encode([
        "status" => false,
        "message" => "Data tidak ditemukan"
    ]);
}
?>