import 'dart:io';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  static Database? _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'faltei.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onConfigure: _onConfigure,
    );
  }

  Future<void> _onConfigure(Database db) async {
    // Enable foreign key support
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE disciplinas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        totalAulas INTEGER NOT NULL,
        limiteFaltas INTEGER NOT NULL,
        cor TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE frequencias (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        disciplinaId INTEGER NOT NULL,
        dataRegistro TEXT NOT NULL,
        tipo INTEGER NOT NULL,
        FOREIGN KEY (disciplinaId) REFERENCES disciplinas (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE horarios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        disciplinaId INTEGER NOT NULL,
        diaSemana INTEGER NOT NULL,
        horaInicio TEXT NOT NULL,
        horaFim TEXT NOT NULL,
        FOREIGN KEY (disciplinaId) REFERENCES disciplinas (id) ON DELETE CASCADE
      )
    ''');
  }
}
