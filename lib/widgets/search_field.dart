import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../change_notifiers/notes_provider.dart';
import '../core/constants.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search notes...',
        hintStyle: TextStyle(fontSize: 12),
        prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass, size: 16),
        fillColor: white,
        filled: true,
        isDense: true,
        contentPadding: EdgeInsets.zero,
        prefixIconConstraints: BoxConstraints(minWidth: 42, minHeight: 42),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primary),
        ),
      ),
      onChanged: (newValue) {
        context.read<NotesProvider>().searchTerm = newValue;
      },
    );
  }
}
