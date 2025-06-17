import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_note/core/constants.dart';
import 'package:project_note/widgets/note_icon_button.dart';
import 'package:project_note/widgets/note_icon_button_outlined.dart';

class NewOrEditNotePage extends StatefulWidget {
  const NewOrEditNotePage({super.key});

  @override
  State<NewOrEditNotePage> createState() => _NewOrEditNotePageState();
}

class _NewOrEditNotePageState extends State<NewOrEditNotePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: NoteIconButtonOutlined(
            icon: FontAwesomeIcons.chevronLeft,
            onPressed: () {},
          ),
        ),
        title: Text('New Note'),
        actions: [
          NoteIconButtonOutlined(icon: FontAwesomeIcons.pen, onPressed: () {}),
          NoteIconButtonOutlined(
            icon: FontAwesomeIcons.check,
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: 'Title here',
                hintStyle: TextStyle(color: gray300),
                border: InputBorder.none,
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Last Modified',
                    style: TextStyle(fontWeight: FontWeight.bold, color: gray500),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    '17 June 2025, 03:35 PM',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Row(children: [Text('Created'), Text('16 June 2025, 03:35 PM')]),
            Row(
              children: [
                Row(
                  children: [
                    Text('Created'),
                    NoteIconButton(
                      icon: FontAwesomeIcons.circlePlus,
                      onPressed: () {},
                    ),
                  ],
                ),
                Text('No tags added'),
              ],
            ),
            Divider(),
            TextField(decoration: InputDecoration(hintText: 'Note here...')),
          ],
        ),
      ),
    );
  }
}
