import 'package:e_compliance/services/user_service.dart';
import 'package:e_compliance/model/user.dart';

class UserBloc {
  Stream<List<User>> get userList async* {
    yield await UserService.getUsers();
  }
}
