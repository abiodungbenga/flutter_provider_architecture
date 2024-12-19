import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_flutter_provider_architecture/data/repo/pokemons_repo.dart';
import 'package:my_flutter_provider_architecture/exceptions/status_code_exception.dart';
import 'package:my_flutter_provider_architecture/model/pokemons_model.dart';

class PokemonProvider extends ChangeNotifier {
  final PokemonsRepo pokemonsRepo;

  PokemonProvider({required this.pokemonsRepo});

  PokemonsModel? _pokemonModel;
  PokemonsModel? get pokemonModel => _pokemonModel;

  Future<void> fetchPokemons() async {
    try {
      Response pokeMonsListData = await pokemonsRepo.fetchPokemons();

      return StatusCodeException.handleStatusCode(
        data: pokeMonsListData,
        onElse: (elseStatusCode, number) {
          print(
            number,
          );
        },
        onClientError: (clientErrorStatusCode) {
          print(
            "Client Error",
          );
        },
        onSuccess: (successStatusCode) {
          final dataString = jsonEncode(
            pokeMonsListData.data,
          );
          _pokemonModel = pokemonsModelFromJson(
            dataString,
          );
          print(
            pokeMonsListData.data,
          );
          notifyListeners();
        },
      );
    } on Exception catch (e) {
      print(
        e.toString(),
      );
      // TODO
    }
  }
}
