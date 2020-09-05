import 'package:flutter/material.dart';

import 'models/Task.dart';
import 'models/TaskCatalog.dart';

import 'components/CategoryList.dart';
import 'components/TaskList.dart';
import 'components/FAB.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,

        textTheme: Theme.of(context).textTheme.apply(
              fontSizeFactor: 0.75,
            ),
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TaskCatalog taskCatalog = TaskCatalog();

  void addTodo(String newTodo) {
    setState(() {
      taskCatalog.addTask(newTodo);
    });
  }

  void updateTaskStatus(Task targetTodo) {
    setState(() {
      taskCatalog.updateTaskStatus(targetTodo);
    });
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
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

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
