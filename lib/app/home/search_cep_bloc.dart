import 'dart:async';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

class SearchCepBloc {

  final _streamController = StreamController<String>.broadcast();
  Sink<String> get searchCep => _streamController.sink;
  Stream<Map> get cepResult => _streamController.stream.switchMap(_searchCep);

  Stream<Map> _searchCep(String cep) async* {
    try {
      final response = await Dio().get('https://viacep.com.br/ws/$cep/json/');
      yield response.data as Map;
    } catch(e) {
      yield* Stream.error(Exception('Erro na pesquisa!'));
    }
  }

  void dispose() {
    _streamController.close();
  }
}