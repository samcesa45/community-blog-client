// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthUser _$AuthUserFromJson(Map<String, dynamic> json) => AuthUser(
      id: json['id'] as String,
      username: json['username'] as String?,
      first_name: json['first_name'] as String?,
      last_name: json['last_name'] as String?,
      job_title: json['job_title'] as String?,
      profile_picture_path: json['profile_picture_path'] as String?,
      user_description: json['user_description'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$AuthUserToJson(AuthUser instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'job_title': instance.job_title,
      'profile_picture_path': instance.profile_picture_path,
      'user_description': instance.user_description,
      'email': instance.email,
      'password': instance.password,
      'token': instance.token,
    };
