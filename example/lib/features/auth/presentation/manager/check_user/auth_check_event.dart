part of 'auth_check_bloc.dart';

@freezed
class AuthCheckEvent with _$AuthCheckEvent {
  const factory AuthCheckEvent.authChecked() = _AuthChecked;
}
