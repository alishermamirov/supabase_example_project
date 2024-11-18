import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final noteController = TextEditingController();

  void showAddNote(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add note"),
          content: TextField(
            controller: noteController,
          ),
          actions: [
            TextButton(
              onPressed: () {
                saveNote();
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }

  //save note to supabase
  void saveNote() async {
    await Supabase.instance.client
        .from("notes")
        .insert({"body": noteController.text});
  }

  // get notes from supabase

  final noteStream =
      Supabase.instance.client.from("notes").stream(primaryKey: ["id"]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Supabase example"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: noteStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            final data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final note = data[index];

                return ListTile(
                  title: Text(note["body"]),
                );
              },
            );
          }
          return const Center(
            child: Text("Malumot mavjud emas"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddNote(context),
        child: Text("add"),
      ),
    );
  }
}
