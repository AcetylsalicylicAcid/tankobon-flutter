import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';

part 'login.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class Login {
  Login({
    required this.instance,
    required this.username,
    required this.password,
  });
  @HiveField(0)
  final String instance;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final String password;

  @override
  String toString() => _$LoginToJson(this).toString();
}
