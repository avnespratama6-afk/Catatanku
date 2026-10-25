import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../models/note.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({required this.note, required this.onTap, super.key});

  final Note note;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Material(
    color: Colors.white,
    borderRadius: BorderRadius.circular(22),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(22),
      splashColor: note.color.withValues(alpha: 0.14),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          border: Border.all(color: AppPalette.border.withValues(alpha: 0.72)),
          boxShadow: [
            BoxShadow(
              color: AppPalette.primaryDark.withValues(alpha: 0.055),
              blurRadius: 20,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 60,
              decoration: BoxDecoration(
                color: note.color.withValues(alpha: 0.17),
                borderRadius: BorderRadius.circular(19),
              ),
              child: Icon(note.icon, color: note.color, size: 27),
            ),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title,
                    style: const TextStyle(
                      color: AppPalette.primaryDark,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    note.body,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppPalette.muted,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      Text(
                        note.category,
                        style: const TextStyle(
                          color: AppPalette.primary,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Text(
                        '  ·  ',
                        style: TextStyle(color: AppPalette.muted),
                      ),
                      Flexible(
                        child: Text(
                          note.date,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: AppPalette.muted,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 7),
            _PriorityTag(priority: note.priority),
            const SizedBox(width: 3),
            const Icon(Icons.chevron_right_rounded, color: AppPalette.muted),
          ],
        ),
      ),
    ),
  );
}

class _PriorityTag extends StatelessWidget {
  const _PriorityTag({required this.priority});

  final String priority;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: priority == 'Tinggi' ? AppPalette.blush : AppPalette.lilac,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      child: Text(priority, style: Theme.of(context).textTheme.labelSmall),
    ),
  );
}
