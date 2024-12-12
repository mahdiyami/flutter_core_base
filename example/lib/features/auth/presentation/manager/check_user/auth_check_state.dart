part of 'auth_check_bloc.dart';

@freezed
class AuthCheckState with _$AuthCheckState {
  const factory AuthCheckState.initial() = _Initial;
  const factory AuthCheckState.loadInProgress() = _LoadInProgress;
  const factory AuthCheckState.loadSuccess(AuthCheckEntity authCheck) = _LoadSuccess;
  const factory AuthCheckState.loadFailure(Failure failure) = _LoadFailure;
}
