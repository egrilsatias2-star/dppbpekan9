import 'package:flutter/material.dart';

void main() {
  runApp(const LayananWargaApp());
}

class LayananWargaApp extends StatelessWidget {
  const LayananWargaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Layanan Warga Kelurahan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2457A6),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F8FC),
      ),
      home: const BerandaLayananPage(),
    );
  }
}

class JenisLayanan {
  const JenisLayanan({
    required this.id,
    required this.nama,
    required this.keterangan,
    required this.persyaratan,
    required this.ikon,
    required this.warna,
  });

  final String id;
  final String nama;
  final String keterangan;
  final List<String> persyaratan;
  final IconData ikon;
  final Color warna;
}

class Pengajuan {
  const Pengajuan({
    required this.nomor,
    required this.namaPemohon,
    required this.namaLayanan,
    required this.tanggal,
    required this.catatan,
  });

  final String nomor;
  final String namaPemohon;
  final String namaLayanan;
  final DateTime tanggal;
  final String catatan;
}

String formatTanggal(DateTime tanggal) {
  final hari = tanggal.day.toString().padLeft(2, '0');
  final bulan = tanggal.month.toString().padLeft(2, '0');
  return '$hari/$bulan/${tanggal.year}';
}

class BerandaLayananPage extends StatefulWidget {
  const BerandaLayananPage({super.key});

  @override
  State<BerandaLayananPage> createState() => _BerandaLayananPageState();
}

class _BerandaLayananPageState extends State<BerandaLayananPage> {
  final List<JenisLayanan> _layanan = const [
    JenisLayanan(
      id: 'domisili',
      nama: 'Surat Pengantar Domisili',
      keterangan: 'Surat pengantar keterangan domisili warga.',
      persyaratan: ['KTP pemohon', 'Kartu Keluarga', 'Surat pengantar RT/RW'],
      ikon: Icons.home_work_outlined,
      warna: Color(0xFFE5EDFF),
    ),
    JenisLayanan(
      id: 'usaha',
      nama: 'Surat Keterangan Usaha',
      keterangan: 'Surat keterangan untuk keperluan administrasi usaha.',
      persyaratan: ['KTP pemohon', 'Kartu Keluarga', 'Foto tempat usaha'],
      ikon: Icons.storefront_outlined,
      warna: Color(0xFFFFEBD8),
    ),
    JenisLayanan(
      id: 'jamkesda',
      nama: 'Rekomendasi Jamkesda',
      keterangan: 'Rekomendasi administrasi untuk layanan kesehatan daerah.',
      persyaratan: ['KTP pemohon', 'Kartu Keluarga', 'Surat keterangan tidak mampu'],
      ikon: Icons.health_and_safety_outlined,
      warna: Color(0xFFE0F3EA),
    ),
    JenisLayanan(
      id: 'kelahiran',
      nama: 'Surat Pengantar Akta Kelahiran',
      keterangan: 'Layanan administrasi pengantar pencatatan kelahiran.',
      persyaratan: ['KTP orang tua', 'Kartu Keluarga', 'Surat keterangan lahir'],
      ikon: Icons.child_friendly_outlined,
      warna: Color(0xFFF4E7FA),
    ),
  ];

  final List<Pengajuan> _pengajuan = [];
  int _selectedIndex = 0;

