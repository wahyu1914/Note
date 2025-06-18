
import 'package:flutter/material.dart';
import 'package:project_note/models/note.dart';

class NotesProvider extends ChangeNotifier{
  final List<Note> _notes = [];

  List<Note> get notes => [..._notes];
}
