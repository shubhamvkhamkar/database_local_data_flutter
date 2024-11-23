import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper{

  // Singleton
  DbHelper._();

  static DbHelper getInstance = DbHelper._();
  //table note
  static final String TABLENAME = 'note';
  static final String COLUMN_NOTE_SNO = 's_no';
  static final String COLUMN_NOTE_TITEL = 'title';
  static final String COLUMN_NOTE_DESC = 'desc';

  Database? myDB;

  Future<Database> getDB() async {

   /* myDB ??= await openDB();
    return myDB!;*/
    if(myDB!=null){
      return myDB!;
    }else{
     myDB = await openDB();
     return myDB!;
    }
  }
  ///DB open (path-> if exits then open else create
  Future<Database> openDB() async {
    Directory appDir = await getApplicationDocumentsDirectory();
    
    String dirPath = join(appDir.path, "noteDB.db");
    return await openDatabase(dirPath, onCreate: (db, version){
      
      db.execute('create table $TABLENAME ($COLUMN_NOTE_SNO integer primary key autoincrement, $COLUMN_NOTE_TITEL text, $COLUMN_NOTE_DESC text)');
      
    }, version:1);
  }
  
  

  /// all queries

  /// insertion
  Future<bool> addNote({required String mTitle, required String mDesc}) async {
   var db = await getDB();

   int rowsEffected = await db.insert(TABLENAME, {
     COLUMN_NOTE_TITEL : mTitle,
     COLUMN_NOTE_DESC : mDesc
   });
   return rowsEffected>0;
  }
   /// reading all data
  Future<List<Map<String, dynamic>>> getAllNote () async {

    var db = await getDB();
    //select * form table
    List<Map<String, dynamic>> mData = await db.query(TABLENAME,);
    return mData;
  }

  /// update Data
  Future<bool> updateNote ({required String title, required String desc, required int sno}) async{
    var db = await getDB();
   int rowsEffected =  await db.update(TABLENAME, {
      COLUMN_NOTE_TITEL : title,
      COLUMN_NOTE_DESC : desc}, where: "$COLUMN_NOTE_SNO = $sno");

   return rowsEffected>0;
  }

  /// delete data

  Future<bool> deleteNote ({required int sno}) async {
  var db = await getDB();
  int rowsEffected = await db.delete(TABLENAME, where: "$COLUMN_NOTE_SNO = ?", whereArgs: ["$sno"]);

  return rowsEffected>0;
  }

}

