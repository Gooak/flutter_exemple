import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/usecases/get_posts_usecase.dart';
import '../../data/repositories/post_repository_impl.dart';

final getPostsUsecaseProvider = Provider<GetPostsUsecase>((ref) {
  final repository = ref.watch(postRepositoryProvider);
  return GetPostsUsecase(repository);
});

final postsNotifierProvider =
    AsyncNotifierProvider<PostsNotifier, List<PostEntity>>(PostsNotifier.new);

class PostsNotifier extends AsyncNotifier<List<PostEntity>> {
  @override
  FutureOr<List<PostEntity>> build() {
    return _getPosts();
  }

  Future<List<PostEntity>> _getPosts() async {
    final usecase = ref.read(getPostsUsecaseProvider);
    return usecase.call();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _getPosts());
  }
}
