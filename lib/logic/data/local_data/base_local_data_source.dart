

import 'package:flutter_core_base/dep_injection/get_it_instance.dart';
import 'package:flutter_core_base/logic/data/local_data/base_local_request.dart';

abstract class BaseLocalDataSource {
  final BaseLocalRequest localRequest = getIt<BaseLocalRequest>();
}
