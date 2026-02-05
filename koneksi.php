<?php
$conn = mysqli_connect("localhost", "root", "", "db_perawatan_barang");

if (!$conn) {
    http_response_code(500);
    echo json_encode([
        "status" => false,
        "message" => "Koneksi database gagal"
    ]);
    exit;
}
?>