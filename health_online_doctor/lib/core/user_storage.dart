import 'package:shared_preferences/shared_preferences.dart';

class UserStorage {
  static SharedPreferences? _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setEmail(String email) async =>
      await _preferences?.setString('email', email);

  static String? getEmail() => _preferences?.getString('email');

  static Future setId(String email) async =>
      await _preferences?.setString('id', email);

  static String? getId() => _preferences?.getString('id');

  static Future setFullName(String name) async =>
      await _preferences?.setString('name', name);

  static String? getFullName() => _preferences?.getString('name');

  static Future setDescription(String description) async =>
      await _preferences?.setString('description', description);

  static String? getDescription() => _preferences?.getString('description');

  static Future setSpecialization(String specialization) async =>
      await _preferences?.setString('specialization', specialization);

  static String? getSpecialization() => _preferences?.getString('specialization');

  static Future setIsLogged(bool isLogged) async =>
      await _preferences?.setBool('isLogged', isLogged);

  static bool? getIsLogged() => _preferences?.getBool('isLogged');
}
