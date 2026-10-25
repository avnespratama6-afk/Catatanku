import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/morph_glass.dart';
import '../data/note_categories.dart';
import '../models/note.dart';
import 'task_card.dart';

class ArchiveContent extends StatelessWidget {
  const ArchiveContent({
    required this.notes,
    required this.totalArchived,
    required this.searchController,
    required this.selectedCategory,
    required this.onSearch,
    required this.onCategory,
    required this.onOpen,
    super.key,
  });

  final List<Note> notes;
  final int totalArchived;
  final TextEditingController searchController;
  final String selectedCategory;
  final ValueChanged<String> onSearch;
  final ValueChanged<String> onCategory;
  final ValueChanged<Note> onOpen;

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 22, 20, 110),
    children: [
      Text('Koleksi tersimpan', style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 5),
      Text(
        'Catatan penting tetap mudah ditemukan.',
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      const SizedBox(height: 20),
      MorphGlassPanel(
        padding: const EdgeInsets.all(20),
        tint: const Color(0xC9FFFFFF),
        child: Row(
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: AppPalette.lilac,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Icon(
                Icons.inventory_2_rounded,
                color: AppPalette.primary,
                size: 27,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$totalArchived catatan diarsipkan',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Arsip hanya menyimpan, tidak menghapus.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 18),
      TextField(
        controller: searchController,
        onChanged: onSearch,
        decoration: InputDecoration(
          hintText: 'Cari di arsip...',
          prefixIcon: const Icon(Icons.search_rounded),
          suffixIcon: searchController.text.isEmpty
              ? null
              : IconButton(
                  tooltip: 'Hapus pencarian',
                  onPressed: () {
                    searchController.clear();
                    onSearch('');
                  },
                  icon: const Icon(Icons.close_rounded),
                ),
        ),
      ),
      const SizedBox(height: 14),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: noteCategories
              .map(
                (category) => Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: selectedCategory == category,
                    onSelected: (_) => onCategory(category),
                    selectedColor: AppPalette.lilac,
                    backgroundColor: AppPalette.glass,
                    side: BorderSide(
                      color: selectedCategory == category
                          ? AppPalette.primary.withValues(alpha: 0.2)
                          : AppPalette.glassBorder,
                    ),
                    labelStyle: TextStyle(
                      color: selectedCategory == category
                          ? AppPalette.primaryDark
                          : AppPalette.muted,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      const SizedBox(height: 20),
      Row(
        children: [
          Expanded(
            child: Text(
              'Catatan tersimpan',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          Text(
            '${notes.length} catatan',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
      const SizedBox(height: 12),
      if (notes.isEmpty)
        const _EmptyArchive()
      else
        for (final note in notes) ...[
          NoteCard(note: note, onTap: () => onOpen(note)),
          const SizedBox(height: 12),
        ],
    ],
  );
}

class _EmptyArchive extends StatelessWidget {
  const _EmptyArchive();

  @override
  Widget build(BuildContext context) => MorphGlassPanel(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
    child: Column(
      children: [
        const Icon(
          Icons.inventory_2_outlined,
          color: AppPalette.primary,
          size: 34,
        ),
        const SizedBox(height: 12),
        Text(
          'Arsip masih kosong',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 5),
        Text(
          'Arsipkan catatan dari halaman detail untuk menyimpannya di sini.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    ),
  );
}
