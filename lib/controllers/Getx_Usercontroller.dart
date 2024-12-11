import 'package:get/get.dart';
import 'package:library_management/Service/User_service.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var message = ''.obs;

  final ApiService _apiService = ApiService();

  Future<void> register(String name, String email, String password, String phone) async {
    isLoading.value = true;
    try {
      final response = await _apiService.registerUser(name, email, password, phone);
      message.value = response['message'];
    } catch (e) {
      message.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      final response = await _apiService.loginUser(email, password);
      message.value = response['message'];

      // Navigate to HomePage on successful login
      if (response['message'] == 'Login successful') { // Adjust this based on your API response
        Get.offNamed('/home'); // Navigate to HomePage
      }
    } catch (e) {
      message.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
