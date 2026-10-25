import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/tap_button.dart';

const noteCategories = ['Penting', 'Pribadi', 'Kuliah', 'Belanja'];
const noteColors = [
  Color(0xFF9468D8),
  Color(0xFFF1A7CD),
  Color(0xFF89CDB1),
  Color(0xFFF0B86B),
  Color(0xFF7DB8E8),
];

class NoteFormFields extends StatelessWidget {
  const NoteFormFields({
    required this.formKey,
    required this.title,
    required this.body,
    required this.category,
    required this.color,
    required this.priority,
    required this.onCategory,
    required this.onColor,
    required this.onPriority,
    required this.onSave,
    required this.saveLabel,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController title;
  final TextEditingController body;
  final String category;
  final Color color;
  final String priority;
  final ValueChanged<String> onCategory;
  final ValueChanged<Color> onColor;
  final ValueChanged<String> onPriority;
  final VoidCallback onSave;
  final String saveLabel;

  @override
  Widget build(BuildContext context) => Form(
    key: formKey,
    child: ListView(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
      children: [
        Container(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppPalette.lilac, AppPalette.blush],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.edit_note_rounded, color: AppPalette.primary),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Simpan ide baikmu di sini.',
                  style: TextStyle(
                    color: AppPalette.primaryDark,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Icon(Icons.auto_awesome_rounded, color: AppPalette.primary),
            ],
          ),
        ),
        const SizedBox(height: 21),
        const Text(
          'Judul Catatan',
          style: TextStyle(
            color: AppPalette.primaryDark,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: title,
          textCapitalization: TextCapitalization.sentences,
          decoration: const InputDecoration(hintText: 'Masukkan judul catatan'),
          validator: (value) => value == null || value.trim().isEmpty
              ? 'Judul catatan wajib diisi.'
              : null,
        ),
        const SizedBox(height: 18),
        const Text(
          'Isi Catatan',
          style: TextStyle(
            color: AppPalette.primaryDark,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: body,
          textCapitalization: TextCapitalization.sentences,
          minLines: 5,
          maxLines: 8,
          decoration: const InputDecoration(
            hintText: 'Tulis catatanmu di sini... (Opsional)',
            alignLabelWithHint: true,
          ),
        ),
        const SizedBox(height: 18),
        const Text(
          'Kategori',
          style: TextStyle(
            color: AppPalette.primaryDark,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: category,
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.folder_outlined),
          ),
          items: noteCategories
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: (value) {
            if (value != null) onCategory(value);
          },
        ),
        const SizedBox(height: 18),
        const Text(
          'Warna',
          style: TextStyle(
            color: AppPalette.primaryDark,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 14,
          children: noteColors
              .map(
                (item) => InkWell(
                  onTap: () => onColor(item),
                  customBorder: const CircleBorder(),
                  child: CircleAvatar(
                    radius: 19,
                    backgroundColor: item,
                    child: color == item
                        ? const Icon(
                            Icons.check_rounded,
                            color: Colors.white,
                            size: 20,
                          )
                        : null,
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 18),
        const Text(
          'Prioritas',
          style: TextStyle(
            color: AppPalette.primaryDark,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: ['Rendah', 'Sedang', 'Tinggi']
              .map(
                (item) => ChoiceChip(
                  label: Text(item),
                  selected: priority == item,
                  onSelected: (_) => onPriority(item),
                  selectedColor: AppPalette.lilac,
                  backgroundColor: Colors.white,
                  side: BorderSide(
                    color: priority == item
                        ? AppPalette.primary.withValues(alpha: 0.35)
                        : AppPalette.border,
                  ),
                  labelStyle: TextStyle(
                    color: priority == item
                        ? AppPalette.primaryDark
                        : AppPalette.muted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 24),
        TapButton(label: saveLabel, icon: Icons.check_rounded, onTap: onSave),
      ],
    ),
  );
}
