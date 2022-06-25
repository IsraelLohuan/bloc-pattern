import 'package:bloc_application/app/home/search_cep_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final i =  GetIt.instance;

initModule() {
  i.registerFactory(() => Dio());
  i.registerSingleton<SearchCepBloc>(SearchCepBloc(i()));
}

releaseModule() {
  i<SearchCepBloc>().close();
  i.unregister<Dio>();
  i.unregister<SearchCepBloc>();
}