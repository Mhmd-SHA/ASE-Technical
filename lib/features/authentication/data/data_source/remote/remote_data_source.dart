import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/constants.dart';
import '../../model/user_model.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<UserModel> login(String username, String password) async {
    final requestBody = {
      "API_Body": [
        {"Unique_Id": "", "Pw": password},
      ],
      "Api_Action": "GetUserData",
      "Company_Code": username,
    };

    try {
      final response = await _dio.post(
        Constants.apiUrl,
        data: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        if (data['Status_Code'] == 200) {
          log(data.toString());

          return UserModel.fromJson(data['Response_Body'][0]);
        }
        throw Exception('Login failed: ${data['Message']}');
      }
      throw Exception('Failed to login: ${response.statusCode}');
    } catch (e) {
      throw Exception("Failed to login");
    }
  }
}
