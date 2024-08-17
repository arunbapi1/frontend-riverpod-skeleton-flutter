
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String keyExample = 'exampleKey';

  Future<void> saveExampleValue(String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyExample, value);
  }

  Future<String?> getExampleValue() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyExample);
  }
}
