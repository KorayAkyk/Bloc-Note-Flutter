// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:io';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:bloc_note_flutter/helper/note_provider.dart';
// ignore: unused_import
import 'package:bloc_note_flutter/screens/note_edit_screen.dart';
import 'package:bloc_note_flutter/screens/note_view_screen.dart';
// ignore: unused_import
import 'package:provider/provider.dart';
import '../utils/constants.dart';

class ListItem extends StatelessWidget {
  final int? id;
  final String? title;
  final String? content;
  final String? imagePath;
  final String? date;
  // ignore: prefer_const_constructors_in_immutables, use_key_in_widget_constructors
  ListItem({this.id, this.title, this.content, this.imagePath, this.date});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 135.0,
      // ignore: prefer_const_constructors
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, NoteViewScreen.route, arguments: id);
        },
        child: Container(
          width: double.infinity,
          // ignore: prefer_const_constructors
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: shadow,
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: grey, width: 1.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  // ignore: prefer_const_constructors
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: itemTitle,
                      ),
                      // ignore: prefer_const_constructors
                      SizedBox(height: 4.0),
                      Text(
                        date!,
                        overflow: TextOverflow.ellipsis,
                        style: itemDateStyle,
                      ),
                      // ignore: prefer_const_constructors
                      SizedBox(
                        height: 8.0,
                      ),
                      Expanded(
                        child: Text(
                          content!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: itemContentStyle,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (imagePath != null)
                Row(
                  children: [
                    // ignore: prefer_const_constructors
                    SizedBox(
                      width: 12.0,
                    ),
                    Container(
                      width: 80.0,
                      height: 95.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        image: DecorationImage(
                          image: FileImage(
                            File(imagePath!),
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
