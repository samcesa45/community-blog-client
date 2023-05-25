part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

final class RegisterUsernameChanged extends RegisterEvent {
  final String username;
  const RegisterUsernameChanged(this.username);

  @override
  List<Object> get props => [username];
}

final class RegisterPasswordChanged extends RegisterEvent {
  final String password;
  const RegisterPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

final class RegisterEmailChanged extends RegisterEvent {
  final String email;
  const RegisterEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

final class RegisterSubmitted extends RegisterEvent {
  const RegisterSubmitted();
}
