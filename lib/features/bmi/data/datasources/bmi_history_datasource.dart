import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../domain/entities/bmi.dart';
import '../../../../core/enums/unit_system.dart';

abstract class BmiHistoryDataSource {
  Future<void> saveResult(Bmi bmi, double weight, double height, UnitSystem unitSystem);
}

class BmiHistoryDataSourceImpl implements BmiHistoryDataSource {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('bmi_history.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE history (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      bmi_value REAL,
      category TEXT,
      weight REAL,
      height REAL,
      unit_system TEXT
    )
    ''');
  }

  @override
  Future<void> saveResult(Bmi bmi, double weight, double height, UnitSystem unitSystem) async {
    final db = await database;
    await db.insert('history', {
      'bmi_value': bmi.bmiValue,
      'category': bmi.category.toString(),
      'weight': weight,
      'height': height,
      'unit_system': unitSystem.toString(),
    });
  }
}