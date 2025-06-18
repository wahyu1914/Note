import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_note/core/constants.dart';
import 'package:project_note/core/constants.dart' as colors;
import 'package:project_note/widgets/note_icon_button.dart';
import 'package:project_note/widgets/note_icon_button_outlined.dart';

class NewOrEditNotePage extends StatefulWidget {
  const NewOrEditNotePage({required this.isNewNote, super.key});

  final bool isNewNote;

  @override
  State<NewOrEditNotePage> createState() => _NewOrEditNotePageState();
}

class _NewOrEditNotePageState extends State<NewOrEditNotePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  late final FocusNode focusNode;

  late bool readOnly;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode = FocusNode();

    if (widget.isNewNote) {
      focusNode.requestFocus();
      readOnly = false;
    } else {
      readOnly = true;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    noteController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: NoteIconButtonOutlined(
            icon: FontAwesomeIcons.chevronLeft,
            onPressed: () {
              Navigator.maybePop(context);
            },
          ),
        ),
        title: Text(widget.isNewNote ? 'New Note' : 'Edit Note'),
        actions: [
          NoteIconButtonOutlined(
            icon: readOnly ? FontAwesomeIcons.pen : FontAwesomeIcons.bookOpen,
            onPressed: () {
              setState(() {
                readOnly = !readOnly;

                if (readOnly) {
                  FocusScope.of(context).unfocus();
                } else {
                  focusNode.requestFocus();
                }
              });
            },
          ),
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
              controller: titleController,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                hintText: 'Title here',
                hintStyle: TextStyle(color: gray300),
                border: InputBorder.none,
              ),
              canRequestFocus: !readOnly,
            ),
            if (!widget.isNewNote) ...[
              const Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Last Modified',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: gray500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      '17 June 2025, 03:35 PM',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: gray900,
                      ),
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Created',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: gray500,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Text(
                      '16 June 2025, 03:35 PM',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: gray900,
                      ),
                    ),
                  ),
                ],
              ),
            ],
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Row(
                    children: [
                      Text(
                        'Tags',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: gray500,
                        ),
                      ),
                      const SizedBox(width: 8),
                      NoteIconButton(
                        icon: FontAwesomeIcons.circlePlus,
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    'No tags added',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: gray900,
                    ),
                  ),
                ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(color: gray500, thickness: 2),
            ),
            // Note input area
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: TextField(
                controller: noteController,
                maxLines: null,
                expands: true,
                readOnly: readOnly,
                focusNode: focusNode,
                textAlignVertical: TextAlignVertical.top,
                style: TextStyle(fontSize: 16, color: colors.black),
                decoration: InputDecoration(
                  hintText: 'Write your note here...',
                  hintStyle: TextStyle(color: gray300),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(8.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
