import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const String dbName = "users.db";
  static const String tableName = "users";
  static const String colId = "id";
  static const String colEmail = "email";
  static const String colPassword = "password";

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), dbName);

    return await openDatabase(
      path,
      version: 2, // Incremented version
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableName (
            $colId INTEGER PRIMARY KEY AUTOINCREMENT,
            $colEmail TEXT UNIQUE NOT NULL,
            $colPassword TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE students (
            studentId INTEGER PRIMARY KEY AUTOINCREMENT,
            studentName TEXT NOT NULL,
            studentAge INTEGER NOT NULL
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            CREATE TABLE students (
              studentId INTEGER PRIMARY KEY AUTOINCREMENT,
              studentName TEXT NOT NULL,
              studentAge INTEGER NOT NULL
            )
          ''');
        }
      },
    );
  }

  Future<int> registerUser(String email, String password) async {
    final db = await database;
    return await db.insert(tableName, {
      colEmail: email,
      colPassword: password,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getUser(String email) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      tableName,
      where: "$colEmail = ?",
      whereArgs: [email],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<int> insertStudent(String name, int age) async {
    final db = await database;
    return await db.insert('students', {
      'studentName': name,
      'studentAge': age,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getStudent(int studentId) async {
    final db = await database;
    List<Map<String, dynamic>> result = await db.query(
      'students',
      where: "studentId = ?",
      whereArgs: [studentId],
    );

    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getAllStudents() async {
    final db = await database;
    return await db.query('students');
  }
}
