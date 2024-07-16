import 'package:bloc/bloc.dart'; // Importing the BLoC package for state management
import 'package:equatable/equatable.dart'; // Importing Equatable for value equality

// Navigation Events

// Base class for all navigation-related events
abstract class NavigationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Event to navigate to the Splash screen
class NavigateToSplash extends NavigationEvent {}

// Event to navigate to the Login screen
class NavigateToLogin extends NavigationEvent {}

// Event to navigate to the Register screen
class NavigateToRegister extends NavigationEvent {}

// Event to navigate to the Home screen
class NavigateToHome extends NavigationEvent {}

// Navigation States

// Base class for all navigation-related states
abstract class NavigationState extends Equatable {
  @override
  List<Object> get props => [];
}

// State representing the Splash screen
class SplashScreenState extends NavigationState {}

// State representing the Login screen
class LoginScreenState extends NavigationState {}

// State representing the Register screen
class RegisterScreenState extends NavigationState {}

// State representing the Home screen
class HomeScreenState extends NavigationState {}

// Navigation BLoC

// BLoC for handling navigation events and states
class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  // Constructor to initialize the NavigationBloc with an initial state
  NavigationBloc() : super(SplashScreenState()) {
    // Registering event handlers

    // Handle NavigateToSplash event
    on<NavigateToSplash>((event, emit) => emit(SplashScreenState()));

    // Handle NavigateToLogin event
    on<NavigateToLogin>((event, emit) => emit(LoginScreenState()));

    // Handle NavigateToRegister event
    on<NavigateToRegister>((event, emit) => emit(RegisterScreenState()));

    // Handle NavigateToHome event
    on<NavigateToHome>((event, emit) => emit(HomeScreenState()));
  }
}
