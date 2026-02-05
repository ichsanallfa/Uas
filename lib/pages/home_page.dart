import 'package:flutter/material.dart';
import 'perawatan_list_page.dart';
import 'perawatan_form_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('MANTRA'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            const Text(
              'Selamat Datang',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Kelola riwayat perawatan barang dengan mudah',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  buildMenuCard(
                    icon: Icons.list_alt,
                    title: 'Data Perawatan',
                    color: Colors.blue,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PerawatanListPage(),
                        ),
                      );
                    },
                  ),
                  buildMenuCard(
                    icon: Icons.add_circle_outline,
                    title: 'Tambah Data',
                    color: Colors.green,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const PerawatanFormPage(),
                        ),
                      );
                    },
                  ),
                  buildMenuCard(
                    icon: Icons.info_outline,
                    title: 'Tentang Aplikasi',
                    color: Colors.orange,
                    onTap: () {
                      showAboutDialog(
                        context: context,
                        applicationName: 'MANTRA',
                        applicationVersion: '1.0.0',
                        children: const [
                          Text(
                            'Aplikasi manajemen riwayat perawatan barang berbasis Flutter dan Web Service PHP.',
                          ),
                        ],
                      );
                    },
                  ),
                  buildMenuCard(
                    icon: Icons.logout,
                    title: 'Keluar',
                    color: Colors.red,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildMenuCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: color.withOpacity(0.15),
              child: Icon(icon, size: 32, color: color),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}