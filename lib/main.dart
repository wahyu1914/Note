import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_note/change_notifiers/notes_provider.dart';
import 'package:project_note/core/constants.dart';
import 'package:project_note/firebase_options.dart';
import 'package:project_note/pages/registration_page.dart';
import 'package:provider/provider.dart';

import 'pages/main_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotesProvider(),
      child: MaterialApp(
        title: 'Project Notes',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: 'Poppins',
          scaffoldBackgroundColor: background,
          appBarTheme: Theme.of(context).appBarTheme.copyWith(
            backgroundColor: Colors.transparent,
            titleTextStyle: const TextStyle(
              color: primary,
              fontSize: 32,
              fontFamily: 'Fredoka',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        home: const RegistrationPage(),
      ),
    );
  }
}
