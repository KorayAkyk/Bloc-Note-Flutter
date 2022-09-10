// ignore: import_of_legacy_library_into_null_safe
import 'package:intl/intl.dart';

class Note {
  // ignore: prefer_final_fields
  int _id;
  // ignore: prefer_final_fields
  String _title;
  // ignore: prefer_final_fields
  String _content;
  // ignore: prefer_final_fields
  String _imagePath;

  Note(this._id, this._title, this._content, this._imagePath);

  int get id => _id;
  String get title => _title;
  String get content => _content;
  String get imagePath => _imagePath;

  String get date {
    final date = DateTime.fromMillisecondsSinceEpoch(id);
    return DateFormat('EEE h:mm a, dd/MM/yyyy').format(date);
  }
}
