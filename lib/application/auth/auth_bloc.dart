import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class AuthBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
@injectable
class AuthBlocState extends Equatable {
  @override
  List<Object?> get props => [];
}
@injectable
class DataLoading extends AuthBlocState {}
@injectable
class DataValueFailed extends AuthBlocState {
  final String message;

  DataValueFailed(this.message);
}
@injectable
class InitialState extends AuthBlocState {}

@injectable
class SignInCompleted extends AuthBlocState {}

@injectable
class SignUpCompleted extends AuthBlocState {}

@injectable
class PerformSignIn extends AuthBlocEvent {
  final String email;
  final String password;

  PerformSignIn(this.email, this.password);
}

@injectable
class PerformSignUp extends AuthBlocEvent {
  final String email;
  final String password;

  PerformSignUp(this.email, this.password);
}

@injectable
class AuthBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final fireBase = FirebaseAuth.instance;

 // AuthBloc(super.initialState);
  AuthBloc() : super(InitialState()) {

    // event handler was added

    on<AuthBlocEvent>(mapEventToState);
  }


  @override
  Stream<AuthBlocState> mapEventToState(AuthBlocEvent event, Emitter<AuthBlocState> emit) async* {
    if (event is PerformSignIn) {
      yield DataLoading();
      try {
        var loggedUser = await fireBase.signInWithEmailAndPassword(email: event.email, password: event.password);
        if (loggedUser != null) {
          yield SignInCompleted();
        }
      } catch (e) {
        yield DataValueFailed(e.toString());
      }
    } else if (event is PerformSignUp) {
      yield DataLoading();
      try {
        var loggedUser = await fireBase.createUserWithEmailAndPassword(
            email: event.email, password: event.password);
        if (loggedUser != null) {
          yield SignUpCompleted();
        }
      } catch (e) {
        yield DataValueFailed(e.toString());
      }
    }
  }
}
