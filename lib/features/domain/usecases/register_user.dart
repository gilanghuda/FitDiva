
import 'package:fitdiva/core/usecase/usecase.dart';
import 'package:fitdiva/features/domain/entities/user.dart';

import '../repositories/auth_repository.dart';

class RegisterUser implements UseCase<UserEntity, RegisterParams> {
  final AuthRepository repository;

  RegisterUser(this.repository);

  @override
  Future<UserEntity> call(RegisterParams params) async {
    return await repository.register(params.email, params.password);
  }
}

class RegisterParams {
  final String email;
  final String password;

  RegisterParams({required this.email,required this.password});
}