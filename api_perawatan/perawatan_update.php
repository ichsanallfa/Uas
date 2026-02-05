<?php
header("Content-Type: application/json");
include "koneksi.php";

$id                = $_POST['id'];
$nama_barang       = $_POST['nama_barang'];
$jenis_barang      = $_POST['jenis_barang'];
$jenis_perawatan   = $_POST['jenis_perawatan'];
$tanggal_perawatan = $_POST['tanggal_perawatan'];
$biaya_perawatan   = $_POST['biaya_perawatan'];
$hasil_perawatan   = $_POST['hasil_perawatan'];
$status_barang     = $_POST['status_barang'];

$query = mysqli_query($conn, "
    UPDATE riwayat_perawatan SET
        nama_barang='$nama_barang',
        jenis_barang='$jenis_barang',
        jenis_perawatan='$jenis_perawatan',
        tanggal_perawatan='$tanggal_perawatan',
        biaya_perawatan='$biaya_perawatan',
        hasil_perawatan='$hasil_perawatan',
        status_barang='$status_barang'
    WHERE id='$id'
");

echo json_encode([
    "status" => $query ? true : false,
    "message" => $query ? "Berhasil update" : mysqli_error($conn)
]);