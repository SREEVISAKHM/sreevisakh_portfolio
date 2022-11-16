import 'package:flutter/material.dart';

class FooterItemModel {
  final IconData iconData;
  final String title;
  final String text1;
  final String text2;
  final VoidCallback? onTap;

  FooterItemModel({
    this.onTap,
    required this.iconData,
    required this.title,
    required this.text1,
    required this.text2,
  });
}
