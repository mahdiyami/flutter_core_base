import 'package:example/injection.config.dart';
import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';



@InjectableInit(
  initializerName: 'example',
)
Future<void> shopBuilderInjection(GetIt getIt) async {
  getIt.example();


}
