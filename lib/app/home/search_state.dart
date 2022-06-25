import 'package:equatable/equatable.dart';

abstract class SearchCepState {}

class SearchCepSuccess extends Equatable implements SearchCepState {
  final Map data;

  const SearchCepSuccess(this.data);
  
  @override
  List<Object?> get props => [data];
}

class SearchCepLoading implements SearchCepState {}

class SearchCepError implements SearchCepState {
  final String message;

  const SearchCepError(this.message);
}
