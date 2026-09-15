class AuthSession {
  const AuthSession({required this.accessToken, required this.expiresInSeconds});

  final String accessToken;
  final int expiresInSeconds;
}
