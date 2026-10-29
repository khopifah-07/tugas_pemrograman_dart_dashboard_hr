import 'package:flutter/material.dart';

class DashboardHR extends StatelessWidget {
  final VoidCallback? onToggleTheme;
  final bool isDarkMode;

  const DashboardHR({
    super.key,
    this.onToggleTheme,
    this.isDarkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth >= 600;
        return _buildDashboard(context, isTablet);
      },
    );
  }

  Widget _buildDashboard(BuildContext context, bool isTablet) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // 1. Logo Perusahaan di Kiri (Memakai Foto Aset)
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                'assets/images/Screenshot 2026-10-29 221543.png',
                width: 32,
                height: 32,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.business, size: 32),
              ),
            ),
            const SizedBox(width: 8),
            const Flexible(
              child: Text(
                'PT Maju Bersama',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            onPressed: onToggleTheme,
            tooltip: 'Ganti Tema',
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {},
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          // 2. Foto Profil Admin di Kanan (Memakai Foto Aset)
          const CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage('assets/images/Screenshot 2026-10-29 221543.png'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Sapaan
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [colors.primary, colors.tertiary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                const Positioned(
                  left: 20,
                  top: 20,
                  bottom: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Selamat Pagi, Admin!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Senin, 7 Oktober 2024',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 20,
                  bottom: 20,
                  child: Icon(
                    Icons.waving_hand,
                    color: Colors.white.withValues(alpha: 0.5),
                    size: 64,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Grid Statistik Responsif
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: isTablet ? 4 : 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: isTablet ? 1.4 : 1.3,
              children: [
                _kartuStat('248', 'Karyawan', Icons.people, colors.primary),
                _kartuStat('95%', 'Hadir', Icons.check_circle, colors.secondary),
                _kartuStat('12', 'Cuti', Icons.beach_access, colors.tertiary),
                _kartuStat('3', 'Rekrut', Icons.person_add, colors.error),
              ],
            ),
            const SizedBox(height: 24),

            // TUGAS 3: Bar Chart Kehadiran per Divisi
            Text(
              'Kehadiran per Divisi',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.withValues(alpha: 0.2)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildBarDivisi('Engineering', 92, colors.primary),
                    const SizedBox(height: 12),
                    _buildBarDivisi('Sales', 85, colors.secondary),
                    const SizedBox(height: 12),
                    _buildBarDivisi('HR', 97, colors.tertiary),
                    const SizedBox(height: 12),
                    _buildBarDivisi('Finance', 90, colors.error),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Judul Seksi Aktivitas Terkini
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    'Aktivitas Terkini',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Lihat Semua'),
                ),
              ],
            ),

            // Kartu Aktivitas
            ...List.generate(
              _aktivitas.length,
              (i) => _kartuAktivitas(_aktivitas[i]),
            ),
          ],
        ),
      ),
    );
  }

  // Helper Widget untuk Bar Chart Horizontal
  Widget _buildBarDivisi(String divisi, int persen, Color warna) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              divisi,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
            ),
            Text(
              '$persen%',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: warna,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Container(
          height: 10,
          width: double.infinity,
          decoration: BoxDecoration(
            color: warna.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Expanded(
                flex: persen,
                child: Container(
                  decoration: BoxDecoration(
                    color: warna,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              Expanded(
                flex: 100 - persen,
                child: const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _kartuStat(String nilai, String label, IconData icon, Color warna) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: warna.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: warna.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: warna, size: 28),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nilai,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: warna,
                ),
              ),
              Text(
                label,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static const _aktivitas = [
    (
      nama: 'Budi Santoso',
      aksi: 'Mengajukan cuti',
      waktu: '09:14',
      icon: Icons.beach_access,
      warna: Colors.orange
    ),
    (
      nama: 'Citra Dewi',
      aksi: 'Check-in absensi',
      waktu: '08:02',
      icon: Icons.check_circle,
      warna: Colors.green
    ),
    (
      nama: 'Eko Wahyudi',
      aksi: 'Upload kontrak baru',
      waktu: '07:45',
      icon: Icons.description,
      warna: Colors.blue
    ),
  ];

  Widget _kartuAktivitas(
      ({String nama, String aksi, String waktu, IconData icon, MaterialColor warna}) d) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: d.warna.withValues(alpha: 0.15),
          child: Icon(d.icon, color: d.warna, size: 20),
        ),
        title: Text(d.nama, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(d.aksi),
        trailing: Text(
          d.waktu,
          style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
        ),
      ),
    );
  }
}