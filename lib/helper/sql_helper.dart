import 'package:multi_user_authentication/models/user_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Sql_Helper {
  Sql_Helper._();
  static final Sql_Helper sql_helper = Sql_Helper._();

  Database? database;
  Future<void> Db_init() async {
    String datbasepath = await getDatabasesPath();
    String path = join(datbasepath, 'demo.db');

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        String q =
            "CREATE TABLE IF NOT EXISTS user(id INTEGER PRIMARY KEY AUTOINCREMENT,email TEXT,password TEXT,type TEXT);";

        await db.execute(q);
      },
    );
  }

  Future<int> InsertallData(
      {required String email,
      required String password,
      required String type}) async {
    await Db_init();
    List k = [email, password, type];
    String q = "INSERT INTO user(email,password,type) values(?,?,?)";

    int data = await database!.rawInsert(q, k);
    print("$data");
    return data;
  }

  Future<List<User>> fechtallData({required String email}) async {
    await Db_init();
    print("$email");
    String q = "SELECT * FROM user WHERE email = ?";
    List k = [email];
    List<Map<String, Object?>> data = await database!.rawQuery(q, k);

    List<User> h = data.map((e) => User.fromMap(data: e)).toList();

    print(h);
    return h;
  }

  Future<List<User>> fechtallData1(
      {required String password, required String email}) async {
    await Db_init();
    print("$password");
    String q = "SELECT * FROM user WHERE password = ? and email = ? ";
    List k = [password, email];
    List<Map<String, Object?>> data = await database!.rawQuery(q, k);

    List<User> h = data.map((e) => User.fromMap(data: e)).toList();

    print(h);
    return h;
  }

  Future<List<User>> fechtallData2() async {
    await Db_init();

    String q = "SELECT * FROM user";

    List<Map<String, Object?>> data = await database!.rawQuery(q);

    List<User> h = data.map((e) => User.fromMap(data: e)).toList();

    return h;
  }

  Future<int> updateAll(
      {required String email,
      required String password,
      required String type,
      required int id}) async {
    await Db_init();

    String q = "Update user set email = ?, password = ?,type = ? where id = ?";

    List k = [email, password, type, id];

    int m = await database!.rawUpdate(q, k);

    return m;
  }

  Future<int> deleteall({required int id}) async {
    await Db_init();

    String q = "Delete from user where id = ?";
    List k = [id];

    int m = await database!.rawDelete(q, k);

    return m;
  }
}
