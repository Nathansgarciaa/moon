import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

// Base class for all product-related events
abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Event to trigger fetching products
class FetchProductsEvent extends ProductEvent {}

// Base class for all product-related states
abstract class ProductState extends Equatable {
  @override
  List<Object> get props => [];
}

// Initial state before any action is taken
class ProductInitial extends ProductState {}

// State while products are being fetched
class ProductLoading extends ProductState {}

// State when products are successfully fetched
class ProductLoaded extends ProductState {
  final List products;

  ProductLoaded(this.products);

  @override
  List<Object> get props => [products];
}

// State when an error occurs during fetching
class ProductError extends ProductState {
  final String message;

  ProductError(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc to manage product events and states
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final Dio _dio; // Dependency to make network requests

  ProductBloc(this._dio) : super(ProductInitial()) {
    on<FetchProductsEvent>(_onFetchProducts);
  }

  // Method to handle the FetchProductsEvent
  Future<void> _onFetchProducts(
      FetchProductsEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading()); // Emit loading state
    try {
      // Fetch products from the API
      final response = await _dio.get('https://jsonplaceholder.typicode.com/posts');
      final List products = response.data; // Adjust based on your API response
      emit(ProductLoaded(products)); // Emit loaded state with products
    } catch (e) {
      // Emit error state with the error message
      emit(ProductError(e.toString()));
    }
  }
}
