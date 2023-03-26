import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DataRepository {
  late Database _db;
  bool initialized = false;
  static const String databaseName = 'tickers.db';
  static const int version = 1;

  Future<Database> get db async {
    if (initialized) {
      return _db;
    }
    _db = await initDB();
    initialized = true;
    return _db;
  }

  initDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, databaseName);
    var db = await openDatabase(
      path,
      version: version,
      onCreate: _onCreate,
    );
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''CREATE TABLE Ticker (
        tickerID INTEGER PRIMARY KEY AUTOINCREMENT,
        ticker TEXT NOT NULL
        )''');
  }

  // works? [yes]
  // deletes database. Use if you want to make changes to table and reset
  void deleteDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, databaseName);
    await deleteDatabase(path);
  }

  Future<List<Map<String, dynamic>>> getAllTickers() async {
    var dbClient = await db;
    var response = await dbClient.rawQuery("SELECT * FROM Ticker;");
    return response;
  }

  Future deleteTicker(String ticker) async {
    var dbClient = await db;
    await dbClient.rawDelete(
      "DELETE FROM Ticker WHERE ticker = ?;",
      [ticker],
    );
  }

  Future insertTicker(String ticker) async {
    var dbClient = await db;
    await dbClient.rawInsert(
      "INSERT INTO Ticker(ticker) VALUES(?);",
      [ticker],
    );
  }

  Future<bool> isTickerInFavorites(String ticker) async {
    var dbClient = await db;
    var response = await dbClient.rawQuery(
      "SELECT * FROM Ticker WHERE Ticker.ticker = ?;",
      [ticker],
    );

    if (response.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
}
