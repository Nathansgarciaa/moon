import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';



// Base class for all authentication-related events
abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Event for logging in
class LoginEvent extends AuthEvent {
  final String email; // User's email for login
  final String password; // User's password for login

  // Constructor to initialize email and password
  LoginEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password]; // Properties for comparison
}

// Event for registering a new user
class RegisterEvent extends AuthEvent {
  final String email; // User's email for registration
  final String password; // User's password for registration

  // Constructor to initialize email and password
  RegisterEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password]; // Properties for comparison
}

// Event for logging out
class LogoutEvent extends AuthEvent {}

// States

// Base class for all authentication-related states
abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

// Initial state before any authentication action
class AuthInitial extends AuthState {}

// State while authentication action is in progress
class AuthLoading extends AuthState {}

// State when the user is authenticated
class AuthAuthenticated extends AuthState {}

// State when an error occurs during authentication
class AuthError extends AuthState {
  final String message; // Error message

  // Constructor to initialize the error message
  AuthError(this.message);

  @override
  List<Object> get props => [message]; // Properties for comparison
}

// BLoC

// BLoC for handling authentication events and states
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _firebaseAuth; // Firebase Authentication instance

  // Constructor to initialize FirebaseAuth and set up event handlers
  AuthBloc(this._firebaseAuth) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent); // Register handler for LoginEvent
    on<RegisterEvent>(_onRegisterEvent); // Register handler for RegisterEvent
    on<LogoutEvent>(_onLogoutEvent); // Register handler for LogoutEvent
  }

  // Handler for LoginEvent
  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading()); // Emit loading state
    try {
      // Attempt to sign in with email and password
      await _firebaseAuth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(AuthAuthenticated()); // Emit authenticated state
    } catch (e) {
      emit(AuthError(e.toString())); // Emit error state with message
    }
  }

  // Handler for RegisterEvent
  Future<void> _onRegisterEvent(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading()); // Emit loading state
    try {
      // Attempt to create a new user with email and password
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(AuthAuthenticated()); // Emit authenticated state
    } catch (e) {
      emit(AuthError(e.toString())); // Emit error state with message
    }
  }

  // Handler for LogoutEvent
  Future<void> _onLogoutEvent(LogoutEvent event, Emitter<AuthState> emit) async {
    await _firebaseAuth.signOut(); // Sign out the current user
    emit(AuthInitial()); // Emit initial state
  }
}
