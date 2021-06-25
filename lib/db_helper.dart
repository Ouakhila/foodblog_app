import 'package:foodblog_app/blog_model.dart';
//import 'package:foodblog_app/main.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

  class DBHelper {
  static Database _db;
  static const String ID = 'id';
  static const String NAME = 'photo_name';
  static const String TABLE = 'PhotosTable';
  static const String DB_NAME = 'photos.db';

  Future<Database> get db async {
  if (null != _db) {
  return _db;
  }
  _db = await initDb();
  return _db;
  }

  initDb() async {
  io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String path = join(documentsDirectory.path, DB_NAME);
  var db = await openDatabase(path, version: 1, onCreate: _onCreate);
  return db;
  }

  _onCreate(Database db, int version) async {
  await db.execute("CREATE TABLE $TABLE ($ID INTEGER, $NAME TEXT)");
  }
//insert photo
  Future<Photo> save(Photo bphoto) async {
  var dbClient = await db;
  bphoto.id = await dbClient.insert(TABLE, bphoto.toMap());
  return bphoto;
  }
//deletion
    Future<Photo> delete(Photo bphoto) async {
      var dbClient = await db;
      bphoto.id = await dbClient.rawDelete("DELETE FROM TABLE Photo WHERE id =?", [bphoto]);
      return bphoto;
    }

    //Read
  Future<List<Photo>> getPhotos() async {
  var dbClient = await db;
  List<Map> maps = await dbClient.query(TABLE, columns: [ID, NAME]);
  List<Photo> bphoto = [];
  if (maps.length > 0) {
  for (int i = 0; i < maps.length; i++) {
  bphoto.add(Photo.fromMap(maps[i]));
  }
  }
  return bphoto;
  }

  Future close() async {
  var dbClient = await db;
  dbClient.close();
  }
  }
