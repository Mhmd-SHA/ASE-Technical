import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import '../../model/user_model.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('user.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getApplicationDocumentsDirectory();
    final path = join(dbPath.path, filePath);

    return await openDatabase(
      path,
      version: 2, // Increment version to trigger onUpgrade if needed
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future _createDB(Database db, int version) async {
    // Users table
    await db.execute('''
    CREATE TABLE users (
      userCode TEXT PRIMARY KEY,
      userDisplayName TEXT,
      email TEXT,
      userEmployeeCode TEXT,
      companyCode TEXT
    )
    ''');

    // Locations table
    await db.execute('''
    CREATE TABLE user_locations (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      userCode TEXT,
      locationCode TEXT,
      FOREIGN KEY (userCode) REFERENCES users (userCode)
    )
    ''');

    // Permissions table
    await db.execute('''
    CREATE TABLE user_permissions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      userCode TEXT,
      permissionName TEXT,
      permissionStatus TEXT,
      FOREIGN KEY (userCode) REFERENCES users (userCode)
    )
    ''');
  }

  Future _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('''
      CREATE TABLE user_locations (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userCode TEXT,
        locationCode TEXT,
        FOREIGN KEY (userCode) REFERENCES users (userCode)
      )
      ''');

      await db.execute('''
      CREATE TABLE user_permissions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userCode TEXT,
        permissionName TEXT,
        permissionStatus TEXT,
        FOREIGN KEY (userCode) REFERENCES users (userCode)
      )
      ''');
    }
  }

  Future<void> insertUser(UserModel user) async {
    final db = await database;
    final batch = db.batch();

    // Insert user
    batch.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    // Insert locations
    for (var location in user.userLocations) {
      batch.insert('user_locations', {
        'userCode': user.userCode,
        'locationCode': location.locationCode,
      });
    }

    // Insert permissions
    for (var permission in user.userPermissions) {
      batch.insert('user_permissions', {
        'userCode': user.userCode,
        'permissionName': permission.permissionName,
        'permissionStatus': permission.permissionStatus,
      });
    }

    await batch.commit(noResult: true);
  }

  // Optional: Method to clear database for testing
  Future<void> clearDatabase() async {
    final db = await database;
    await db.execute('DELETE FROM users');
    await db.execute('DELETE FROM user_locations');
    await db.execute('DELETE FROM user_permissions');
  }
}
