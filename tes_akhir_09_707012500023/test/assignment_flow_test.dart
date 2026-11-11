import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tes_akhir_09_707012500023/main.dart';

void main() {
  testWidgets('warga dapat mengirim pengajuan dan menerima hasilnya di riwayat',
      (tester) async {
    await tester.pumpWidget(const LayananWargaApp());

    final layanan = find.text('Surat Pengantar Domisili');
    await tester.ensureVisible(layanan);
    await tester.tap(layanan);
    await tester.pumpAndSettle();

    expect(find.text('Persyaratan'), findsOneWidget);
    await tester.enterText(find.byType(TextFormField).at(0), 'Warga Demo');
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'Jl. Merdeka No. 1, Bandung',
    );
    final tombolKirim = find.text('Kirim pengajuan');
    await tester.ensureVisible(tombolKirim);
    await tester.tap(tombolKirim);
    await tester.pumpAndSettle();

    expect(find.text('Riwayat pengajuan'), findsOneWidget);
    expect(find.textContaining('Warga Demo'), findsOneWidget);
    expect(find.text('Diproses'), findsOneWidget);
  });
}
