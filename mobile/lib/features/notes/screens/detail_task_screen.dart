
import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../models/note.dart';
import '../widgets/note_detail_content.dart';
import 'add_task_screen.dart';

class DetailTaskScreen extends StatefulWidget {
  const DetailTaskScreen({required this.note, super.key});

  final Note note;

  @override
  State<DetailTaskScreen> createState() => _DetailTaskScreenState();
}

class _DetailTaskScreenState extends State<DetailTaskScreen> {
  late final Note _note = widget.note;

  Future<void> _edit() async {
    final result = await Navigator.push<Note>(
      context,
      MaterialPageRoute(
        builder: (_) => AddTaskScreen(note: _note),
      ),
    );

    if (!mounted || result == null) return;

    Navigator.pop(context, NoteResult.updated(result));
  }

  Future<void> _delete() async {
    final approved = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        title: const Text('Hapus catatan?'),
        content: Text('Catatan “${_note.title}” akan dihapus.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppPalette.danger,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );

    if (!mounted || approved != true) return;

    Navigator.pop(context, NoteResult.deleted(_note.id));
  }

  void _archive() => Navigator.pop(
        context,
        NoteResult.updated(
          _note.copyWith(archived: !_note.archived),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Detail Catatan'),
        ),
        body: NoteDetailContent(
          note: _note,
          onEdit: _edit,
          onArchive: _archive,
          onDelete: _delete,
        ),
      );
}
