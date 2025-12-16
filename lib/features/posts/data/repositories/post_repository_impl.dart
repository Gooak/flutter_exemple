import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/post_repository.dart';
import '../datasources/post_remote_datasource.dart';
import '../datasources/post_local_datasource.dart';
import '../models/post_model.dart'; // extension 사용을 위해 import

/// 게시글 리포지토리 구현체
class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;

  PostRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<List<PostEntity>> getPosts() async {
    try {
      // 1. 네트워크에서 데이터 가져오기
      final models = await remoteDataSource.getPosts();
      final entities = models.map((e) => e.toEntity()).toList();

      // 2. 로컬에 캐싱
      await localDataSource.cachePosts(entities);

      return entities;
    } catch (e) {
      // 3. 실패 시 로컬 데이터 시도
      try {
        final localData = await localDataSource.getPosts();
        if (localData.isNotEmpty) {
          return localData;
        }
        rethrow;
      } catch (_) {
        rethrow;
      }
    }
  }
}

final postRepositoryProvider = Provider<PostRepository>((ref) {
  final remoteDataSource = ref.watch(postRemoteDataSourceProvider);
  final localDataSource = ref.watch(postLocalDataSourceProvider);
  return PostRepositoryImpl(remoteDataSource, localDataSource);
});
