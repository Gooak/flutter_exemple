import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/post_entity.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

/// Post 데이터 모델
/// Freezed를 사용하여 불변 객체로 생성됩니다.
@freezed
class PostModel with _$PostModel {
  const factory PostModel({
    required int id,
    required String title,
    required String body,
    required int userId,
  }) = _PostModel;

  /// JSON 데이터를 PostModel로 변환하는 팩토리 생성자
  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}

/// PostModel에 대한 확장 메서드
extension PostModelX on PostModel {
  /// PostModel을 도메인 엔티티(PostEntity)로 변환
  PostEntity toEntity() => PostEntity(id: id, title: title, body: body);
}
