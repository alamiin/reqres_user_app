// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserDao? _userDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `user` (`id` INTEGER NOT NULL, `email` TEXT NOT NULL, `firstName` TEXT NOT NULL, `lastName` TEXT NOT NULL, `avatar` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `cache` (`id` INTEGER, `code` INTEGER, `url` TEXT, `data` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _userModelInsertionAdapter = InsertionAdapter(
            database,
            'user',
            (UserModel item) => <String, Object?>{
                  'id': item.id,
                  'email': item.email,
                  'firstName': item.firstName,
                  'lastName': item.lastName,
                  'avatar': item.avatar
                }),
        _cacheModelInsertionAdapter = InsertionAdapter(
            database,
            'cache',
            (CacheModel item) => <String, Object?>{
                  'id': item.id,
                  'code': item.code,
                  'url': item.url,
                  'data': item.data
                }),
        _userModelUpdateAdapter = UpdateAdapter(
            database,
            'user',
            ['id'],
            (UserModel item) => <String, Object?>{
                  'id': item.id,
                  'email': item.email,
                  'firstName': item.firstName,
                  'lastName': item.lastName,
                  'avatar': item.avatar
                }),
        _cacheModelUpdateAdapter = UpdateAdapter(
            database,
            'cache',
            ['id'],
            (CacheModel item) => <String, Object?>{
                  'id': item.id,
                  'code': item.code,
                  'url': item.url,
                  'data': item.data
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserModel> _userModelInsertionAdapter;

  final InsertionAdapter<CacheModel> _cacheModelInsertionAdapter;

  final UpdateAdapter<UserModel> _userModelUpdateAdapter;

  final UpdateAdapter<CacheModel> _cacheModelUpdateAdapter;

  @override
  Future<UserModel?> getUser(String key) async {
    return _queryAdapter.query('SELECT * FROM user WHERE email = ?1',
        mapper: (Map<String, Object?> row) => UserModel(
            id: row['id'] as int,
            email: row['email'] as String,
            firstName: row['firstName'] as String,
            lastName: row['lastName'] as String,
            avatar: row['avatar'] as String),
        arguments: [key]);
  }

  @override
  Future<CacheModel?> getCache(String url) async {
    return _queryAdapter.query('SELECT * FROM cache WHERE url = ?1',
        mapper: (Map<String, Object?> row) => CacheModel(
            id: row['id'] as int?,
            code: row['code'] as int?,
            url: row['url'] as String?,
            data: row['data'] as String?),
        arguments: [url]);
  }

  @override
  Future<void> insertUser(UserModel userModel) async {
    await _userModelInsertionAdapter.insert(
        userModel, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertCache(CacheModel cacheModel) async {
    await _cacheModelInsertionAdapter.insert(
        cacheModel, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateRepository(UserModel repoModel) async {
    await _userModelUpdateAdapter.update(repoModel, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateCache(CacheModel cacheModel) async {
    await _cacheModelUpdateAdapter.update(cacheModel, OnConflictStrategy.abort);
  }
}
