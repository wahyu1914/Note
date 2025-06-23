import 'package:flutter/material.dart';

import '../models/note.dart';
import 'note_card.dart';

class NotesGrid extends StatelessWidget {
  const NotesGrid({required this.notes, super.key});

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: notes.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemBuilder: (context, int index) {
        return NoteCard(
          note: notes[index],
          isInGrid: true);
      },
    );
  }
}
