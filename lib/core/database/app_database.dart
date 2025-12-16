import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

/// Post 테이블 정의
class Posts extends Table {
  IntColumn get id => integer()();
  TextColumn get title => text()();
  TextColumn get body => text()();
  IntColumn get userId => integer()();

  @override
  Set<Column> get primaryKey => {id};
}

/// 앱 데이터베이스 클래스
@DriftDatabase(tables: [Posts])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  /// 모든 게시글 조회
  Future<List<Post>> getAllPosts() => select(posts).get();

  /// 게시글 추가 (충돌 시 덮어쓰기)
  Future<void> insertPosts(List<Post> entry) async {
    await batch((batch) {
      batch.insertAll(posts, entry, mode: InsertMode.insertOrReplace);
    });
  }

  /// 모든 게시글 삭제
  Future<void> deleteAllPosts() => delete(posts).go();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    // Android/iOS에서 sqlite3 라이브러리 로드
    if (Platform.isAndroid) {
      // await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    return NativeDatabase.createInBackground(file);
  });
}
