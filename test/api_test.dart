import 'package:flutter_test/flutter_test.dart';
import 'package:e_compliance/main.dart';
import 'package:e_compliance/services/user_service.dart';

void main() {
 test('Test getUser function', () async {
   final service = UserService.getUsers();

     expect(service, isInstanceOf<Future>());
  });
}