
import 'package:shared_preferences/shared_preferences.dart';
import 'package:package_info_plus/package_info_plus.dart';

class VersionService{
  static const String _keyAppVersion = 'app_version';
  static const String _keyFIrstLaunch ='first_launch';
  //checking if it's first installation
Future<bool> isFirstLaunch() async{
  final prefs = await SharedPreferences.getInstance();
  bool isFirstLaunch = prefs.getBool(_keyFIrstLaunch) ?? true;
  if(isFirstLaunch){
  await prefs.setBool(_keyFIrstLaunch, false);
  }
  return isFirstLaunch;
}
//check for an update occurrence
Future<bool> isAppUpdated() async {
  final prefs = await SharedPreferences.getInstance();
  final packageInfo = await PackageInfo.fromPlatform();
  final currentVersion = packageInfo.version;
  final savedVersion = prefs.getString(_keyAppVersion) ?? '';
  //now check for a difference in versions
  if(currentVersion != savedVersion){
  await prefs.setString(_keyAppVersion, currentVersion);
  return savedVersion.isNotEmpty; // return false if first installation
  }
  return false;
}
}