import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_note/change_notifiers/new_note_controller.dart';
import 'package:project_note/core/constants.dart';
import 'package:project_note/core/dialog.dart';
import 'package:project_note/core/utils.dart';
import 'package:project_note/models/note.dart';
import 'package:project_note/widgets/dialog_card.dart';
import 'package:project_note/widgets/new_tag_dialog.dart';
import 'package:project_note/widgets/note_icon_button.dart';
import 'package:project_note/widgets/note_tag.dart';
import 'package:provider/provider.dart';

class NoteMetadata extends StatefulWidget {
  const NoteMetadata({required this.note, super.key});

  final Note? note;

  @override
  State<NoteMetadata> createState() => _NoteMetadataState();
}

class _NoteMetadataState extends State<NoteMetadata> {
  late final NewNoteController newNoteController;

  @override
  void initState() {
    super.initState();

    newNoteController = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.note != null) ...[
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
                  toLongDate(widget.note!.dateModified),
                  style: TextStyle(fontWeight: FontWeight.bold, color: gray900),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  'Created',
                  style: TextStyle(fontWeight: FontWeight.bold, color: gray500),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  toLongDate(widget.note!.dateCreated),
                  style: TextStyle(fontWeight: FontWeight.bold, color: gray900),
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
                    onPressed: () async {
                      final String? tag = await showNewTagDialog(
                        context: context,
                      );

                      if (tag != null) {
                        newNoteController.addTag(tag);
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 5,
              child: Selector<NewNoteController, List<String>>(
                selector: (_, newNoteController) => newNoteController.tags,
                builder: (_, tags, __) => tags.isEmpty
                    ? Text(
                        'No tags added',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: gray900,
                        ),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: List.generate(
                            tags.length,
                            (index) => NoteTag(
                              label: tags[index],
                              onClosed: () {
                                newNoteController.removeTag(index);
                              },
                              onTap: () async {
                                final String? tag = await showNewTagDialog(
                                  context: context,
                                  tag: tags[index],
                                );

                                if (tag != null && tag != tag[index]) {
                                  newNoteController.updateTag(tag, index);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
