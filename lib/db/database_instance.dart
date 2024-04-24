import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:ets/model/student.dart';

class DatabaseInstance {
  final String _dbName = 'student_bio.db';
  final int _version = 1;
  static Database? _database;

  static final DatabaseInstance instance = DatabaseInstance._init();
  DatabaseInstance._init();

  // Check db if exists, if not the init
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(_dbName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: _version, onCreate: _onCreate);
  }

  // create DB if not exist
  Future _onCreate(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final integerType = 'INTEGER NOT NULL';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
    CREATE TABLE $tableStudents (
    ${StudentFields.id} $idType,
    ${StudentFields.photo} $textType,
    ${StudentFields.name} $textType,
    ${StudentFields.major} $textType,
    ${StudentFields.generation} $integerType,
    ${StudentFields.time} $textType
    )
    ''');
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }

  // get all records
  Future<List<Student>> getAllStudents() async {
    final db = await instance.database;
    final orderBy = '${StudentFields.time} ASC';

    final result = await db.query(
      tableStudents,
      orderBy: orderBy,
    );
    return result.map((json) => Student.fromJson(json)).toList();
  }

  // create record
  Future<Student> create(Student student) async {
    final db = await instance.database;

    final id = await db.insert(tableStudents, student.toJson());
    return student.copy(id: id);
  }

  // get record by id
  Future<Student> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableStudents,
      columns: StudentFields.values,
      where: '${StudentFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Student.fromJson(maps.first);
    } else {
      throw Exception('Student $id not found');
    }
  }

  // update record
  Future<int> update(Student student) async {
    final db = await instance.database;

    return db.update(
      tableStudents,
      student.toJson(),
      where: '${StudentFields.id} = ?',
      whereArgs: [student.id],
    );
  }

  // delete record
  Future<int> delete(int id) async {
    final db = await instance.database;

    return db.delete(
      tableStudents,
      where: '${StudentFields.id} = ?',
      whereArgs: [id],
    );
  }
}