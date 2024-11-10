import 'package:flutter/material.dart';
import 'package:supabase_example_project/screens/notes_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://vcgcfaezavetucbxfcwp.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZjZ2NmYWV6YXZldHVjYnhmY3dwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzEyNDY0MDAsImV4cCI6MjA0NjgyMjQwMH0.kNOPtv2XuvD-sX-ZDX2esX-Qd5FG0GiKAq3_2N2nzLw",
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NotesScreen(),
    );
  }
}
