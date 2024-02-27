

import 'package:flutter/material.dart';

SnackBar message() {
  return const SnackBar(
    content: Center(child: Text('Please enter  city name.')),
    duration: Duration(seconds: 3),
  );
}