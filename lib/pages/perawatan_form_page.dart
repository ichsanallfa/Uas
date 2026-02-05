import 'package:flutter/material.dart';
import '../services/perawatan_service.dart';

class PerawatanFormPage extends StatefulWidget {
  const PerawatanFormPage({super.key});

  @override
  State<PerawatanFormPage> createState() => _PerawatanFormPageState();
}

class _PerawatanFormPageState extends State<PerawatanFormPage> {
  final _formKey = GlobalKey<FormState>();

  final namaController = TextEditingController();
  final jenisBarangController = TextEditingController();
  final jenisPerawatanController = TextEditingController();
  final tanggalController = TextEditingController();
  final biayaController = TextEditingController();
  final hasilController = TextEditingController();
  final statusController = TextEditingController();

  bool isLoading = false;

  Future<void> simpanData() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    final success = await PerawatanService.create({
      "nama_barang": namaController.text,
      "jenis_barang": jenisBarangController.text,
      "jenis_perawatan": jenisPerawatanController.text,
      "tanggal_perawatan": tanggalController.text,
      "biaya_perawatan": biayaController.text,
      "hasil_perawatan": hasilController.text,
      "status_barang": statusController.text,
    });

    setState(() => isLoading = false);

    if (success) {
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal menyimpan data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Perawatan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              buildField(namaController, 'Nama Barang'),
              buildField(jenisBarangController, 'Jenis Barang'),
              buildField(jenisPerawatanController, 'Jenis Perawatan'),
              buildField(tanggalController, 'Tanggal (YYYY-MM-DD)'),
              buildField(biayaController, 'Biaya', isNumber: true),
              buildField(hasilController, 'Hasil Perawatan'),
              buildField(statusController, 'Status Barang'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : simpanData,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildField(
      TextEditingController controller,
      String label, {
        bool isNumber = false,
      }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        keyboardType:
        isNumber ? TextInputType.number : TextInputType.text,
        validator: (value) =>
        value == null || value.isEmpty ? '$label wajib diisi' : null,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}