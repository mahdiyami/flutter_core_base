import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_core_base/core_injection.config.dart';
import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';



@InjectableInit(
  initializerName: 'coreBaseInjection', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
Future<void> coreBaseInjection(GetIt getIt) async {
  getIt.coreBaseInjection();


  ///inject packages

  var packageInfo = await PackageInfo.fromPlatform();
  getIt.registerLazySingleton<PackageInfo>(() => packageInfo);
  // getIt.registerLazySingleton<SmartAuth>(() => SmartAuth());
  getIt.registerLazySingleton<Connectivity>(() => Connectivity());

}

