// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
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

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
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

  ActivityDao? _activityDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
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
            'CREATE TABLE IF NOT EXISTS `ActivityModel` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `seconds` INTEGER NOT NULL, `minutes` INTEGER NOT NULL, `hours` INTEGER NOT NULL, `startTime` TEXT NOT NULL, `endTime` TEXT NOT NULL, `description` TEXT NOT NULL, `location` TEXT NOT NULL, `date` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ActivityDao get activityDao {
    return _activityDaoInstance ??= _$ActivityDao(database, changeListener);
  }
}

class _$ActivityDao extends ActivityDao {
  _$ActivityDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _activityModelInsertionAdapter = InsertionAdapter(
            database,
            'ActivityModel',
            (ActivityModel item) => <String, Object?>{
                  'id': item.id,
                  'seconds': item.seconds,
                  'minutes': item.minutes,
                  'hours': item.hours,
                  'startTime': item.startTime,
                  'endTime': item.endTime,
                  'description': item.description,
                  'location': item.location,
                  'date': item.date
                }),
        _activityModelUpdateAdapter = UpdateAdapter(
            database,
            'ActivityModel',
            ['id'],
            (ActivityModel item) => <String, Object?>{
                  'id': item.id,
                  'seconds': item.seconds,
                  'minutes': item.minutes,
                  'hours': item.hours,
                  'startTime': item.startTime,
                  'endTime': item.endTime,
                  'description': item.description,
                  'location': item.location,
                  'date': item.date
                }),
        _activityModelDeletionAdapter = DeletionAdapter(
            database,
            'ActivityModel',
            ['id'],
            (ActivityModel item) => <String, Object?>{
                  'id': item.id,
                  'seconds': item.seconds,
                  'minutes': item.minutes,
                  'hours': item.hours,
                  'startTime': item.startTime,
                  'endTime': item.endTime,
                  'description': item.description,
                  'location': item.location,
                  'date': item.date
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ActivityModel> _activityModelInsertionAdapter;

  final UpdateAdapter<ActivityModel> _activityModelUpdateAdapter;

  final DeletionAdapter<ActivityModel> _activityModelDeletionAdapter;

  @override
  Future<List<ActivityModel>> findAllActivity() async {
    return _queryAdapter.queryList('SELECT * FROM ActivityModel',
        mapper: (Map<String, Object?> row) => ActivityModel(
            id: row['id'] as int?,
            seconds: row['seconds'] as int,
            minutes: row['minutes'] as int,
            hours: row['hours'] as int,
            startTime: row['startTime'] as String,
            endTime: row['endTime'] as String,
            description: row['description'] as String,
            location: row['location'] as String,
            date: row['date'] as String));
  }

  @override
  Future<List<ActivityModel>> findActivityByDescription(String desc) async {
    return _queryAdapter.queryList(
        'SELECT * FROM ActivityModel WHERE description LIKE ?1',
        mapper: (Map<String, Object?> row) => ActivityModel(
            id: row['id'] as int?,
            seconds: row['seconds'] as int,
            minutes: row['minutes'] as int,
            hours: row['hours'] as int,
            startTime: row['startTime'] as String,
            endTime: row['endTime'] as String,
            description: row['description'] as String,
            location: row['location'] as String,
            date: row['date'] as String),
        arguments: [desc]);
  }

  @override
  Future<void> insertPerson(ActivityModel activity) async {
    await _activityModelInsertionAdapter.insert(
        activity, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateActivity(ActivityModel activity) {
    return _activityModelUpdateAdapter.updateAndReturnChangedRows(
        activity, OnConflictStrategy.abort);
  }

  @override
  Future<int> deleteActivity(ActivityModel activity) {
    return _activityModelDeletionAdapter.deleteAndReturnChangedRows(activity);
  }
}
