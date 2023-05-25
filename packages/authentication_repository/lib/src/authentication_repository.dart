import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:authentication_repository/src/models/auth_user_models.dart';
import 'package:cache/cache.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

//Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

class LogInFailure implements Exception {}

class RegistrationFailure implements Exception {}

const baseUrl = 'https://iamdevcoder.000webhostapp.com/api/v1';
late final String token;

class AuthenticationRepository {
  final AuthApiResponse apiResponse = AuthApiResponse();
  final _controller = StreamController<AuthenticationStatus>();
  final CacheClient? _cache;
  AuthenticationRepository({
    CacheClient? cache,
  }) : _cache = cache ?? CacheClient();

  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  Future<AuthApiResponse> register(
      {required String username,
      required String email,
      required String password}) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        body: {
          'username': username,
          'email': email,
          'password': password,
        },
      );

      switch (response.statusCode) {
        case 200:
          await Future.delayed(const Duration(milliseconds: 300),
              () => _controller.add(AuthenticationStatus.authenticated));
          apiResponse.data = AuthUser.fromJson(jsonDecode(response.body));
          break;
        case 422:
          final errors = jsonDecode(response.body)['errors'];
          apiResponse.error = errors[errors.keys.elementAt(0)][0];
          break;
        case 403:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;
        default:
          apiResponse.error = 'somethingWentWrong';
          break;
      }
    } catch (e) {
      apiResponse.error = 'server error occurred';
    }
    return apiResponse;
  }

  Future<AuthApiResponse> login(
      {required String email, required String password}) async {
    try {
      String token = await getToken();
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        body: {
          'email': email,
          'password': password,
        },
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      switch (response.statusCode) {
        case 200:
          await Future.delayed(const Duration(milliseconds: 300),
              () => _controller.add(AuthenticationStatus.authenticated));
          apiResponse.data = AuthUser.fromJson(jsonDecode(response.body));
          break;
        case 422:
          final errors = jsonDecode(response.body)['errors'];
          apiResponse.error = errors[errors.keys.elementAt(0)][0];
          break;
        case 403:
          apiResponse.error = jsonDecode(response.body)['message'];
          break;
        default:
          apiResponse.error = 'something went wrong';
          break;
      }
    } catch (e) {
      apiResponse.error = 'server error occurred';
    }
    return apiResponse;
  }

  Future<bool> logout() async {
    _controller.add(AuthenticationStatus.unauthenticated);
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.remove('token');
  }

  AuthUser get currentUser {
    return _cache?.read<AuthUser>(key: userCacheKey) ?? AuthUser.empty;
  }

  Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('token') ?? '';
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

  void dispose() => _controller.close();
}
