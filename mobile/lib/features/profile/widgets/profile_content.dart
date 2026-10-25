import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/morph_glass.dart';
import '../../notes/models/note.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({required this.notes, super.key});

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    final activeNotes = notes.where((note) => !note.archived).toList();
    final archivedNotes = notes.where((note) => note.archived).length;
    final priorityNotes = activeNotes
        .where((note) => note.priority == 'Tinggi')
        .length;
    final categories = <String, int>{};
    for (final note in notes) {
      categories.update(note.category, (count) => count + 1, ifAbsent: () => 1);
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 110),
      children: [
        Text('Profil', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: 5),
        Text(
          'Ruang pribadi untuk melihat kebiasaan mencatatmu.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 20),
        MorphGlassPanel(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          tint: const Color(0xCFFFFFFF),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const CircleAvatar(
                  radius: 42,
                  backgroundColor: AppPalette.lilac,
                  child: Icon(
                    Icons.face_3_rounded,
                    color: AppPalette.primary,
                    size: 47,
                  ),
                ),
              ),
              const SizedBox(height: 13),
              Text(
                'Avnes Pratama',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 4),
              Text(
                'Profil demo Catatanku',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Ringkasan catatan',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                icon: Icons.sticky_note_2_outlined,
                label: 'Aktif',
                value: activeNotes.length,
                color: AppPalette.primary,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _StatCard(
                icon: Icons.favorite_outline_rounded,
                label: 'Prioritas tinggi',
                value: priorityNotes,
                color: AppPalette.danger,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _StatCard(
                icon: Icons.archive_outlined,
                label: 'Arsip',
                value: archivedNotes,
                color: const Color(0xFF548F78),
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        Text('Sebaran kategori', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        MorphGlassPanel(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 8),
          child: categories.isEmpty
              ? Text(
                  'Kategori akan tampil setelah kamu membuat catatan.',
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              : Column(
                  children: categories.entries
                      .map(
                        (entry) => _CategoryRow(
                          category: entry.key,
                          count: entry.value,
                          total: notes.length,
                        ),
                      )
                      .toList(),
                ),
        ),
        const SizedBox(height: 22),
        Text('Catatan terbaru', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        if (notes.isEmpty)
          MorphGlassPanel(
            child: Text(
              'Catatan terbaru akan muncul di sini.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          )
        else
          for (final note in notes.take(3)) ...[
            _RecentNote(note: note),
            const SizedBox(height: 10),
          ],
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  final IconData icon;
  final String label;
  final int value;
  final Color color;

  @override
  Widget build(BuildContext context) => MorphGlassPanel(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    borderRadius: 20,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 19),
        const SizedBox(height: 12),
        Text(
          '$value',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 20),
        ),
        const SizedBox(height: 3),
        Text(label, maxLines: 2, style: Theme.of(context).textTheme.bodySmall),
      ],
    ),
  );
}

class _CategoryRow extends StatelessWidget {
  const _CategoryRow({
    required this.category,
    required this.count,
    required this.total,
  });

  final String category;
  final int count;
  final int total;

  @override
  Widget build(BuildContext context) {
    final progress = total == 0 ? 0.0 : count / total;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(category, style: Theme.of(context).textTheme.bodyLarge),
          ),
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 7,
                color: AppPalette.primary,
                backgroundColor: AppPalette.lilac,
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 20,
            child: Text(
              '$count',
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentNote extends StatelessWidget {
  const _RecentNote({required this.note});

  final Note note;

  @override
  Widget build(BuildContext context) => MorphGlassPanel(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
    borderRadius: 20,
    child: Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: note.color.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(note.icon, color: note.color, size: 21),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(note.title, style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 3),
              Text(
                '${note.category} · ${note.date}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
