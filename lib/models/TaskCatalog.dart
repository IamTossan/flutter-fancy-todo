import './Task.dart';

class TaskCatalog {
  Map<String, List<Task>> _tasks = {'others': []};
  String selectedCategory = 'all';

  String addCategory(String newCategory) {
    if (tasks.keys.contains(newCategory)) {
      return null;
    }

    _tasks[newCategory] = [];
    return newCategory;
  }

  Map<String, List<Task>> get tasks {
    MapEntry allCat = _tasks.entries.reduce((value, element) {
      List<Task> reducedValue = [...value.value, ...element.value];
      return MapEntry('all', reducedValue);
    });

    return {
      'all': allCat.value,
      ..._tasks,
    };
  }

  List<Task> get currentTasks {
    return tasks[selectedCategory];
  }

  void updateSelectedCategory(newCategory) {
    selectedCategory = newCategory;
  }

  String addTask(String taskLabel) {
    if (selectedCategory == 'all') {
      _tasks['others'].add(Task(label: taskLabel, category: 'others'));
    } else {
      _tasks[selectedCategory]
          .add(Task(label: taskLabel, category: selectedCategory));
    }

    return taskLabel;
  }

  void updateTaskStatus(Task targetTask) {
    String targetCategory = targetTask.category;
    var taskIndex = _tasks[targetCategory].indexOf(targetTask);
    _tasks[targetCategory][taskIndex].isDone =
        !_tasks[targetCategory][taskIndex].isDone;
  }
}
