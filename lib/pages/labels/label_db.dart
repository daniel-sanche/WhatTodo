import 'package:flutter_app/db/app_db.dart';
import 'package:flutter_app/pages/labels/label.dart';
import 'package:sqflite/sqflite.dart';

class LabelDB {
  static final LabelDB _labelDb = LabelDB._internal();

  //private internal constructor to make it singleton
  LabelDB._internal();

  static LabelDB get() {
    return _labelDb;
  }

  Future<bool> isLabelExits(Label label) async {
    return false;
  }

  Future updateLabels(Label label) async {

  }

  Future<List<Label>> getLabels() async {

    return [];
  }

  Future deleteLabel(int labelId) async {
  }
}
