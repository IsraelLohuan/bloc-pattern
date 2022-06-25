import 'dart:async';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

abstract class SearchCepState {}

class SearchCepSuccess implements SearchCepState {
  final Map data;

  const SearchCepSuccess(this.data);
}

class SearchCepLoading implements SearchCepState {}

class SearchCepError implements SearchCepState {
  final String message;

  const SearchCepError(this.message);
}

class SearchCepBloc {

  final _streamController = StreamController<String>.broadcast();
  Sink<String> get searchCep => _streamController.sink;
  Stream<SearchCepState> get cepResult => _streamController.stream.switchMap(_searchCep);

  Stream<SearchCepState> _searchCep(String cep) async* {
    yield SearchCepLoading();
    try {
      final response = await Dio().get('https://viacep.com.br/ws/$cep/json/');
      yield SearchCepSuccess(response.data as Map);
    } catch(e) {
      yield SearchCepError('Erro na pesquisa!');
    }
  }

  void dispose() {
    _streamController.close();
  }
}