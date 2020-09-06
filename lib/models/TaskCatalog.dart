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

    Map<String, List<Task>> midPart = new Map.from(_tasks)..removeWhere((key, value) => key == 'others');

    return {
      'all': allCat.value,
      ...midPart,
      'others': _tasks['others'],
    };
  }

  List<Task> get currentTasks {
    List<Task> currentTasks = tasks[selectedCategory];
    List<Task> ongoingTasks = currentTasks.where((e) => e.isDone == false).toList();
    List<Task> finishedTasks = currentTasks.where((e) => e.isDone == true).toList();

    ongoingTasks.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    finishedTasks.sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    return [...ongoingTasks, ...finishedTasks];
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
