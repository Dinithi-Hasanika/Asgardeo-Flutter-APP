import 'package:flutter/material.dart';

import '../constants/strings.dart';

class DisplayText extends StatelessWidget{
  final String content;

  const DisplayText(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
  return Text(
    content,
    maxLines: 2,
    softWrap: true,
    style: const TextStyle(fontSize: 18),
  );
  }

}

class DisplayLabel extends StatelessWidget{
  final String content;

  const DisplayLabel(this.content, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(content, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }

}