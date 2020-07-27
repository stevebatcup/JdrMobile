import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:jdr/services/local_storage_service.dart';
// Important. Import the locator.iconfig.dart file
import 'locator.config.dart';

final locator = GetIt.instance;

@injectableInit
Future<void> setupLocator() async {
  var localStorageInstance = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(localStorageInstance);
  $initGetIt(locator);
}
