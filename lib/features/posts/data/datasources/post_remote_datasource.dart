import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../core/network/dio_client.dart';
import '../models/post_model.dart';

part 'post_remote_datasource.g.dart';

/// Post 관련 API 호출을 담당하는 Remote DataSource 인터페이스
/// Retrofit을 사용하여 API 엔드포인트를 정의합니다.
@RestApi()
abstract class PostRemoteDataSource {
  factory PostRemoteDataSource(Dio dio, {String baseUrl}) =
      _PostRemoteDataSource;

  /// 게시글 목록 조회
  @GET('/posts')
  Future<List<PostModel>> getPosts();
}

// PostRemoteDataSource postRemoteDataSource(PostRemoteDataSourceRef ref) {
//   final dio = ref.watch(dioClientProvider);
//   return PostRemoteDataSourceImpl(dio);
// }
/// PostRemoteDataSource를 제공하는 Riverpod Provider
final postRemoteDataSourceProvider = Provider<PostRemoteDataSource>((ref) {
  final dio = ref.watch(dioClientProvider);
  return PostRemoteDataSource(dio);
});
