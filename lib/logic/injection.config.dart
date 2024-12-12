// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:device_info_plus/device_info_plus.dart' as _i833;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:flutter_core_base/connection_information/connection_information.dart'
    as _i671;
import 'package:flutter_core_base/connection_information/connection_information_connectivity.dart'
    as _i886;
import 'package:flutter_core_base/connection_information/connectivity_module.dart'
    as _i712;
import 'package:flutter_core_base/dep_injection/module/register_module.dart'
    as _i385;
import 'package:flutter_core_base/device_info/device_information.dart' as _i489;
import 'package:flutter_core_base/device_info/device_information_service.dart'
    as _i915;
import 'package:flutter_core_base/device_info/device_module.dart' as _i1006;
import 'package:flutter_core_base/logic/data/api_services/request/dio/dio_request.dart'
    as _i64;
import 'package:flutter_core_base/logic/data/local_data/base_local_request.dart'
    as _i306;
import 'package:flutter_core_base/logic/data/local_data/shared_preferences/shared_preferences_local_requests.dart'
    as _i656;
import 'package:flutter_core_base/flutter_core_base.dart' as _i705;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> wetonCoreBase({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    final connectivityModule = _$ConnectivityModule();
    final deviceInfoModule = _$DeviceInfoModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i895.Connectivity>(() => connectivityModule.connectivity);
    gh.lazySingleton<_i833.DeviceInfoPlugin>(
        () => deviceInfoModule.deviceInfoPlugin);
    gh.lazySingleton<_i671.ConnectionInformation>(() =>
        _i886.ConnectionInformationConnectivity(gh<_i895.Connectivity>()));
    gh.lazySingleton<_i705.AppRequest>(
        () => _i64.DioRequest(gh<_i705.ConnectionInformation>()));
    gh.lazySingleton<_i489.DeviceInformation>(
        () => _i915.DeviceInfoService(gh<_i833.DeviceInfoPlugin>()));
    gh.lazySingleton<_i306.BaseLocalRequest>(() =>
        _i656.SharedPreferencesLocalRequests(
            pref: gh<_i460.SharedPreferences>()));
    return this;
  }
}

class _$RegisterModule extends _i385.RegisterModule {}

class _$ConnectivityModule extends _i712.ConnectivityModule {}

class _$DeviceInfoModule extends _i1006.DeviceInfoModule {}
