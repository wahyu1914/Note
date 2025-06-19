import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:project_note/change_notifiers/notes_provider.dart';
import 'package:project_note/models/note.dart';
import 'package:provider/provider.dart';

class NewNoteController extends ChangeNotifier {
  bool _readOnly = false;
  set readOnly(bool value) {
    _readOnly = value;
    notifyListeners();
  }

  bool get readOnly => _readOnly;

  String _title = '';
  set title(String value) {
    _title = value;
    notifyListeners();
  }

  String get title => _title;

  Document _content = Document();
  set content(Document value) {
    _content = value;
    notifyListeners();
  }

  Document get content => _content;

  final List<String> _tags = [];
  void addTag(String tag) {
    _tags.add(tag);
    notifyListeners();
  }

  List<String> get tags => [..._tags];

  void removeTag(int index) {
    _tags.removeAt(index);
    notifyListeners();
  }

  void saveNote(BuildContext context) {
    final String? newTitle = title.isNotEmpty ? title : null;
    final String? newContent = content.toPlainText().trim().isNotEmpty
        ? content.toPlainText().trim()
        : null;
    final String contentJson = jsonEncode(_content.toDelta().toJson());
    final int now = DateTime.now().microsecondsSinceEpoch;
    final Note note = Note(
      title: title,
      content: newContent,
      contentJson: contentJson,
      dateCreated: now,
      dateModified: now,
      tags: tags,
    );

    context.read<NotesProvider>().addNote(note);
  }
}
