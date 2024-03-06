import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.deepOrange,
      width: 2.5
    )
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.green,
      width: 5.0
    )
  )
);