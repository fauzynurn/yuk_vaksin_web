abstract class AuthDatasource {
  Future<void> login(String email, String password);

  Future<void> register(String name, String email, String password);

  Future<String?> getUserName();

  Future<String?> getUserToken();

  void setUserName(String value);

  void setUserToken(String value);

  Future<void> verifyEmail(String email);

  Future<void> resetPassword(String token, String newPassword);
}
