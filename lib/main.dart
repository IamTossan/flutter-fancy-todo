import 'package:flutter/material.dart';

import 'models/Task.dart';
import 'models/TaskCatalog.dart';

import 'services/sqlService.dart';

import 'components/CategoryList.dart';
import 'components/TaskList.dart';
import 'components/FAB.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: Theme.of(context).textTheme.apply(
              fontSizeFactor: 0.75,
            ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TaskCatalog taskCatalog = TaskCatalog();
  final db = SqlService();

  Future getTaskCatalog() async {
    var taskCollection = await db.getTaskCollection();
    print(taskCollection);
    return taskCollection;
  }

  @override
  void initState() {
    super.initState();

    getTaskCatalog().then((res) {
      setState(() {
        taskCatalog = TaskCatalog(tasks: res);
      });
    });
  }

  Future addTodo(String newTaskLabel) async {
    Task newTask;

    setState(() {
      newTask = taskCatalog.addTask(newTaskLabel);
    });

    await db.insertTask(newTask);
  }

  void updateTaskStatus(Task targetTodo) async {
    Task targetTask;

    setState(() {
      targetTask = taskCatalog.updateTaskStatus(targetTodo);
    });

    await db.updateTask(targetTask);
  }

  void updateSelectedCategory(String newCategory) {
    setState(() {
      taskCatalog.updateSelectedCategory(newCategory);
    });
  }

  void addCategory(String newCategory) {
    setState(() {
      taskCatalog.addCategory(newCategory);
      taskCatalog.updateSelectedCategory(newCategory);
    });
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'Mornin\' all',
                    style: textTheme.headline3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: CategoryList(
                    selectedCategory: taskCatalog.selectedCategory,
                    categories: taskCatalog.tasks,
                    onSelectCategory: updateSelectedCategory,
                    onAddCategory: addCategory,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: TaskList(
                    todoList: taskCatalog.currentTasks,
                    onDone: updateTaskStatus,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FAB(
        onAdd: addTodo,
        context: context,
      ),
    );
  }
}
