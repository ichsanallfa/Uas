<?php
header("Content-Type: application/json");
include "koneksi.php";

$nama_barang       = $_POST['nama_barang'] ?? '';
$jenis_barang      = $_POST['jenis_barang'] ?? '';
$jenis_perawatan   = $_POST['jenis_perawatan'] ?? '';
$tanggal_perawatan = $_POST['tanggal_perawatan'] ?? '';
$biaya_perawatan   = $_POST['biaya_perawatan'] ?? '';
$hasil_perawatan   = $_POST['hasil_perawatan'] ?? '';
$status_barang     = $_POST['status_barang'] ?? '';

$query = mysqli_query($conn, "
    INSERT INTO riwayat_perawatan
    (nama_barang, jenis_barang, jenis_perawatan, tanggal_perawatan, biaya_perawatan, hasil_perawatan, status_barang)
    VALUES
    ('$nama_barang', '$jenis_barang', '$jenis_perawatan', '$tanggal_perawatan', '$biaya_perawatan', '$hasil_perawatan', '$status_barang')
");

if ($query) {
    echo json_encode([
        "status" => true,
        "message" => "Data berhasil ditambahkan"
    ]);
} else {
    echo json_encode([
        "status" => false,
        "message" => mysqli_error($conn)
    ]);
}