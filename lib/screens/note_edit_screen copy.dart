import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bloc_note_flutter/helper/note_provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:image_picker/image_picker.dart';
import 'package:bloc_note_flutter/utils/constants.dart';
import 'package:path/path.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:path_provider/path_provider.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:provider/provider.dart';
import '../models/note.dart';
import '../widgets/delete_popup.dart';
import 'note_view_screen.dart';

// ignore: use_key_in_widget_constructors
class NoteEditScreen extends StatefulWidget {
  static const route = '/edit-note';
  @override
  // ignore: library_private_types_in_public_api
  _NoteEditScreenState createState() => _NoteEditScreenState();
}

class _NoteEditScreenState extends State {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  // ignore: avoid_init_to_null
  File? _image;
  final picker = ImagePicker();

  bool firstTime = true;
  Note? selectedNote;
  int? id;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (firstTime) {
      id = ModalRoute.of(this.context)!.settings.arguments as int;

      if (id != null) {
        selectedNote =
            Provider.of<NoteProvider>(this.context, listen: false).getNote(id!);

        titleController.text = selectedNote!.title;
        contentController.text = selectedNote!.content;

        if (selectedNote?.imagePath != null) {
          _image = File(selectedNote!.imagePath);
        }
      }

      firstTime = false;
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
          onPressed: () => Navigator.of(context).pop(),
          // ignore: prefer_const_constructors
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        actions: [
          IconButton(
            // ignore: prefer_const_constructors
            icon: Icon(Icons.photo_camera),
            color: Colors.black,
            onPressed: () {
              getImage(ImageSource.camera);
            },
          ),
          IconButton(
            // ignore: prefer_const_constructors
            icon: Icon(Icons.insert_photo),
            color: Colors.black,
            onPressed: () {
              getImage(ImageSource.gallery);
            },
          ),
          IconButton(
            // ignore: prefer_const_constructors
            icon: Icon(Icons.delete),
            color: Colors.black,
            onPressed: () {
              if (id != null) {
                _showDialog();
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              // ignore: prefer_const_constructors
              padding: EdgeInsets.only(
                  left: 10.0, right: 5.0, top: 10.0, bottom: 5.0),
              child: TextField(
                controller: titleController,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                style: createTitle,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                    hintText: 'Titre de la note', border: InputBorder.none),
              ),
            ),
            if (_image != null)
              Container(
                // ignore: prefer_const_constructors
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width,
                height: 250.0,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          image: FileImage(_image!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        // ignore: prefer_const_constructors
                        padding: EdgeInsets.all(12.0),
                        child: Container(
                          height: 30.0,
                          width: 30.0,
                          // ignore: prefer_const_constructors
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(
                                () {
                                  _image = null;
                                },
                              );
                            },
                            // ignore: prefer_const_constructors
                            child: Icon(
                              Icons.delete,
                              size: 16.0,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 5.0, top: 10.0, bottom: 5.0),
              child: TextField(
                controller: contentController,
                maxLines: null,
                style: createContent,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  hintText: 'Commencer à écrire...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (titleController.text.isEmpty)
            // ignore: curly_braces_in_flow_control_structures
            titleController.text = 'Note sans nom';
          saveNote();
        },
        // ignore: prefer_const_constructors
        child: Icon(Icons.save),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

//  void useCamera() async {
//    await availableCameras().then((value) => Navigator.push(context,
//        MaterialPageRoute(builder: (_) => CameraPage(cameras: value))));
//  }

  void getImage(ImageSource imageSource) async {
    PickedFile imageFile = await picker.getImage(source: imageSource);

    // ignore: unnecessary_null_comparison
    if (imageFile == null) return;

    File tmpFile = File(imageFile.path);
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = basename(imageFile.path);

    tmpFile = await tmpFile.copy('${appDir.path}/$fileName');

    setState(() {
      _image = tmpFile;
    });
  }

  void saveNote() {
    String title = titleController.text.trim();
    String content = contentController.text.trim();
    String? imagePath = _image != null ? _image!.path : null;

    if (id != null) {
      Provider.of<NoteProvider>(this.context, listen: false)
          .addOrUpdateNote(id!, title, content, imagePath!, EditMode.UPDATE);
      Navigator.of(this.context).pop();
    } else {
      int id = DateTime.now().millisecondsSinceEpoch;
      Provider.of<NoteProvider>(this.context, listen: false)
          .addOrUpdateNote(id, title, content, imagePath!, EditMode.ADD);
      Navigator.of(this.context)
          .pushReplacementNamed(NoteViewScreen.route, arguments: id);
    }
  }

  void _showDialog() {
    showDialog(
        context: this.context,
        builder: (context) {
          return DeletePopUp(selectedNote: selectedNote!);
        });
  }
}
