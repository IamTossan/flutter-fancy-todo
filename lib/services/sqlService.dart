import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/Task.dart';

class SqlService {
  Future<Database> _database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'iamtossan_todo.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE tasks(id TEXT PRIMARY KEY, label TEXT, category TEXT, updatedAt TEXT, isDone INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<Map<String, List<Task>>> getTaskCollection() async {
    final Database db = await _database();

    final List<Map<String, dynamic>> res = await db.query('tasks');

    Map<String, List<Task>> taskCatalog = {};

    res.forEach((rawTask) {
      if (!taskCatalog.containsKey(rawTask['category'])) {
        taskCatalog[rawTask['category']] = [];
      }

      taskCatalog[rawTask['category']].add(
        Task(
          id: rawTask['id'],
          label: rawTask['label'],
          category: rawTask['category'],
          isDone: rawTask['isDone'] == 1,
          updatedAt: DateTime.fromMillisecondsSinceEpoch(
            int.parse(rawTask['updatedAt']),
          ),
        ),
      );
    });
    return taskCatalog;
  }

  Future<void> insertTask(Task newTask) async {
    final Database db = await _database();

    await db.insert(
      'tasks',
      newTask.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateTask(Task targetTask) async {
    final Database db = await _database();

    await db.update(
      'tasks',
      targetTask.toMap(),
      where: 'id = ?',
      whereArgs: [targetTask.id],
    );
  }

  Future<void> clear() async {
    final Database db = await _database();

    await db.delete('tasks');
  }
}
