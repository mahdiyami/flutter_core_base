import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';



@module
abstract class DeviceInfoModule {
  @lazySingleton
  DeviceInfoPlugin get deviceInfoPlugin => DeviceInfoPlugin();

}
