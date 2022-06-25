import 'dart:async';
import 'package:bloc_application/app/home/search_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCepBloc extends Cubit<SearchCepState> {
  final Dio dio;

  SearchCepBloc(this.dio) : super(SearchCepSuccess({}));

  Future<void> searchCep(String cep) async {
    emit(SearchCepLoading());
    try {
      final response = await dio.get('https://viacep.com.br/ws/$cep/json/');
      emit(SearchCepSuccess(response.data as Map));
    } catch(e) {
      emit(SearchCepError('Erro na pesquisa!'));
    }
  }
}