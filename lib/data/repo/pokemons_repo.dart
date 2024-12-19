import 'package:dio/dio.dart';
import 'package:my_flutter_provider_architecture/data/api/api_service.dart';

class PokemonsRepo {
  final APIService apiService;

  PokemonsRepo({required this.apiService});

  Future<Response> fetchPokemons() async {
    return await apiService.request(
      "/pokemon/ditto",
      DioMethod.get,
    );
  }
}
