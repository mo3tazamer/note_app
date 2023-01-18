import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Sqldb {
   final dataname ;
   final tablename;

Sqldb({this.dataname, this.tablename});

  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intaildb();
      return _db;
    } else {
      return _db;
    }
  }

  intaildb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, this.dataname);
    Database Mydb = await openDatabase(path, onCreate: _oncreate, version: 1,
        onOpen: (database) {
      print('opened');
    });

    return Mydb;
  }

  _oncreate(Database? db, int? version) async {
    await db!.execute(
        'CREATE TABLE $tablename (id INTEGER PRIMARY KEY , name TEXT NOT NULL, value TEXT NOT NULL, color TEXT NOT NULL)');
    print(
      'create***********************************',
    );
  }

  readdata() async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery('SELECT * FROM ${this.tablename}');
    return response;
  }

  insertdata({required String tablename, required String? columname1, required String? columname2, required String? columname3, required String? value1, required String? value2, required String? value3}) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(
        ('INSERT INTO $tablename($columname1, $columname2, $columname3) VALUES("$value1", "$value2", "$value3")'));
    return response;
  }

  updatedata({required String tablename,required String value1,required String value2, required String value3,required int id}) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(

        'UPDATE $tablename SET name ="$value1", value="$value2",color="$value3" WHERE id ="$id"');
    return response;
  }

  deletedata(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
}
//Sqldb sqldb = Sqldb();  take an obj for this class

//Future<List<Map>> readdata() async {          make method
//List<Map> response = await sqldb.readdata('SELECT * FROM notes');
// return response;//
//await deleteDatabase(path);
//database.close();



//'UPDATE notes SET name ="${name.text}", value="${value.text}",color="${color.text}" WHERE id ="${widget.id}"'