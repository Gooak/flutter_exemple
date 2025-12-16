import '../entities/post_entity.dart';
// Asking user to add fpdart might be too much, let's stick to a simple Future<List<PostEntity>> or a custom Result type.
// For simplicity in this demo without fpdart: Future<List<PostEntity>> and throw exceptions caught by Repository/Provider.
// OR better: Future<(Failure?, List<PostEntity>?)> or similar.
// Let's stick to standard practice: Repository returns Future, throws exception, Provider handles it?
// No, Clean Arch usually handles errors in Repository or UseCase.
// Let's define a simple Result/Either type or usage pattern.
// I'll stick to exception throwing in Datasource, and Repository returning List, Provider handling try-catch for simplicity,
// unless I add `fpdart`. The user didn't ask for fpdart.
// I will just return Future<List<PostEntity>> and let the provider handle errors.

abstract class PostRepository {
  Future<List<PostEntity>> getPosts();
}
