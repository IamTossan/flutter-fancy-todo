import 'package:flutter/material.dart';
import 'dart:math';

class FAB extends StatelessWidget {
  var onAdd;
  FAB({onAdd}) {
    this.onAdd = onAdd;
  }

  List<String> labels = [
    'brush my teeth',
    'buy groceries',
    'play video games',
    'do my homeworks',
    'feed my cats',
    'read a book',
    'learn a programming language',
  ];

  String generateTaskLabel() {
    var r = Random();
    return labels[r.nextInt(labels.length)];
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        onAdd(generateTaskLabel());
      },
      tooltip: 'Increment',
      child: Container(
        width: 60,
        height: 60,
        child: Icon(
          Icons.add,
          size: 40,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFF9E97),
              Color(0xFFFF5C7C),
            ],
          ),
        ),
      ),
    );
  }
}
