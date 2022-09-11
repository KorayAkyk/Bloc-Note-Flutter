import 'dart:io';

import 'package:flutter/material.dart';
import 'package:bloc_note_flutter/helper/note_provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../utils/constants.dart';
import '../widgets/delete_popup.dart';
import 'note_edit_screen.dart';

// ignore: use_key_in_widget_constructors
class NoteViewScreen extends StatefulWidget {
  static const route = '/note-view';

  @override
  // ignore: library_private_types_in_public_api
  _NoteViewScreenState createState() => _NoteViewScreenState();
}

class _NoteViewScreenState extends State {
  Note? selectedNote;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final id = ModalRoute.of(context)!.settings.arguments;

    final provider = Provider.of<NoteProvider>(context);

    // ignore: unnecessary_null_comparison
    if (provider.getNote(id as int) != null) {
      selectedNote = provider.getNote(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0.7,
        backgroundColor: Colors.white,
        leading: IconButton(
          // ignore: prefer_const_constructors
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            // ignore: prefer_const_constructors
            icon: Icon(
              Icons.delete,
              color: Colors.black,
            ),
            onPressed: () => _showDialog(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                selectedNote?.title as String,
                style: viewTitleStyle,
              ),
            ),
            Row(
              children: [
                // ignore: prefer_const_constructors
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  // ignore: prefer_const_constructors
                  child: Icon(
                    Icons.access_time,
                    size: 18,
                  ),
                ),
                Text('${selectedNote?.date}')
              ],
            ),
            // ignore: unnecessary_null_comparison
            if (selectedNote!.imagePath != "")
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Image.file(File(selectedNote!.imagePath)),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                selectedNote!.content,
                style: viewContentStyle,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NoteEditScreen.route,
              arguments: selectedNote!.id);
        },
        // ignore: prefer_const_constructors
        child: Icon(Icons.edit),
      ),
    );
  }

  _showDialog() {
    showDialog(
        // ignore: unnecessary_this
        context: this.context,
        builder: (context) {
          return DeletePopUp(selectedNote: selectedNote!);
        });
  }
}
