import 'package:database_local/data/local/db_helper.dart';
import 'package:flutter/material.dart';

class DbProvider extends ChangeNotifier{
  DbHelper dbHelper ;
  DbProvider ({required this.dbHelper});
  List<Map<String, dynamic>> _mData = [];


  Future<void> addNote(String title, String desc) async {
   bool check = await dbHelper.addNote(mTitle: title, mDesc: desc);
   if(check){
     _mData = await dbHelper.getAllNote();
     notifyListeners();
   }
  }

  List<Map<String, dynamic>> getNotes() => _mData;

  Future<void> getIntitialNotes() async {
    _mData = await dbHelper.getAllNote();
    notifyListeners();
  }
}