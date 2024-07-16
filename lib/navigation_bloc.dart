import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Navigation Events
abstract class NavigationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class NavigateToSplash extends NavigationEvent {}
class NavigateToLogin extends NavigationEvent {}
class NavigateToRegister extends NavigationEvent {}
class NavigateToHome extends NavigationEvent {}

// Navigation States
abstract class NavigationState extends Equatable {
  @override
  List<Object> get props => [];
}

class SplashScreenState extends NavigationState {}
class LoginScreenState extends NavigationState {}
class RegisterScreenState extends NavigationState {}
class HomeScreenState extends NavigationState {}

// Navigation BLoC
class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(SplashScreenState()) {
    on<NavigateToSplash>((event, emit) => emit(SplashScreenState()));
    on<NavigateToLogin>((event, emit) => emit(LoginScreenState()));
    on<NavigateToRegister>((event, emit) => emit(RegisterScreenState()));
    on<NavigateToHome>((event, emit) => emit(HomeScreenState()));
  }
}
