import 'dart:convert';

import 'package:flutter/material.dart';

class CustomClipAvatar extends StatelessWidget {
  const CustomClipAvatar({super.key, required this.image});
final String image;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.memory(
          base64Decode(image),
          fit: BoxFit.cover,
          height: 60,
          width: 60,
        ),
      ),
    );
  }
}
