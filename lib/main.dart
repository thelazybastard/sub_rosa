import 'package:flutter/material.dart';
import 'package:sub_rosa/ui/translate.dart';

void main() {
  runApp(Rosa());
}

class Rosa extends StatelessWidget {
  const Rosa({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Translate(),
    );
  }
}