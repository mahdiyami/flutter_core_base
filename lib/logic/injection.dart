
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_core_base/dep_injection/get_it_instance.dart';
import 'package:flutter_core_base/logic/injection.config.dart';

@InjectableInit(
  initializerName: "wetonCoreBase"
)
Future<void> wetonCoreBaseConfigureDependencies() async => getIt.wetonCoreBase();