  Future<void> _bukaForm(JenisLayanan layanan) async {
    final hasil = await Navigator.push<Pengajuan>(
      context,
      MaterialPageRoute<Pengajuan>(
        builder: (_) => FormPengajuanPage(jenisLayanan: layanan),
      ),
    );

    if (!mounted || hasil == null) return;
    setState(() {
      _pengajuan.insert(0, hasil);
      _selectedIndex = 1;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Pengajuan ${hasil.nomor} berhasil dikirim.')),
    );
  }

  void _pilihTab(int index) {
    setState(() => _selectedIndex = index);
  }

  Widget _buildBeranda() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF2457A6), Color(0xFF4381D1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.account_balance, color: Colors.white, size: 34),
              const SizedBox(height: 14),
              Text(
                'Layanan Warga Digital',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Ajukan layanan administrasi kelurahan dengan lebih mudah.',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Text(
                'Pilih layanan',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Text('${_layanan.length} layanan'),
          ],
        ),
        const SizedBox(height: 12),
        ..._layanan.map(_buildKartuLayanan),
      ],
    );
  }

  Widget _buildKartuLayanan(JenisLayanan layanan) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _bukaForm(layanan),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: layanan.warna,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(layanan.ikon, color: const Color(0xFF2457A6)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      layanan.nama,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      layanan.keterangan,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRiwayat() {
    if (_pengajuan.isEmpty) {
      return const _StatusKosong(
        ikon: Icons.history,
        judul: 'Belum ada pengajuan',
        pesan: 'Pengajuan layanan yang Anda kirim akan tampil di sini.',
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Text(
          'Riwayat pengajuan',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ..._pengajuan.map(
          (item) => Card(
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.description_outlined),
              ),
              title: Text(item.namaLayanan),
              subtitle: Text(
                '${item.nomor}\n${item.namaPemohon} • ${formatTanggal(item.tanggal)}',
              ),
              isThreeLine: true,
              trailing: const Chip(
                avatar: Icon(Icons.schedule, size: 16),
                label: Text('Diproses'),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfil() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 20),
        const CircleAvatar(
          radius: 42,
          child: Icon(Icons.person_outline, size: 42),
        ),
        const SizedBox(height: 14),
        Text(
          'Profil Warga',
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        const Card(
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.location_city_outlined),
                title: Text('Layanan Kelurahan'),
                subtitle: Text('Informasi dan pengajuan administrasi warga'),
              ),
              Divider(height: 1),
              ListTile(
                leading: Icon(Icons.support_agent_outlined),
                title: Text('Bantuan'),
                subtitle: Text('Hubungi petugas kelurahan untuk informasi'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Prototipe pembelajaran — data pengajuan hanya tersimpan selama aplikasi berjalan.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [_buildBeranda(), _buildRiwayat(), _buildProfil()];
    const titles = ['Layanan Kelurahan', 'Riwayat', 'Profil'];
    return Scaffold(
      appBar: AppBar(title: Text(titles[_selectedIndex])),
      body: SafeArea(child: pages[_selectedIndex]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _pilihTab,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Beranda',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: 'Riwayat',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}

class FormPengajuanPage extends StatefulWidget {
  const FormPengajuanPage({super.key, required this.jenisLayanan});

  final JenisLayanan jenisLayanan;

  @override
  State<FormPengajuanPage> createState() => _FormPengajuanPageState();
}

class _FormPengajuanPageState extends State<FormPengajuanPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _alamatController = TextEditingController();
  final _catatanController = TextEditingController();

  @override
  void dispose() {
    _namaController.dispose();
    _alamatController.dispose();
    _catatanController.dispose();
    super.dispose();
  }

  void _kirimPengajuan() {
    if (!_formKey.currentState!.validate()) return;

    final now = DateTime.now();
    final nomor =
        'PL-${now.year}${now.month.toString().padLeft(2, '0')}-'
        '${now.millisecondsSinceEpoch.toString().substring(7)}';
    final hasil = Pengajuan(
      nomor: nomor,
      namaPemohon: _namaController.text.trim(),
      namaLayanan: widget.jenisLayanan.nama,
      tanggal: now,
      catatan: _catatanController.text.trim().isEmpty
          ? _alamatController.text.trim()
          : '${_alamatController.text.trim()} • ${_catatanController.text.trim()}',
    );
    Navigator.pop<Pengajuan>(context, hasil);
  }

  @override
  Widget build(BuildContext context) {
    final layanan = widget.jenisLayanan;
    return Scaffold(
      appBar: AppBar(title: const Text('Formulir pengajuan')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: layanan.warna,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Icon(layanan.ikon, size: 32, color: const Color(0xFF2457A6)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        layanan.nama,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Persyaratan',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ...layanan.persyaratan.map(
                (syarat) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        size: 18,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(syarat)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 22),
              TextFormField(
                controller: _namaController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Nama lengkap',
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Nama lengkap wajib diisi.'
                    : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _alamatController,
                minLines: 2,
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Alamat domisili',
                  prefixIcon: Icon(Icons.location_on_outlined),
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Alamat domisili wajib diisi.'
                    : null,
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _catatanController,
                minLines: 2,
                maxLines: 4,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Catatan tambahan (opsional)',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 22),
              FilledButton.icon(
                onPressed: _kirimPengajuan,
                icon: const Icon(Icons.send_outlined),
                label: const Text('Kirim pengajuan'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () => Navigator.pop<Pengajuan>(context),
                child: const Text('Batal'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusKosong extends StatelessWidget {
  const _StatusKosong({
    required this.ikon,
    required this.judul,
    required this.pesan,
  });

  final IconData ikon;
  final String judul;
  final String pesan;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(ikon, size: 60, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              judul,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(pesan, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
