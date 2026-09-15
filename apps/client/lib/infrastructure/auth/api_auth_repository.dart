import '../../domain/entities/auth_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../network/api_client.dart';
import '../storage/secure_token_storage.dart';

class ApiAuthRepository implements AuthRepository {
  ApiAuthRepository({required ApiClient client, required SecureTokenStorage tokenStorage})
      : _client = client,
        _tokenStorage = tokenStorage;

  final ApiClient _client;
  final SecureTokenStorage _tokenStorage;

  @override
  Future<AuthSession> login({required String email, required String password}) async {
    final data = await _client.post('/v1/auth/login', body: {'email': email, 'password': password});
    return _save(data);
  }

  @override
  Future<AuthSession> register({required String email, required String password, required String name}) async {
    await _client.post('/v1/auth/register', body: {'email': email, 'password': password, 'name': name});
    return login(email: email, password: password);
  }

  @override
  Future<void> logout() => _tokenStorage.clear();

  @override
  Future<bool> hasSession() async => (await _tokenStorage.read()) != null;

  Future<AuthSession> _save(Map<String, dynamic> data) async {
    final token = data['access_token'];
    final expires = data['expires_in'];
    if (token is! String || expires is! num) {
      throw const FormatException('Invalid authentication response.');
    }
    await _tokenStorage.write(token);
    return AuthSession(accessToken: token, expiresInSeconds: expires.toInt());
  }
}
