import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/database/app_database.dart';
import '../../domain/entities/post_entity.dart';

/// 로컬 데이터 소스 인터페이스
abstract class PostLocalDataSource {
  Future<List<PostEntity>> getPosts();
  Future<void> cachePosts(List<PostEntity> posts);
}

/// 로컬 데이터 소스 구현체 (Drift 사용)
class PostLocalDataSourceImpl implements PostLocalDataSource {
  final AppDatabase database;

  PostLocalDataSourceImpl(this.database);

  @override
  Future<List<PostEntity>> getPosts() async {
    // 내부 DB에서 모든 게시글 조회
    final result = await database.getAllPosts();
    return result
        .map((e) => PostEntity(id: e.id, title: e.title, body: e.body))
        .toList();
  }

  @override
  Future<void> cachePosts(List<PostEntity> posts) async {
    // 기존 캐시 삭제 후 새로운 데이터 삽입
    await database.deleteAllPosts();
    await database.insertPosts(
      posts
          .map(
            (e) => Post(
              id: e.id,
              title: e.title,
              body: e.body,
              userId: 1, // 로컬에는 userId가 없으므로 기본값 1 설정
            ),
          )
          .toList(),
    );
  }
}

/// 데이터베이스 Provider (싱글톤)
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

/// 로컬 데이터 소스 Provider
final postLocalDataSourceProvider = Provider<PostLocalDataSource>((ref) {
  final database = ref.watch(appDatabaseProvider);
  return PostLocalDataSourceImpl(database);
});
