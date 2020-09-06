class Task {
  String label;
  String category;
  bool isDone = false;
  DateTime createdAt;
  DateTime updatedAt;

  Task({this.label, this.category}) {
    this.createdAt = DateTime.now();
    this.updatedAt = DateTime.now();
  }
}
