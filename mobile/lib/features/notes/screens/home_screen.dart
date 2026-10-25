import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';
import '../data/note_samples.dart';
import '../models/note.dart';
import '../widgets/archive_content.dart';
import '../widgets/animated_navigation_bar.dart';
import '../widgets/home_content.dart';
import '../../profile/widgets/profile_content.dart';
import 'add_task_screen.dart';
import 'detail_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _search = TextEditingController();
  final _notes = [...sampleNotes];
  int _tab = 0;
  String _category = 'Semua';
  String _query = '';

  List<Note> get _visibleNotes => _notes.where((note) {
    final archiveMatch = note.archived == (_tab == 1);
    final categoryMatch = _category == 'Semua' || note.category == _category;
    final queryMatch = '${note.title} ${note.body}'.toLowerCase().contains(
      _query.toLowerCase(),
    );
    return archiveMatch && categoryMatch && queryMatch;
  }).toList();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  Future<void> _editOrAdd([Note? note]) async {
    final result = await Navigator.of(
      context,
    ).push<Note>(MaterialPageRoute(builder: (_) => AddTaskScreen(note: note)));
    if (!mounted || result == null) return;
    setState(() {
      final index = _notes.indexWhere((item) => item.id == result.id);
      if (index < 0) {
        _notes.insert(0, result);
      } else {
        _notes[index] = result;
      }
    });
  }

  Future<void> _openNote(Note note) async {
    final result = await Navigator.of(context).push<NoteResult>(
      MaterialPageRoute(builder: (_) => DetailTaskScreen(note: note)),
    );
    if (!mounted || result == null) return;
    setState(() {
      if (result.deletedId != null) {
        _notes.removeWhere((item) => item.id == result.deletedId);
      } else if (result.note != null) {
        final index = _notes.indexWhere((item) => item.id == result.note!.id);
        if (index >= 0) {
          _notes[index] = result.note!;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: _tab == 2
            ? ProfileContent(key: const ValueKey('profile'), notes: _notes)
            : _tab == 1
            ? ArchiveContent(
                key: const ValueKey('archive'),
                notes: _visibleNotes,
                totalArchived: _notes.where((note) => note.archived).length,
                searchController: _search,
                selectedCategory: _category,
                onSearch: (value) => setState(() => _query = value),
                onCategory: (value) => setState(() => _category = value),
                onOpen: _openNote,
              )
            : NotesHomeContent(
                key: ValueKey('list-$_tab'),
                notes: _visibleNotes,
                totalNotes: _notes.where((note) => !note.archived).length,
                highPriorityCount: _notes
                    .where(
                      (note) => !note.archived && note.priority == 'Tinggi',
                    )
                    .length,
                searchController: _search,
                selectedCategory: _category,
                onSearch: (value) => setState(() => _query = value),
                onCategory: (value) => setState(() => _category = value),
                onOpen: _openNote,
              ),
      ),
    ),
    floatingActionButton: _tab == 0
        ? FloatingActionButton(
            onPressed: () => _editOrAdd(),
            backgroundColor: AppPalette.primary,
            foregroundColor: Colors.white,
            elevation: 5,
            shape: const CircleBorder(),
            child: const Icon(Icons.add_rounded, size: 29),
          )
        : null,
    bottomNavigationBar: AnimatedNavigationBar(
      selectedIndex: _tab,
      onDestinationSelected: (index) => setState(() => _tab = index),
    ),
  );
}
