import 'package:bloc/bloc.dart';
import 'package:example/features/auth/domain/entities/auth_check.dart';
import 'package:example/features/auth/domain/usecases/auth_check_usecase.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_core_base/logic/data/api_services/error/error.dart';
import 'package:flutter_core_base/logic/domain/usecase/use_case.dart';
import 'package:flutter_core_base/logic/response/base_response.dart';

part 'auth_check_event.dart';
part 'auth_check_state.dart';
part 'auth_check_bloc.freezed.dart';

@Injectable()
class AuthCheckBloc extends Bloc<AuthCheckEvent, AuthCheckState> {
  final AuthCheckUseCase _authCheckUseCase;
  AuthCheckBloc(this._authCheckUseCase) : super(const AuthCheckState.initial()) {
    on<_AuthChecked>( _onAuthChecked);
  }


  void _onAuthChecked(_AuthChecked event, Emitter<AuthCheckState> emit) async {
    emit(const AuthCheckState.loadInProgress());
    final result = await _authCheckUseCase(NoParams());
    result.fold(
      (failure) => emit(AuthCheckState.loadFailure(failure)),
      (response) => emit(AuthCheckState.loadSuccess(response.data)),
    );
  }
}
