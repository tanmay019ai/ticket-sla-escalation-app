class SessionManager {
  static bool isLoggedIn = false;
  static String? role;
  static String? email;

  static void login({
    required String userRole,
    required String userEmail,
  }) {
    isLoggedIn = true;
    role = userRole;
    email = userEmail;
  }

  static void logout() {
    isLoggedIn = false;
    role = null;
    email = null;
  }
}
