import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  // Base URL for your backend API
  final String baseUrl = 'https://library-server-owqsjfq01-garvgyanani101-gmailcoms-projects.vercel.app'; // Change port as necessary

  Future<dynamic> registerUser(String name, String email, String password, String phone) async {
    try {
      final response = await _dio.post('$baseUrl/registerUser', data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      });
      return response.data;
    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }

  Future<dynamic> loginUser(String email, String password) async {
    try {
      final response = await _dio.post('$baseUrl/login', data: {
        'email': email,
        'password': password,
      });
      return response.data;
    } catch (e) {
      throw Exception('Failed to login: $e');
    }
  }
}
