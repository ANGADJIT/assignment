import 'package:shared_preferences/shared_preferences.dart';
import 'package:velocity_x/velocity_x.dart';

class SessionDb {
  /// This check wetther user is in sessionor not
  /// By comparing time stored in local device
  /// return true if user session and false is user in not in session
  Future<bool> isUserInSession() async {
    SharedPreferences _instance = await SharedPreferences.getInstance();
    final String dateString = _instance.getString('session_expiry')!;
    DateTime sessionTime = DateTime.parse(dateString);
    DateTime currentTime = DateTime.now();

    final int diff = currentTime.compareTo(sessionTime);

    if (diff <= 0) {
      return true;
    }

    return false;
  }

  /// This stores the session time in device locally in key pair value
  /// Session time is 4 hours
  /// where key is 'session_expiry'
  Future<void> setSession() async {
    SharedPreferences _instance = await SharedPreferences.getInstance();
    DateTime dateTime = DateTime.now();
    dateTime = dateTime.add(4.hours);

    await _instance.setString('session_expiry', dateTime.toString());
  }
}
