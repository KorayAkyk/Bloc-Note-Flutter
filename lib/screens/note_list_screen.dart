import 'package:bloc_note_flutter/utils/constants.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

import '../helper/note_provider.dart';
import '../widgets/list_item.dart';
import 'note_edit_screen.dart';

// ignore: use_key_in_widget_constructors
class NoteListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<NoteProvider>(context, listen: false).getNotes(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // ignore: prefer_const_constructors
          return Scaffold(
            // ignore: prefer_const_constructors
            body: Center(
              // ignore: prefer_const_constructors
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              body: Consumer<NoteProvider>(
                child: noNotesUI(context),
                builder: (context, noteprovider, child) =>
                    // ignore: prefer_is_empty
                    noteprovider.items.length <= 0
                        ? child
                        : ListView.builder(
                            itemCount: noteprovider.items.length + 1,
                            itemBuilder: (context, index) {
                              if (index == 0) {
                                return header();
                              } else {
                                final i = index - 1;
                                final item = noteprovider.items[i];
                                return ListItem(
                                  id: item.id,
                                  title: item.title,
                                  content: item.content,
                                  imagePath: item.imagePath,
                                  date: item.date,
                                );
                              }
                            },
                          ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  goToNoteEditScreen(context);
                },
                child: const Icon(Icons.add),
              ),
            );
          }
        }
        // ignore: sized_box_for_whitespace
        return Container(
          width: 0.0,
          height: 0.0,
        );
      },
    );
  }

  Widget header() {
    return GestureDetector(
      onTap: _launchUrl,
      child: Container(
        decoration: const BoxDecoration(
          color: headerColor,
        ),
        height: 100,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bloc note',
              style: headerNotesStyle,
            ),
            Text(
              'Koray',
              style: headerRideStyle,
            ),
          ],
        ),
      ),
    );
  }

  _launchUrl() async {
    const url = 'https://github.com/KorayAkyk/Bloc-Note-Flutter';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Impossible de lancer $url';
    }
  }

  Widget noNotesUI(BuildContext context) {
    return ListView(
      children: [
        header(),
        Column(
          children: [
            RichText(
              text: TextSpan(
                style: noNotesStyle,
                children: [
                  const TextSpan(text: 'Pas de note \n Tape sur "'),
                  TextSpan(
                      text: '+',
                      style: boldPlus,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          goToNoteEditScreen(context);
                        }),
                  const TextSpan(text: '" nouvelle note'),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  void goToNoteEditScreen(BuildContext context) {
    Navigator.of(context).pushNamed(NoteEditScreen.route);
  }
}
