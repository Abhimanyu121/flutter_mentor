// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String name;

  final List<Migration> _migrations = [];

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final database = _$AppDatabase();
    database.database = await database.open(name ?? ':memory:', _migrations);
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String> listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ActiveDao _activeDaoInstance;

  UnSelectedDao _unSelectedDaoInstance;

  Future<sqflite.Database> open(String name, List<Migration> migrations) async {
    final path = join(await sqflite.getDatabasesPath(), name);

    return sqflite.openDatabase(
      path,
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
      },
      onUpgrade: (database, startVersion, endVersion) async {
        MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);
      },
      onCreate: (database, _) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Active` (`topic` TEXT, PRIMARY KEY (`topic`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `UnSelected` (`topic` TEXT, PRIMARY KEY (`topic`))');
      },
    );
  }

  @override
  ActiveDao get activeDao {
    return _activeDaoInstance ??= _$ActiveDao(database, changeListener);
  }

  @override
  UnSelectedDao get unSelectedDao {
    return _unSelectedDaoInstance ??= _$UnSelectedDao(database, changeListener);
  }
}

class _$ActiveDao extends ActiveDao {
  _$ActiveDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _activeInsertionAdapter = InsertionAdapter(database, 'Active',
            (Active item) => <String, dynamic>{'topic': item.topic});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final _activeMapper =
      (Map<String, dynamic> row) => Active(row['topic'] as String);

  final InsertionAdapter<Active> _activeInsertionAdapter;

  @override
  Future<List<Active>> findAllActive() async {
    return _queryAdapter.queryList('SELECT * FROM Active',
        mapper: _activeMapper);
  }

  @override
  Future<Active> findActiveById(int topic) async {
    return _queryAdapter.query('SELECT * FROM Active WHERE topic = ?',
        arguments: <dynamic>[topic], mapper: _activeMapper);
  }

  @override
  Future<List<Active>> deleteActiveWithId(String topic) async {
    return _queryAdapter.queryList('SELECT * FROM Active WHERE topic =?',
        arguments: <dynamic>[topic], mapper: _activeMapper);
  }

  @override
  Future<void> insertTopic(Active active) async {
    await _activeInsertionAdapter.insert(
        active, sqflite.ConflictAlgorithm.abort);
  }
}

class _$UnSelectedDao extends UnSelectedDao {
  _$UnSelectedDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _unSelectedInsertionAdapter = InsertionAdapter(database, 'UnSelected',
            (UnSelected item) => <String, dynamic>{'topic': item.topic});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final _unSelectedMapper =
      (Map<String, dynamic> row) => UnSelected(row['topic'] as String);

  final InsertionAdapter<UnSelected> _unSelectedInsertionAdapter;

  @override
  Future<List<UnSelected>> findAllUnSelected() async {
    return _queryAdapter.queryList('SELECT * FROM UnSelected',
        mapper: _unSelectedMapper);
  }

  @override
  Future<UnSelected> findUnSelectedById(int topic) async {
    return _queryAdapter.query('SELECT * FROM UnSelected WHERE topic = ?',
        arguments: <dynamic>[topic], mapper: _unSelectedMapper);
  }

  @override
  Future<List<UnSelected>> deleteUnSelectedWithId(String topic) async {
    return _queryAdapter.queryList('SELECT * FROM UnSelected WHERE topic =?',
        arguments: <dynamic>[topic], mapper: _unSelectedMapper);
  }

  @override
  Future<void> insertTopic(UnSelected active) async {
    await _unSelectedInsertionAdapter.insert(
        active, sqflite.ConflictAlgorithm.abort);
  }
}
