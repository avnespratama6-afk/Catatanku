import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../data/note_categories.dart';
import '../models/note.dart';
import 'task_card.dart';

class NotesHomeContent extends StatelessWidget {
  const NotesHomeContent({
    required this.notes,
    required this.totalNotes,
    required this.highPriorityCount,
    required this.searchController,
    required this.selectedCategory,
    required this.onSearch,
    required this.onCategory,
    required this.onOpen,
    super.key,
  });

  final List<Note> notes;
  final int totalNotes;
  final int highPriorityCount;
  final TextEditingController searchController;
  final String selectedCategory;
  final ValueChanged<String> onSearch;
  final ValueChanged<String> onCategory;
  final ValueChanged<Note> onOpen;
  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 14, 20, 104),
    children: [
      Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Halo, Avnes Pratama!',
                  style: TextStyle(
                    color: AppPalette.muted,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Apa yang ingin kamu catat?',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 25,
                    letterSpacing: -0.5,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  'Simpan ide dan rencana dalam satu ruang.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(
              color: AppPalette.lilac,
              shape: BoxShape.circle,
            ),
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.face_3_rounded, color: AppPalette.primary),
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
      _WelcomeCard(totalNotes: totalNotes, priorityCount: highPriorityCount),
      const SizedBox(height: 18),
      TextField(
        controller: searchController,
        onChanged: onSearch,
        decoration: InputDecoration(
          hintText: 'Cari catatan...',
          prefixIcon: const Icon(Icons.search_rounded),
          suffixIcon: IconButton(
            tooltip: 'Hapus pencarian',
            onPressed: () {
              searchController.clear();
              onSearch('');
            },
            icon: const Icon(Icons.close_rounded),
          ),
        ),
      ),
      const SizedBox(height: 16),
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
      const SizedBox(height: 16),
      Row(
        children: [
          Expanded(
            child: Text(
              'Koleksi Catatan',
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
        const _EmptyNotes()
      else
        for (final note in notes) ...[
          NoteCard(note: note, onTap: () => onOpen(note)),
          const SizedBox(height: 11),
        ],
    ],
  );
}

class _WelcomeCard extends StatelessWidget {
  const _WelcomeCard({required this.totalNotes, required this.priorityCount});

  final int totalNotes;
  final int priorityCount;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(19),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF6674E8), Color(0xFF988DEB)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(26),
      boxShadow: [
        BoxShadow(
          color: AppPalette.primary.withValues(alpha: 0.11),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ide kecil, hari hebat!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '$totalNotes catatan tersimpan untukmu',
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  const Icon(
                    Icons.favorite_rounded,
                    color: AppPalette.accent,
                    size: 17,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '$priorityCount prioritas tinggi',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 76,
          height: 76,
          decoration: const BoxDecoration(
            color: Color(0x2EFFFFFF),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.auto_awesome_rounded,
            color: Colors.white,
            size: 43,
          ),
        ),
      ],
    ),
  );
}

class _EmptyNotes extends StatelessWidget {
  const _EmptyNotes();
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 38),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
    ),
    child: const Column(
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: AppPalette.lilac,
          child: Icon(
            Icons.sticky_note_2_outlined,
            size: 32,
            color: AppPalette.primary,
          ),
        ),
        SizedBox(height: 13),
        Text(
          'Belum ada catatan yang cocok.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppPalette.primaryDark,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 5),
        Text(
          'Coba kata kunci atau kategori lainnya.',
          textAlign: TextAlign.center,
          style: TextStyle(color: AppPalette.muted),
        ),
      ],
    ),
  );
}
