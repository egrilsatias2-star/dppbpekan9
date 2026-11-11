import 'package:flutter/material.dart';

void main() {
  runApp(const PraktikumApp());
}

class PraktikumApp extends StatelessWidget {
  const PraktikumApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kasir Sentra UMKM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF176B58),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F8F5),
      ),
      home: const LoginKasirPage(),
    );
  }
}

class ItemPenjualan {
  const ItemPenjualan({
    required this.id,
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.foto,
    required this.deskripsi,
  });

  final String id;
  final String nama;
  final String kategori;
  final int harga;
  final String foto;
  final String deskripsi;
}

String formatRupiah(int nilai) {
  final digits = nilai.toString();
  final grouped = digits.replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => '.',
  );
  return 'Rp$grouped';
}

class LoginKasirPage extends StatefulWidget {
  const LoginKasirPage({super.key});

  @override
  State<LoginKasirPage> createState() => _LoginKasirPageState();
}

class _LoginKasirPageState extends State<LoginKasirPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _pinController = TextEditingController();
  bool _sembunyikanPin = true;

  @override
  void dispose() {
    _namaController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  void prosesLogin() {
    if (!_formKey.currentState!.validate()) return;

    final namaKasir = _namaController.text.trim();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (_) => BerandaKasirPage(namaKasir: namaKasir),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      height: 160,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0F0E9),
                        borderRadius: BorderRadius.circular(28),
                      ),
                      child: const Icon(
                        Icons.storefront_rounded,
                        size: 78,
                        color: Color(0xFF176B58),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Text(
                      'Kasir Sentra UMKM',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Masuk untuk mencatat penjualan gerai Braga.',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.black54,
                          ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _namaController,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Nama kasir',
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => value == null || value.trim().isEmpty
                          ? 'Nama kasir wajib diisi.'
                          : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _pinController,
                      obscureText: _sembunyikanPin,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => prosesLogin(),
                      decoration: InputDecoration(
                        labelText: 'PIN kasir',
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          tooltip: _sembunyikanPin ? 'Tampilkan PIN' : 'Sembunyikan PIN',
                          onPressed: () {
                            setState(() => _sembunyikanPin = !_sembunyikanPin);
                          },
                          icon: Icon(
                            _sembunyikanPin
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
                      validator: (value) => value == null || value.trim().isEmpty
                          ? 'PIN wajib diisi.'
                          : null,
                    ),
                    const SizedBox(height: 20),
                    FilledButton.icon(
                      onPressed: prosesLogin,
                      icon: const Icon(Icons.login),
                      label: const Text('Masuk sebagai kasir'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BerandaKasirPage extends StatefulWidget {
  const BerandaKasirPage({super.key, required this.namaKasir});

  final String namaKasir;

  @override
  State<BerandaKasirPage> createState() => _BerandaKasirPageState();
}

class _BerandaKasirPageState extends State<BerandaKasirPage> {
  final List<ItemPenjualan> _produk = const [
    ItemPenjualan(
      id: 'mkn-01',
      nama: 'Batagor Bandung',
      kategori: 'Makanan',
      harga: 15000,
      foto: 'batagor',
      deskripsi: 'Batagor ikan khas Bandung dengan bumbu kacang gurih.',
    ),
    ItemPenjualan(
      id: 'mkn-02',
      nama: 'Surabi Oncom',
      kategori: 'Makanan',
      harga: 12000,
      foto: 'surabi',
      deskripsi: 'Surabi tradisional dengan topping oncom yang nikmat.',
    ),
    ItemPenjualan(
      id: 'mkn-03',
      nama: 'Peuyeum Bandung',
      kategori: 'Oleh-oleh',
      harga: 20000,
      foto: 'peuyeum',
      deskripsi: 'Peuyeum pilihan, cocok dijadikan buah tangan.',
    ),
    ItemPenjualan(
      id: 'mkn-04',
      nama: 'Kopi Aroma',
      kategori: 'Minuman',
      harga: 28000,
      foto: 'kopi',
      deskripsi: 'Kopi lokal dengan aroma khas dan rasa seimbang.',
    ),
    ItemPenjualan(
      id: 'mkn-05',
      nama: 'Brownies Kukus',
      kategori: 'Oleh-oleh',
      harga: 35000,
      foto: 'brownies',
      deskripsi: 'Brownies kukus lembut produksi UMKM Kota Bandung.',
    ),
    ItemPenjualan(
      id: 'mkn-06',
      nama: 'Es Cendol',
      kategori: 'Minuman',
      harga: 10000,
      foto: 'cendol',
      deskripsi: 'Minuman cendol segar dengan gula aren dan santan.',
    ),
  ];

  final List<String> _riwayat = [];
  final Set<String> _favorit = {};
  String _kataKunci = '';

  List<ItemPenjualan> get _produkTersaring => _produk.where((item) {
        final kata = _kataKunci.toLowerCase();
        return item.nama.toLowerCase().contains(kata) ||
            item.kategori.toLowerCase().contains(kata);
      }).toList();

  Future<void> navigasiKeDetail(ItemPenjualan item) async {
    final hasil = await Navigator.push<String>(
      context,
      MaterialPageRoute<String>(
        builder: (_) => DetailProdukPage(item: item),
      ),
    );
    if (!mounted || hasil == null) return;
    tangkapHasilTransaksi(item, hasil);
  }

  void tangkapHasilTransaksi(ItemPenjualan item, String hasil) {
    setState(() => _riwayat.insert(0, hasil));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item.nama} berhasil dicatat dalam riwayat.')),
    );
  }

  Widget buildProductCard(ItemPenjualan item) {
    final isFavorite = _favorit.contains(item.id);
    return GestureDetector(
      onTap: () => navigasiKeDetail(item),
      onDoubleTap: () {
        setState(() {
          if (isFavorite) {
            _favorit.remove(item.id);
          } else {
            _favorit.add(item.id);
          }
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              isFavorite
                  ? '${item.nama} dihapus dari favorit.'
                  : '${item.nama} ditambahkan ke favorit.',
            ),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      onLongPress: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item.nama}: ${item.deskripsi}'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: buildProductBanner(item.foto)),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.nama,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      if (isFavorite)
                        const Icon(Icons.favorite, color: Colors.red, size: 18),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.kategori,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: Colors.black54,
                        ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    formatRupiah(item.harga),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildProductBanner(String foto) {
    const palette = <String, (Color, IconData)>{
      'batagor': (Color(0xFFFFE6CC), Icons.ramen_dining),
      'surabi': (Color(0xFFFFF0C2), Icons.bakery_dining),
      'peuyeum': (Color(0xFFE8E1C8), Icons.spa),
      'kopi': (Color(0xFFE8D6C5), Icons.coffee),
      'brownies': (Color(0xFFF1D8D2), Icons.cake),
      'cendol': (Color(0xFFD8EEE3), Icons.local_drink),
    };
    final (warna, ikon) =
        palette[foto] ?? (const Color(0xFFE7E9E7), Icons.shopping_bag);
    return Container(
      color: warna,
      alignment: Alignment.center,
      child: Icon(ikon, size: 54, color: const Color(0xFF5A4939)),
    );
  }

  void navigasiKembali() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(builder: (_) => const LoginKasirPage()),
    );
  }

  Future<void> _bukaRiwayat() async {
    await Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        builder: (_) => RiwayatKasirPage(riwayat: List.of(_riwayat)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final produk = _produkTersaring;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sentra UMKM Braga'),
        actions: [
          IconButton(
            tooltip: 'Riwayat transaksi',
            onPressed: _bukaRiwayat,
            icon: Badge(
              isLabelVisible: _riwayat.isNotEmpty,
              label: Text('${_riwayat.length}'),
              child: const Icon(Icons.receipt_long_outlined),
            ),
          ),
          IconButton(
            tooltip: 'Keluar',
            onPressed: navigasiKembali,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Halo, ${widget.namaKasir}!',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 4),
                  const Text('Pilih produk untuk melihat detail atau mencatat penjualan.'),
                  const SizedBox(height: 14),
                  TextField(
                    onChanged: (value) => setState(() => _kataKunci = value),
                    decoration: InputDecoration(
                      hintText: 'Cari nama atau kategori produk',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Produk gerai',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: produk.isEmpty
                  ? const Center(child: Text('Produk tidak ditemukan.'))
                  : GridView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: produk.length,
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 260,
                        mainAxisExtent: 238,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (_, index) => buildProductCard(produk[index]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailProdukPage extends StatelessWidget {
  const DetailProdukPage({super.key, required this.item});

  final ItemPenjualan item;

  void prosesPenjualan(BuildContext context) {
    final hasil = 'TRX-${DateTime.now().millisecondsSinceEpoch} • '
        '${item.nama} • ${formatRupiah(item.harga)}';
    Navigator.pop<String>(context, hasil);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail produk')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              height: 240,
              decoration: BoxDecoration(
                color: const Color(0xFFE0F0E9),
                borderRadius: BorderRadius.circular(24),
              ),
              alignment: Alignment.center,
              child: Icon(
                item.kategori == 'Minuman'
                    ? Icons.local_cafe
                    : Icons.fastfood_outlined,
                size: 100,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Chip(
              avatar: const Icon(Icons.sell_outlined, size: 18),
              label: Text(item.kategori),
            ),
            const SizedBox(height: 8),
            Text(
              item.nama,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              formatRupiah(item.harga),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            Text(item.deskripsi),
            const SizedBox(height: 28),
            FilledButton.icon(
              onPressed: () => prosesPenjualan(context),
              icon: const Icon(Icons.point_of_sale),
              label: const Text('Catat penjualan'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => Navigator.pop<String>(context),
              child: const Text('Batal'),
            ),
          ],
        ),
      ),
    );
  }
}

class RiwayatKasirPage extends StatelessWidget {
  const RiwayatKasirPage({super.key, required this.riwayat});

  final List<String> riwayat;

  Widget buildRiwayatItem(String dataTransaksi, int noUrut) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text('$noUrut')),
        title: Text('Transaksi $noUrut'),
        subtitle: Text(dataTransaksi),
        isThreeLine: true,
        trailing: const Icon(Icons.check_circle, color: Colors.green),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat transaksi')),
      body: riwayat.isEmpty
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.receipt_long_outlined, size: 56),
                    SizedBox(height: 12),
                    Text('Belum ada transaksi yang dicatat.'),
                  ],
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: riwayat.length,
              itemBuilder: (_, index) =>
                  buildRiwayatItem(riwayat[index], index + 1),
            ),
    );
  }
}
