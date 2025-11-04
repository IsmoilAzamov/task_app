import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/network/datastate.dart';
import '../../../domain/repositories/authors_repository.dart';

import 'authors_event.dart';
import 'authors_state.dart';
export 'authors_event.dart';
export 'authors_state.dart';

class AuthorsBloc extends Bloc<AuthorsEvent, AuthorsState> {
  final AuthorsRepository _authorsRepository;

  AuthorsBloc(this._authorsRepository) : super(AuthorsInitialState()) {
    on<AuthorsLoadEvent>(_load);
  }

  Future<void> _load(AuthorsLoadEvent event, Emitter<AuthorsState> emit) async {
    emit(AuthorsLoadingState());
    final result = await _authorsRepository.getAuthors(event.searchQuery);

    if (result is DataSuccess && result.data != null) {
      emit(AuthorsLoadedState(result.data!));
      return;
    } else if (result is DataError) {
      emit(AuthorsErrorState(result.error?.error.toString() ?? "Error occured"));
      return;
    }
  }
}
