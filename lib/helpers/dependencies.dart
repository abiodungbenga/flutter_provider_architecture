import 'package:get_it/get_it.dart';
import 'package:my_flutter_provider_architecture/data/api/api_service.dart';
import 'package:my_flutter_provider_architecture/data/repo/pokemons_repo.dart';

final locator = GetIt.instance;

Future<void> init() async {
  locator.registerLazySingleton<APIService>(
    () => APIService(
      baseUrl: "https://pokeapi.co/api/v2",
    ),
  );
  locator.registerLazySingleton<PokemonsRepo>(
    () => PokemonsRepo(
      apiService: locator<APIService>(),
    ),
  );
}
