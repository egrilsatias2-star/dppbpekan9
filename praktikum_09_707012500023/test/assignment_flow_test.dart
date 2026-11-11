import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:praktikum_09_707012500023/main.dart';

void main() {
  testWidgets('kasir dapat mencatat transaksi dan membukanya di riwayat',
      (tester) async {
    await tester.pumpWidget(const PraktikumApp());

    await tester.enterText(find.byType(TextFormField).at(0), 'Kasir Demo');
    await tester.enterText(find.byType(TextFormField).at(1), '1234');
    await tester.tap(find.text('Masuk sebagai kasir'));
    await tester.pumpAndSettle();

    expect(find.text('Halo, Kasir Demo!'), findsOneWidget);
    final batagor = find.text('Batagor Bandung').first;
    await tester.ensureVisible(batagor);
    await tester.tap(batagor);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Catat penjualan'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Riwayat transaksi'));
    await tester.pumpAndSettle();

    expect(find.text('Transaksi 1'), findsOneWidget);
    expect(find.textContaining('TRX-'), findsOneWidget);
  });
}
