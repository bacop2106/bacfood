import 'package:flutter/material.dart';
import 'package:foodonlineapapp/consts/colors.dart';

Widget loadingIndicator() {
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor),
  );
}
