import 'package:flutter/material.dart';
import '../helper/note_provider.dart';
import '../models/note.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';

class DeletePopUp extends StatelessWidget {
  const DeletePopUp({
    Key? key,
    required this.selectedNote,
  }) : super(key: key);

  final Note selectedNote;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      // ignore: prefer_const_constructors
      title: Text('Supprimer ?'),
      // ignore: prefer_const_constructors
      content: Text('Êtes-vous sûr de vouloir supprimer cette note ?'),
      actions: [
        TextButton(
          // ignore: prefer_const_constructors
          child: Text('Oui'),
          onPressed: () {
            Provider.of<NoteProvider>(context, listen: false)
                .deleteNote(selectedNote.id);
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        ),
        TextButton(
          // ignore: prefer_const_constructors
          child: Text('Non'),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }
}
