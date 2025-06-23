import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:project_note/Services/auth_service.dart';
import 'package:project_note/change_notifiers/new_note_controller.dart';
import 'package:project_note/change_notifiers/notes_provider.dart';
import 'package:project_note/core/dialog.dart';
import 'package:project_note/pages/new_or_edit_note_page.dart';
import 'package:project_note/widgets/no_notes.dart';
import 'package:project_note/widgets/note_icon_button_outlined.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';
import '../widgets/note_fab.dart';
import '../widgets/note_grid.dart';
import '../widgets/notes_list.dart';
import '../widgets/search_field.dart';
import '../widgets/view_options.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Multiplatform Notes'),
        actions: [
          NoteIconButtonOutlined(
            icon: FontAwesomeIcons.arrowRightFromBracket,
            onPressed: () async {
              final bool shouldLogout =
                  await showConfirmationDialog(
                    context: context,
                    title: "Do you want to sign out?",
                  ) ??
                  false;
                  if (shouldLogout) AuthService.logout();
              AuthService.logout();
            },
          ),
        ],
      ),
      floatingActionButton: NoteFab(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangeNotifierProvider(
                create: (context) => NewNoteController(),
                child: const NewOrEditNotePage(isNewNote: true),
              ),
            ),
          );
        },
      ),
      body: Consumer<NotesProvider>(
        builder: (context, notesProvider, child) {
          final List<Note> notes = notesProvider.notes;
          return notes.isEmpty && notesProvider.searchTerm.isEmpty
              ? const NoNotes()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const SearchField(),
                      if (notes.isNotEmpty) ...[
                        const ViewOptions(),
                        Expanded(
                          child: notesProvider.isGrid
                              ? NotesGrid(notes: notes)
                              : NotesList(notes: notes),
                        ),
                      ] else
                        Expanded(
                          child: Center(
                            child: Text(
                              'No notes found for your search query!',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
