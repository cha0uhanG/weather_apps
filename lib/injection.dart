import 'injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies(String env) => getIt.init(environment: env);
/*
void configureInjection(String env) {
  $initGetIt(getIt, environment: env);
}*/
