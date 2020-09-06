import "package:flutter_test/flutter_test.dart";
import "package:todo/models/Task.dart";

void main() {
  test('should have a label', () {
    const testLabel = 'testLabel';
    final task = Task(label: testLabel);

    expect(task.label, testLabel);
  });

  test('should have a category', () {
    const testCategory = 'testCategory';
    final task = Task(category: testCategory);

    expect(task.category, testCategory);
  });

  test('should have datetime field set', () {
    const testLabel = 'testLabel';
    final task = Task(label: testLabel);

    expect(task.createdAt, isA<DateTime>());
    expect(task.updatedAt, isA<DateTime>());
  });
}