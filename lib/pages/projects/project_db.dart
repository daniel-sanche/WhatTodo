import 'package:flutter_app/db/app_db.dart';
import 'package:flutter_app/pages/projects/project.dart';
import 'package:sqflite/sqflite.dart';

class ProjectDB {
  static final ProjectDB _projectDb = ProjectDB._internal([]);

  List<Project> _project_list;

  //private internal constructor to make it singleton
  ProjectDB._internal(this._project_list);

  static ProjectDB get() {
    return _projectDb;
  }

  Future<List<Project>> getProjects({bool isInboxVisible = true}) async {
    return this._project_list;
  }

  Future insertOrReplace(Project project) async {
    this._project_list.add(project);
  }

  Future deleteProject(int projectID) async {

  }
}
