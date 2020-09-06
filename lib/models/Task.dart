import 'package:uuid/uuid.dart';

class Task {
  String id;
  String label;
  String category;
  bool isDone;
  DateTime createdAt;
  DateTime updatedAt;

  Task({this.label, this.category, id, updatedAt, isDone}) {
    this.id = id ?? Uuid().v1();
    this.createdAt = DateTime.now();
    this.updatedAt = updatedAt ?? DateTime.now();
    this.isDone = isDone ?? false;
  }

  toMap() {
    return {
      'id': id,
      'label': label,
      'category': category,
      'isDone': isDone == true ? 1 : 0,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  @override
  String toString() {
    return '\nTask{id: $id, label: $label, category: $category, isDone: $isDone, updatedAt: $updatedAt}';
  }
}
