import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/post_repository.dart';

class GetPostsUsecase {
  final PostRepository repository;

  GetPostsUsecase(this.repository);

  Future<List<PostEntity>> call() {
    return repository.getPosts();
  }
}
