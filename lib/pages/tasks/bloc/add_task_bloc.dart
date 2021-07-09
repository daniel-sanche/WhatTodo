import 'dart:async';

import 'package:flutter_app/bloc/bloc_provider.dart';
import 'package:flutter_app/models/priority.dart';
import 'package:flutter_app/pages/projects/project.dart';
import 'package:flutter_app/pages/projects/project_db.dart';
import 'package:flutter_app/pages/tasks/models/tasks.dart';
import 'package:flutter_app/pages/tasks/task_db.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class AddTaskBloc implements BlocBase {
  final TaskDB _taskDB;
  final ProjectDB _projectDB;
  Status lastPrioritySelection = Status.PRIORITY_4;

  AddTaskBloc(this._taskDB, this._projectDB) {
    _loadProjects();
    updateDueDate(DateTime.now().millisecondsSinceEpoch);
    _projectSelection.add(Project.getInbox());
    _prioritySelected.add(lastPrioritySelection);
  }

  BehaviorSubject<List<Project>> _projectController =
      BehaviorSubject<List<Project>>();

  Stream<List<Project>> get projects => _projectController.stream;

  BehaviorSubject<Project> _projectSelection = BehaviorSubject<Project>();

  Stream<Project> get selectedProject => _projectSelection.stream;

  BehaviorSubject<Status> _prioritySelected = BehaviorSubject<Status>();

  Stream<Status> get prioritySelected => _prioritySelected.stream;

  BehaviorSubject<int> _dueDateSelected = BehaviorSubject<int>();

  Stream<int> get dueDateSelected => _dueDateSelected.stream;

  String updateTitle = "";

  @override
  void dispose() {
    _projectController.close();
    _projectSelection.close();
    _prioritySelected.close();
    _dueDateSelected.close();
  }

  void _loadProjects() {
    _projectDB.getProjects(isInboxVisible: true).then((projects) {
      _projectController.add(List.unmodifiable(projects));
    });
  }

  void projectSelected(Project project) {
    _projectSelection.add(project);
  }

  void updatePriority(Status priority) {
    _prioritySelected.add(priority);
    lastPrioritySelection = priority;
  }

  Stream createTask() {
    return ZipStream.zip3(selectedProject, dueDateSelected, prioritySelected,
        (Project project, int dueDateSelected, Status status) {

      var task = Tasks.create(
        title: updateTitle,
        dueDate: dueDateSelected,
        priority: status,
        projectId: project.id!,
      );

      _taskDB.updateTask(task).then((task) {
        Notification.onDone();
      });
    });
  }

  void updateDueDate(int millisecondsSinceEpoch) {
    _dueDateSelected.add(millisecondsSinceEpoch);
  }
}
