class User {
  final String email;
  final String password;

  User({required this.email, required this.password});
  
  // Method to convert the User object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
