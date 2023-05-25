import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'auth_user_models.g.dart';

@JsonSerializable()
class AuthUser extends Equatable {
  final String id;
  final String? username;
  final String? first_name;
  final String? last_name;
  final String? job_title;
  final String? profile_picture_path;
  final String? user_description;
  final String? email;
  final String? password;
  final String? token;

  const AuthUser({
    required this.id,
    this.username,
    this.first_name,
    this.last_name,
    this.job_title,
    this.profile_picture_path,
    this.user_description,
    this.email,
    this.password,
    this.token,
  });

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserToJson(this);

  static const empty = AuthUser(id: '');
  bool get isEmpty => this == AuthUser.empty;
  bool get isNotEmpty => this != AuthUser.empty;

  @override
  List<Object?> get props => [
        id,
        username,
        first_name,
        last_name,
        job_title,
        profile_picture_path,
        user_description,
        email,
        password,
        token,
      ];
}
