import 'package:flutter/material.dart';

extension Sizedbox on num {
  SizedBox get gap => SizedBox(width: toDouble(), height: toDouble());
}
