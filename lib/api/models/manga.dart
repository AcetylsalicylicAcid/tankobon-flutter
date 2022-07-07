import 'package:freezed_annotation/freezed_annotation.dart';

part 'manga.freezed.dart';
part 'manga.g.dart';

@freezed
class Manga with _$Manga {
  const factory Manga({
    required String id,
    required String title,
    required String description,
    required String cover,
    required List<int> volume,
  }) = _Manga;

  factory Manga.fromJson(Map<String, Object?> json) => _$MangaFromJson(json);

  @override
  String toString() => toJson().toString();
}
