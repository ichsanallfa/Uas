import 'package:flutter/material.dart';
import '../models/perawatan_model.dart';
import '../services/perawatan_service.dart';
import 'perawatan_form_page.dart';
import 'perawatan_edit_page.dart';

class PerawatanListPage extends StatefulWidget {
  const PerawatanListPage({super.key});

  @override
  State<PerawatanListPage> createState() => _PerawatanListPageState();
}

class _PerawatanListPageState extends State<PerawatanListPage> {
  List<PerawatanModel> listData = [];
  bool isLoading = true;

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // ================= LOAD ALL DATA =================
  Future<void> loadData() async {
    setState(() {
      isLoading = true;
    });

    final data = await PerawatanService.getAll();

    setState(() {
      listData = data;
      isLoading = false;
    });
  }

  // ================= SEARCH DATA =================
  Future<void> searchData() async {
    if (searchController.text.isEmpty) {
      loadData();
      return;
    }

    setState(() => isLoading = true);

    final data = await PerawatanService.search(
      searchController.text,
    );

    setState(() {
      listData = data;
      isLoading = false;
    });
  }

  // ================= DELETE DATA =================
  Future<void> deleteData(String id) async {
    final success = await PerawatanService.delete(id);

    if (success) {
      loadData();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data berhasil dihapus')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Perawatan Barang'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PerawatanFormPage(),
                ),
              );
              if (result == true) {
                loadData();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: loadData,
          ),
        ],
      ),

      // ================= BODY =================
      body: Column(
        children: [
          // 🔍 SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Cari nama / jenis / perawatan',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    searchController.clear();
                    loadData();
                  },
                ),
                border: const OutlineInputBorder(),
              ),
              onSubmitted: (_) => searchData(),
            ),
          ),

          // 📋 LIST DATA
          Expanded(
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : listData.isEmpty
                ? const Center(
              child: Text('Data tidak ditemukan'),
            )
                : ListView.builder(
              itemCount: listData.length,
              itemBuilder: (context, index) {
                final item = listData[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              PerawatanEditPage(data: item),
                        ),
                      );
                      if (result == true) {
                        loadData();
                      }
                    },
                    title: Text(item.namaBarang),
                    subtitle: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text('Jenis: ${item.jenisBarang}'),
                        Text(
                            'Perawatan: ${item.jenisPerawatan}'),
                        Text(
                            'Status: ${item.statusBarang}'),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete,
                          color: Colors.red),
                      onPressed: () {
                        deleteData(item.id);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}