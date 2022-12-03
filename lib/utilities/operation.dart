import 'package:flutter/material.dart';

enum Operation {
  add('adding', Icon(Icons.add)),
  subtract('subtracting', Icon(Icons.minimize)),
  multiply('multiplication', Icon(Icons.cancel_outlined)),
  divide('division', Icon(Icons.architecture));

  final String descriptionOperation;
  final Icon iconOperation;

  const Operation(
      this.descriptionOperation,
      this.iconOperation,
      );
}
