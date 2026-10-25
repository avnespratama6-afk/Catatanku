import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/main.dart';
import 'package:mobile/features/notes/screens/home_screen.dart';
import 'package:mobile/features/splash/screens/splash_screen.dart';

void main() {
  testWidgets('Splash dan login mengarah ke beranda catatan', (tester) async {
    await tester.pumpWidget(const Catatanku());
    expect(find.byType(SplashScreen), findsOneWidget);
    await tester.pump(const Duration(milliseconds: 1700));
    await tester.pumpAndSettle();
    expect(find.text('Selamat datang kembali'), findsOneWidget);

    await tester.enterText(find.byType(TextField).first, 'avnes@email.test');
    await tester.enterText(find.byType(TextField).last, 'contoh123');
    await tester.tap(find.text('Masuk'));
    await tester.pumpAndSettle();
    expect(find.text('Apa yang ingin kamu catat?'), findsOneWidget);
    expect(find.text('Ide Aplikasi'), findsOneWidget);
  });

  testWidgets(
    'Catatan dapat ditambah, dicari, diedit, diarsipkan, dan dihapus',
    (tester) async {
      await tester.pumpWidget(const Catatanku());
      await tester.pump(const Duration(milliseconds: 1700));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField).first, 'avnes@email.test');
      await tester.enterText(find.byType(TextField).last, 'contoh123');
      await tester.tap(find.text('Masuk'));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField).first, 'Catatan Baru');
      await tester.enterText(
        find.byType(TextFormField).last,
        'Isi catatan untuk tugas.',
      );
      tester.testTextInput.hide();
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.text('Simpan Catatan'),
        250,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('Simpan Catatan'));
      await tester.pumpAndSettle();
      expect(find.text('Catatan Baru'), findsOneWidget);

      await tester.tap(find.text('Catatan Baru'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Edit Catatan'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byType(TextFormField).first,
        'Catatan Diperbarui',
      );
      tester.testTextInput.hide();
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.text('Simpan Perubahan'),
        250,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('Simpan Perubahan'));
      await tester.pumpAndSettle();
      expect(find.text('Catatan Diperbarui'), findsOneWidget);

      await tester.tap(find.text('Catatan Diperbarui'));
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.text('Hapus Catatan'),
        250,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('Hapus Catatan'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(FilledButton, 'Hapus'));
      await tester.pumpAndSettle();
      expect(find.text('Catatan Diperbarui'), findsNothing);

      await tester.scrollUntilVisible(
        find.text('Ide Aplikasi'),
        250,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.tap(find.text('Ide Aplikasi'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Arsipkan Catatan'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Arsip'));
      await tester.pumpAndSettle();
      expect(find.text('Ide Aplikasi'), findsOneWidget);
    },
  );

  testWidgets('Pencarian dan filter kategori menyaring daftar catatan', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
    await tester.enterText(find.byType(TextField), 'Kuliah');
    await tester.pumpAndSettle();
    expect(find.text('Catatan Kuliah'), findsOneWidget);
    expect(find.text('Ide Aplikasi'), findsNothing);

    await tester.enterText(find.byType(TextField), '');
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(ChoiceChip, 'Kuliah'));
    await tester.pumpAndSettle();
    expect(find.text('Catatan Kuliah'), findsOneWidget);
    expect(find.text('Ide Aplikasi'), findsNothing);
  });

  testWidgets('Arsip dan profil menampilkan ringkasan data catatan', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));
    await tester.tap(find.text('Arsip'));
    await tester.pumpAndSettle();
    expect(find.text('Koleksi tersimpan'), findsOneWidget);
    expect(find.text('Arsip masih kosong'), findsOneWidget);

    await tester.tap(find.text('Profil'));
    await tester.pumpAndSettle();
    expect(find.text('Ringkasan catatan'), findsOneWidget);
    expect(find.text('Sebaran kategori'), findsOneWidget);
    await tester.scrollUntilVisible(
      find.text('Catatan terbaru'),
      220,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Catatan terbaru'), findsOneWidget);
  });
}
