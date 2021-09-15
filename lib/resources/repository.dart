import 'package:meme/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Repository {
  Future<bool> getAuthState() async {
    var pref = await SharedPreferences.getInstance();
    return pref.getBool(SharedPrefKey.authState) ?? false;
  }

  Future<void> setAuthState(bool authenticated) async {
    var pref = await SharedPreferences.getInstance();
    pref.setBool(SharedPrefKey.authState, authenticated);
  }
}