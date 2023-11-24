import 'package:kisiler/data/constants/database_constants.dart';
import 'package:kisiler/data/entity/task.dart';
import 'package:kisiler/sqlite/database_helper.dart';

class ToDoDaoRepository {
  Future<void> addTask(String task) async {
    var db = await DatabaseHelper.databaseAccess();

    var newTask = <String, dynamic>{};
    newTask["name"] = task;

    await db.insert(DatabaseConstants.databaseTableName, newTask);
  }

  Future<void> updateTask(int id, String task) async {
    var db = await DatabaseHelper.databaseAccess();

    var newTask = <String, dynamic>{};
    newTask["name"] = task;

    await db.update(DatabaseConstants.databaseTableName, newTask,
        where: "id = ?", whereArgs: [id]);
  }

  Future<List<Task>> uploadToDos() async {
    var db = await DatabaseHelper.databaseAccess();
    List<Map<String, dynamic>> rows = await db.rawQuery("select * from toDos");

    return List.generate(rows.length, (index) {
      var row = rows[index];
      var taskId = row["id"];
      var taskName = row["name"];

      return Task(id: taskId, task: taskName);
    });
  }

  Future<List<Task>> search(String word) async {
    var db = await DatabaseHelper.databaseAccess();
    List<Map<String, dynamic>> rows =
        await db.rawQuery("select * from toDos where name like '%$word%'");

    return List.generate(rows.length, (index) {
      var row = rows[index];
      var taskId = row["id"];
      var taskName = row["name"];

      return Task(id: taskId, task: taskName);
    });
  }

  Future<void> deleteTask(int id) async {
    var db = await DatabaseHelper.databaseAccess();

    await db.delete(DatabaseConstants.databaseTableName,
        where: "id = ?", whereArgs: [id]);
  }
}
