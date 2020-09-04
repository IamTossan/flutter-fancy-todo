import 'package:flutter/material.dart';

import '../models/Task.dart';

class TaskList extends StatefulWidget {
  final List<Task> todoList;
  final Function onDone;

  const TaskList({Key key, this.todoList, this.onDone}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    const checkedIcon = Icon(
      Icons.check_circle_outline,
      color: Color(0xFF35DF31),
    );

    const uncheckedIcon = Icon(
      Icons.radio_button_unchecked,
      color: Color(0xFF5859F9),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'tasks',
          style: textTheme.subtitle1,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          height: 300.0,
          child: ListView.builder(
            itemCount: widget.todoList.length,
            itemBuilder: (_, int idx) {
              var t = widget.todoList[idx];
              return Container(
                child: GestureDetector(
                  onTap: () {
                    widget.onDone(t);
                  },
                  child: Row(
                    children: [
                      IconButton(
                        icon: t.isDone ? checkedIcon : uncheckedIcon,
                      ),
                      Text(
                        '${t.label} (${t.category})',
                        style: TextStyle(
                            decoration: t.isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
