import 'dart:async';
import 'package:bloc_application/app/home/search_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCepBloc extends Bloc<String, SearchCepState> {
  final Dio dio;

  SearchCepBloc(this.dio) : super(SearchCepSuccess({}));

  @override
  Stream<SearchCepState> mapEventToState(String cep) async* {
    yield SearchCepLoading();
    try {
      final response = await dio.get('https://viacep.com.br/ws/$cep/json/');
      yield SearchCepSuccess(response.data as Map);
    } catch(e) {
      yield SearchCepError('Erro na pesquisa!');
    }
  }
}