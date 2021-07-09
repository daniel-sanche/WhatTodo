import 'package:flutter_app/db/app_db.dart';
import 'package:flutter_app/pages/tasks/models/tasks.dart';
import 'package:flutter_app/pages/projects/project.dart';
import 'package:flutter_app/pages/labels/label.dart';
import 'package:flutter_app/pages/tasks/models/task_labels.dart';
import 'package:sqflite/sqflite.dart';

class TaskDB {
  static final TaskDB _taskDb = TaskDB._internal([]);

  List<Tasks> _task_list;

  //private internal constructor to make it singleton
  TaskDB._internal(this._task_list);

  //static TaskDB get taskDb => _taskDb;

  static TaskDB get() {
    return _taskDb;
  }

  Future<List<Tasks>> getTasks(
      {int startDate = 0, int endDate = 0, TaskStatus? taskStatus}) async {
    return this._task_list;
  }


  Future<List<Tasks>> getTasksByProject(int projectId,
      {TaskStatus? status}) async {
    return this._task_list;
  }

  Future<List<Tasks>> getTasksByLabel(String labelName,
      {TaskStatus? status}) async {
    return this._task_list;
  }

  Future deleteTask(int taskID) async {
  }

  Future updateTaskStatus(int taskID, TaskStatus status) async {
  }

  /// Inserts or replaces the task.
  Future updateTask(Tasks task, {List<int>? labelIDs}) async {
    this._task_list.add(task);
  }
}
