import 'package:get/get.dart';
import 'package:impulse/models/user.dart';

class UserController extends GetxController {
  Rx<User?> user = Rx<User?>(null);

  void setUser(User? newUser) {
    user.value = newUser;
  }

  User? get currentUser => user.value;

  bool get isLoggedIn => user.value != null;
}
