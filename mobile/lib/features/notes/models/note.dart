import 'package:flutter/material.dart';

class Note {
  const Note({
    required this.id,
    required this.title,
    required this.body,
    required this.category,
    required this.date,
    required this.icon,
    required this.color,
    required this.priority,
    this.archived = false,
  });

  final String id;
  final String title;
  final String body;
  final String category;
  final String date;
  final IconData icon;
  final Color color;
  final String priority;
  final bool archived;

  Note copyWith({
    String? title,
    String? body,
    String? category,
    Color? color,
    String? priority,
    bool? archived,
  }) => Note(
    id: id,
    title: title ?? this.title,
    body: body ?? this.body,
    category: category ?? this.category,
    date: date,
    icon: icon,
    color: color ?? this.color,
    priority: priority ?? this.priority,
    archived: archived ?? this.archived,
  );
}

class NoteResult {
  const NoteResult.updated(this.note) : deletedId = null;
  const NoteResult.deleted(this.deletedId) : note = null;

  final Note? note;
  final String? deletedId;
}
