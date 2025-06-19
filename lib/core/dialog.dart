import 'package:flutter/material.dart';
import 'package:project_note/widgets/dialog_card.dart';

import '../widgets/confirmation_dialog.dart';
import '../widgets/new_tag_dialog.dart';

Future<String?> showNewTagDialog({required BuildContext context, String? tag}) {
  return showDialog<String?>(
    context: context,
    builder: (context) => DialogCard(child: NewTagDialog(tag: tag)),
  );
  
}

Future<bool?> showConfirmationDialog({required BuildContext context}) {
  return showDialog<bool?>(
          context: context,
          builder: (_) => DialogCard(child: ConfirmationDialog()),
        );
}
