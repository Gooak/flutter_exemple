import 'package:flutter/material.dart';

@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({
    required this.primaryCustom,
    required this.secondaryCustom,
  });

  final Color? primaryCustom;
  final Color? secondaryCustom;

  @override
  AppColorsExtension copyWith({Color? primaryCustom, Color? secondaryCustom}) {
    return AppColorsExtension(
      primaryCustom: primaryCustom ?? this.primaryCustom,
      secondaryCustom: secondaryCustom ?? this.secondaryCustom,
    );
  }

  @override
  AppColorsExtension lerp(ThemeExtension<AppColorsExtension>? other, double t) {
    if (other is! AppColorsExtension) {
      return this;
    }
    return AppColorsExtension(
      primaryCustom: Color.lerp(primaryCustom, other.primaryCustom, t),
      secondaryCustom: Color.lerp(secondaryCustom, other.secondaryCustom, t),
    );
  }

  // 예시: 미리 정의된 색상 팔레트
  static const light = AppColorsExtension(
    primaryCustom: Color(0xFF6200EE),
    secondaryCustom: Color(0xFF03DAC6),
  );

  static const dark = AppColorsExtension(
    primaryCustom: Color(0xFFBB86FC),
    secondaryCustom: Color(0xFF03DAC6),
  );
}
