<?php
header("Content-Type: application/json");
include "koneksi.php";

if (!isset($_GET['keyword'])) {
    echo json_encode([]);
    exit;
}

$keyword = mysqli_real_escape_string($conn, $_GET['keyword']);

$query = "
SELECT * FROM riwayat_perawatan
WHERE nama_barang LIKE '%$keyword%'
   OR jenis_barang LIKE '%$keyword%'
   OR jenis_perawatan LIKE '%$keyword%'
ORDER BY id DESC
LIMIT 20
";

$result = mysqli_query($conn, $query);

if (!$result) {
    echo json_encode([
        "status" => false,
        "message" => mysqli_error($conn)
    ]);
    exit;
}

$data = [];
while ($row = mysqli_fetch_assoc($result)) {
    $data[] = $row;
}

echo json_encode($data);