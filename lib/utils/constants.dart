import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_fonts/google_fonts.dart';

const grey = Color(0xFFEAEAEA);
const grey2 = Color(0xFF6D6D6D);
const black = Color(0xFF1C1C1C);
const black2 = Color(0xFF424242);
const headerColor = Color.fromARGB(255, 90, 98, 98);
const white = Colors.white;

var headerRideStyle = GoogleFonts.roboto(
  // ignore: prefer_const_constructors
  textStyle: TextStyle(
    color: white,
    fontSize: 15.0,
  ),
);

var headerNotesStyle = GoogleFonts.roboto(
  // ignore: prefer_const_constructors
  textStyle: TextStyle(
    color: white,
    fontSize: 45.0,
    fontWeight: FontWeight.bold,
  ),
);

enum EditMode {
  // ignore: constant_identifier_names
  ADD,
  // ignore: constant_identifier_names
  UPDATE,
}

var noNotesStyle = GoogleFonts.roboto(
  // ignore: prefer_const_constructors
  textStyle: TextStyle(
    fontSize: 22.0,
    color: black2,
    fontWeight: FontWeight.w600,
  ),
);
var boldPlus = GoogleFonts.roboto(
  // ignore: prefer_const_constructors
  textStyle: TextStyle(
    fontSize: 30.0,
    color: Colors.blueAccent,
    fontWeight: FontWeight.bold,
  ),
);
var itemTitle = GoogleFonts.roboto(
  // ignore: prefer_const_constructors
  textStyle: TextStyle(
    fontSize: 18.0,
    color: black,
    fontWeight: FontWeight.bold,
  ),
);

var itemDateStyle = GoogleFonts.roboto(
  // ignore: prefer_const_constructors
  textStyle: TextStyle(
    fontSize: 11.0,
    color: grey2,
  ),
);

var itemContentStyle = GoogleFonts.roboto(
  // ignore: prefer_const_constructors
  textStyle: TextStyle(
    fontSize: 15.0,
    color: grey2,
  ),
);

var viewTitleStyle = GoogleFonts.roboto(
  fontWeight: FontWeight.w900,
  fontSize: 28.0,
);

var viewContentStyle = GoogleFonts.roboto(
    letterSpacing: 1.0,
    fontSize: 20.0,
    height: 1.5,
    fontWeight: FontWeight.w400);

var createTitle = GoogleFonts.roboto(
    // ignore: prefer_const_constructors
    textStyle: TextStyle(
  fontSize: 28.0,
  fontWeight: FontWeight.w900,
));

var createContent = GoogleFonts.roboto(
  // ignore: prefer_const_constructors
  textStyle: TextStyle(
    letterSpacing: 1.0,
    fontSize: 20.0,
    height: 1.5,
    fontWeight: FontWeight.w400,
  ),
);

var shadow = [
  // ignore: prefer_const_constructors
  BoxShadow(
    color: grey,
    blurRadius: 30,
    // ignore: prefer_const_constructors
    offset: Offset(0, 10),
  )
];
