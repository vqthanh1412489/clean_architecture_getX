import 'package:cleanarchitechgetx/domain/exception/auth_exception.dart';
import 'package:cleanarchitechgetx/domain/models/product.dart';
import 'package:cleanarchitechgetx/domain/models/user.dart';
import 'package:cleanarchitechgetx/domain/repository/api_repository.dart';
import 'package:cleanarchitechgetx/domain/response/login_response.dart';
import 'package:cleanarchitechgetx/domain/request/login_request.dart';

class ApiRepositoryImpl extends ApiRepositoryInterface {
  @override
  Future<User> getUserFromToeken(String token) async {
    // call http here

    if (token == 'token1') {
      return User(
          username: 'token 1',
          name: 'Token 1',
          image: 'https://cdn.picpng.com/1/transparency-1-35324.png');
    } else if (token == ' token2') {
      return User(
          username: 'token 2',
          name: 'Token 2',
          image: 'https://cdn.picpng.com/2/pic-2-35379.png');
    }

    throw AuthException();
  }

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    await Future.delayed(const Duration(seconds: 1));
    if (loginRequest.username == 'token1' && loginRequest.password == '1') {
      return LoginResponse(
          token: 'token1',
          user: User(
              username: 'token 1',
              name: 'Token 1',
              image: 'https://cdn.picpng.com/1/transparency-1-35324.png'));
    } else if (loginRequest.username == 'token2' &&
        loginRequest.password == '2') {
      return LoginResponse(
          token: 'token2',
          user: User(
              username: 'token 2',
              name: 'Token 2',
              image: 'https://cdn.picpng.com/2/pic-2-35379.png'));
    }

    throw AuthException();
  }

  @override
  Future<void> logout(String token) async {
    print('remove all');
    return;
  }

  @override
  Future<List<Product>> getProducts() async {
    await Future.delayed(const Duration(seconds: 1));

    final List<Product> productList = [
      Product(
          name: 'name product 1',
          pirce: 100,
          image: 'https://picsum.photos/100'),
      Product(
          name: 'name product 2',
          pirce: 200,
          image: 'https://picsum.photos/100'),
      Product(
          name: 'name product 3',
          pirce: 300,
          image: 'https://picsum.photos/100'),
    ];

    return productList;
  }
}
