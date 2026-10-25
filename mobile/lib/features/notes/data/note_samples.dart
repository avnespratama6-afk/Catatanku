import 'package:flutter/material.dart';

import '../models/note.dart';

const sampleNotes = [
  Note(
    id: 'idea',
    title: 'Ide Aplikasi',
    body: 'Buat aplikasi catatan sederhana dengan empat kategori utama.',
    category: 'Penting',
    date: '23 Oktober 2026 · 09.30',
    icon: Icons.lightbulb_outline_rounded,
    color: Color(0xFFF0B86B),
    priority: 'Tinggi',
  ),
  Note(
    id: 'week',
    title: 'Rencana Mingguan',
    body: 'Susun agenda, waktu istirahat, dan kegiatan akhir pekan.',
    category: 'Pribadi',
    date: '22 Oktober 2026 · 16.15',
    icon: Icons.calendar_month_rounded,
    color: Color(0xFFF1A7CD),
    priority: 'Sedang',
  ),
  Note(
    id: 'class',
    title: 'Catatan Kuliah',
    body: 'Rangkum materi desain antarmuka dan prinsip aksesibilitas.',
    category: 'Kuliah',
    date: '21 Oktober 2026 · 13.00',
    icon: Icons.menu_book_rounded,
    color: Color(0xFF9468D8),
    priority: 'Tinggi',
  ),
  Note(
    id: 'shopping',
    title: 'Daftar Belanja',
    body: 'Susu, buah, roti gandum, dan kopi untuk persediaan rumah.',
    category: 'Belanja',
    date: '20 Oktober 2026 · 18.20',
    icon: Icons.shopping_cart_outlined,
    color: Color(0xFF89CDB1),
    priority: 'Rendah',
  ),
  Note(
    id: 'journal',
    title: 'Jurnal Harian',
    body: 'Hari yang produktif, sempat berjalan santai sore ini.',
    category: 'Pribadi',
    date: '19 Oktober 2026 · 20.00',
    icon: Icons.favorite_border_rounded,
    color: Color(0xFF7DB8E8),
    priority: 'Sedang',
  ),
];
