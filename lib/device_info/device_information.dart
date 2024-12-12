
abstract class DeviceInformation {
  Future<String> get os;
  Future<String> get osVersion;
  Future<String> get deviceBuildNumber;
  Future<String> get deviceModel;
}