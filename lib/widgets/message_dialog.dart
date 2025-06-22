import 'package:flutter/material.dart';
import 'package:project_note/widgets/dialog_card.dart';
import 'package:project_note/widgets/note_button.dart';

class MessageDialog extends StatelessWidget {
  const MessageDialog({super.key, required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return DialogCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Do you want to save the note?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              NoteButton(
                child: Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
