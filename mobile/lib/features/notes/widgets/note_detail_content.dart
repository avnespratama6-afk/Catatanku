import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/tap_button.dart';
import '../models/note.dart';

class NoteDetailContent extends StatelessWidget {
  const NoteDetailContent({
    required this.note,
    required this.onEdit,
    required this.onArchive,
    required this.onDelete,
    super.key,
  });

  final Note note;
  final VoidCallback onEdit;
  final VoidCallback onArchive;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
    children: [
      Container(
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 21),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              note.color.withValues(alpha: 0.24),
              AppPalette.blush.withValues(alpha: 0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.86),
                borderRadius: BorderRadius.circular(23),
              ),
              child: Icon(note.icon, color: note.color, size: 36),
            ),
            const SizedBox(height: 20),
            Text(note.title, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: [
                _DetailTag(label: note.category, icon: Icons.folder_rounded),
                _DetailTag(label: note.priority, icon: Icons.favorite_rounded),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 18),
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: AppPalette.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.calendar_today_rounded,
                  size: 17,
                  color: AppPalette.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  note.date,
                  style: const TextStyle(
                    color: AppPalette.muted,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Divider(height: 1),
            ),
            Text(
              note.body,
              style: const TextStyle(
                color: AppPalette.text,
                height: 1.65,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 24),
      TapButton(
        label: 'Edit Catatan',
        icon: Icons.edit_outlined,
        onTap: onEdit,
        secondary: true,
      ),
      const SizedBox(height: 12),
      TapButton(
        label: note.archived ? 'Keluarkan dari Arsip' : 'Arsipkan Catatan',
        icon: Icons.archive_outlined,
        onTap: onArchive,
      ),
      const SizedBox(height: 12),
      TapButton(
        label: 'Hapus Catatan',
        icon: Icons.delete_outline_rounded,
        onTap: onDelete,
        danger: true,
      ),
    ],
  );
}

class _DetailTag extends StatelessWidget {
  const _DetailTag({required this.label, required this.icon});

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.8),
      borderRadius: BorderRadius.circular(18),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppPalette.primary),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(
            color: AppPalette.primaryDark,
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}
