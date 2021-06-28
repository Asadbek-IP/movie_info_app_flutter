import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  SharedPrefHelper._privateConstructor();
  static final SharedPrefHelper instance =
      SharedPrefHelper._privateConstructor();

  final String keySessionId = "session_id";
  final String keyExpire = "expires_at";

  static SharedPreferences? _prefs;

  Future<SharedPreferences> get prefs async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    return _prefs!;
  }

  Future saveGuestSessionId(String guestSessionId, String expiresAt) async {
    SharedPreferences pref = await prefs;
    await pref.setString(keySessionId, guestSessionId);
    await pref.setString(keyExpire, expiresAt);
  }

  Future<String?> getValidSessionIdOrNull() async {
    SharedPreferences pref = await prefs;
    String? expiresAt = pref.getString(keyExpire);
    if (expiresAt == null) {
      return null;
    }
    var now = DateTime.now();
    var expire = DateTime.parse(expiresAt);
    expire = expire.add(now.timeZoneOffset);
    print(now.compareTo(expire));
    return now.compareTo(expire) < 0 ? pref.getString(keySessionId) : null;
  }
}
