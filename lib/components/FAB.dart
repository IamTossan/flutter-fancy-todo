import 'package:flutter/material.dart';

import './BottomForm.dart';

class FAB extends StatelessWidget {
  var onAdd;
  var context;
  FAB({onAdd, context}) {
    this.onAdd = onAdd;
    this.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        setBottomForm(context, 'task', onAdd);
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
