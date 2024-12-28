import '../constants/consts.dart';

class CredentialController {
  String username = "";
  String password = "";
  String confirmPassword = "";
  String name = "";

  String text = "";
  void setCredentials(String key, String value) {
    if (key == CustomTextInputTypes().username) {
      username = value;
    } else if (key == CustomTextInputTypes().password) {
      password = value;
    } else if (key == CustomTextInputTypes().text) {
      text = value;
    } else if (key == CustomTextInputTypes().confirmPassword) {
      confirmPassword = value;
    } else if (key == CustomTextInputTypes().name) {
      name = value;
    }
  }

  void clear() {
    username = "";
    password = "";
    confirmPassword = "";
    text = "";
  }
}
