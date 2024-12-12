import 'package:flutter_core_base/dep_injection/get_it_instance.dart';
import 'package:flutter_core_base/logic/data/api_services/request/request.dart';

abstract class BaseRemoteDataSource {
  AppRequest get appRequest => getIt<AppRequest>();
}
