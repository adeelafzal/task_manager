import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:task_manager/data/model/task_model.dart';
import 'package:task_manager/domain/entitie/task.dart';

class DatabaseHelper {
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await initDatabase();
    return _database;
  }

  Future<Database> initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'task_database.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('tasks');
    return List.generate(maps.length, (i) {
      return TaskModel.fromMap(maps[i]);
    });
  }

  Future<void> insertTask(TaskModel task) async {
    final db = await database;
    await db!.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteTask(int id) async {
    final db = await database;
    await db!.delete(
      'tasks',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}