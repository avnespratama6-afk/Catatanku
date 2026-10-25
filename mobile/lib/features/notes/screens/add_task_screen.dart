import 'package:flutter/material.dart';

import '../models/note.dart';
import '../widgets/note_form_fields.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({this.note, super.key});
  final Note? note;
  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _form = GlobalKey<FormState>();
  late final _title = TextEditingController(text: widget.note?.title ?? '');
  late final _body = TextEditingController(text: widget.note?.body ?? '');
  late String _category = widget.note?.category ?? 'Pribadi';
  late Color _color = widget.note?.color ?? noteColors.first;
  late String _priority = widget.note?.priority ?? 'Sedang';

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
  }

  void _save() {
    if (!_form.currentState!.validate()) return;
    final old = widget.note;
    Navigator.pop(
      context,
      Note(
        id: old?.id ?? DateTime.now().microsecondsSinceEpoch.toString(),
        title: _title.text.trim(),
        body: _body.text.trim(),
        category: _category,
        date: old?.date ?? 'Hari ini · 09.30',
        icon: _icon(_category),
        color: _color,
        priority: _priority,
        archived: old?.archived ?? false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(widget.note == null ? 'Tambah Catatan' : 'Edit Catatan'),
    ),
    body: NoteFormFields(
      formKey: _form,
      title: _title,
      body: _body,
      category: _category,
      color: _color,
      priority: _priority,
      onCategory: (value) => setState(() => _category = value),
      onColor: (value) => setState(() => _color = value),
      onPriority: (value) => setState(() => _priority = value),
      onSave: _save,
      saveLabel: widget.note == null ? 'Simpan Catatan' : 'Simpan Perubahan',
    ),
  );
}

IconData _icon(String category) => switch (category) {
  'Penting' => Icons.lightbulb_outline_rounded,
  'Kuliah' => Icons.menu_book_rounded,
  'Belanja' => Icons.shopping_cart_outlined,
  _ => Icons.favorite_border_rounded,
};
