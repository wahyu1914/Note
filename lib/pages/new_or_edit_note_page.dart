import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_note/change_notifiers/new_note_controller.dart';
import 'package:project_note/core/constants.dart';
import 'package:project_note/core/constants.dart' as colors;
import 'package:project_note/widgets/note_icon_button.dart';
import 'package:project_note/widgets/note_icon_button_outlined.dart';
import 'package:provider/provider.dart';

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
  late final NewNoteController newNoteController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    newNoteController = context.read<NewNoteController>();

    focusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.isNewNote) {
        focusNode.requestFocus();
        newNoteController.readOnly = false;
      } else {
        newNoteController.readOnly = true;
      }
    });
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
          Selector<NewNoteController, bool>(
            selector: (context, newNoteController) =>
                newNoteController.readOnly,
            builder: (context, readOnly, child) => NoteIconButtonOutlined(
              icon: readOnly ? FontAwesomeIcons.pen : FontAwesomeIcons.bookOpen,
              onPressed: () {
                newNoteController.readOnly = !readOnly;
                if (newNoteController.readOnly) {
                  FocusScope.of(context).unfocus();
                } else {
                  focusNode.requestFocus();
                }
              },
            ),
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
            Selector<NewNoteController, bool>(
              selector: (context, controller) => controller.readOnly,
              builder: (context, readOnly, child) => TextField(
                controller: titleController,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                decoration: const InputDecoration(
                  hintText: 'Title here',
                  hintStyle: TextStyle(color: gray300),
                  border: InputBorder.none,
                ),
                canRequestFocus: !readOnly,
                onChanged: (newValue) {
                  newNoteController.title = newValue;
                },
              ),
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
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => Material(
                              child: Column(
                                children: [
                                  Text('Add tag'),
                                  TextField(
                                    decoration: InputDecoration(
                                      hintText: 'Add tag (< 16 characters)',
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {},
                                    child: Text('Add tag'),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
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
            Selector<NewNoteController, bool>(
              selector: (_, controller) => controller.readOnly,
              builder: (_, readOnly, __) => SizedBox(
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
            ),
          ],
        ),
      ),
    );
  }
}
