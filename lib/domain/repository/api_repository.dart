import 'package:cleanarchitechgetx/domain/models/product.dart';
import 'package:cleanarchitechgetx/domain/models/user.dart';
import 'package:cleanarchitechgetx/domain/request/login_request.dart';
import 'package:cleanarchitechgetx/domain/response/login_response.dart';

abstract class ApiRepositoryInterface {
  Future<User> getUserFromToeken(String token);
  Future<LoginResponse> login(LoginRequest loginRequest);
  Future<void> logout(String token);

  Future<List<Product>> getProducts();
}
