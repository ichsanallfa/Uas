import 'package:flutter/material.dart';
import '../models/perawatan_model.dart';
import '../services/perawatan_service.dart';

class PerawatanEditPage extends StatefulWidget {
  final PerawatanModel data;
  const PerawatanEditPage({super.key, required this.data});

  @override
  State<PerawatanEditPage> createState() => _PerawatanEditPageState();
}

class _PerawatanEditPageState extends State<PerawatanEditPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController namaController;
  late TextEditingController jenisBarangController;
  late TextEditingController jenisPerawatanController;
  late TextEditingController tanggalController;
  late TextEditingController biayaController;
  late TextEditingController hasilController;
  late TextEditingController statusController;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.data.namaBarang);
    jenisBarangController = TextEditingController(text: widget.data.jenisBarang);
    jenisPerawatanController = TextEditingController(text: widget.data.jenisPerawatan);
    tanggalController = TextEditingController(text: widget.data.tanggalPerawatan);
    biayaController = TextEditingController(text: widget.data.biayaPerawatan);
    hasilController = TextEditingController(text: widget.data.hasilPerawatan);
    statusController = TextEditingController(text: widget.data.statusBarang);
  }

  Future<void> updateData() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    final success = await PerawatanService.update({
      "id": widget.data.id,
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
        const SnackBar(content: Text('Gagal update data')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Perawatan')),
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
                onPressed: isLoading ? null : updateData,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildField(TextEditingController c, String label, {bool isNumber=false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: c,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        validator: (v) => v==null || v.isEmpty ? '$label wajib diisi' : null,
        decoration: const InputDecoration(border: OutlineInputBorder(),),
      ),
    );
  }
}