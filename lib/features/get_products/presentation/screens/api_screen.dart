import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import '../controllers/product_bloc.dart';


// Stateful widget to manage the API screen state
class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});

  @override
  ApiScreenState createState() => ApiScreenState();
}

// State class for ApiScreen
class ApiScreenState extends State<ApiScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Provide the ProductBloc to the widget tree
      create: (context) => ProductBloc(Dio())..add(FetchProductsEvent()), // Initialize ProductBloc and fetch products
      child: Scaffold(
        appBar: AppBar(
          title: const Text('API Screen'), // Title for the AppBar
          backgroundColor: Colors.grey[850], // Background color for the AppBar
          leading: IconButton(
            icon: const Icon(Icons.arrow_back), // Back button icon
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home'); // Navigate back to home screen
            },
          ),
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          // Build UI based on the current state of ProductBloc
          builder: (context, state) {
            if (state is ProductLoading) {
              // Show a loading indicator while products are being fetched
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              // Display the list of products when they are successfully loaded
              return Padding(
                padding: const EdgeInsets.all(16.0), // Add padding around the list
                child: Column(
                  children: [
                    Expanded(
                      // Create a horizontal ListView to display products
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.products.length, // Number of products to display
                        itemBuilder: (context, index) {
                          final product = state.products[index]; // Get the product at the current index
                          return Container(
                            width: 200, // Set the width of each product container
                            margin: const EdgeInsets.symmetric(horizontal: 8.0), // Margin between product containers
                            padding: const EdgeInsets.all(8.0), // Padding inside each product container
                            decoration: BoxDecoration(
                              color: Colors.white, // Background color for the container
                              borderRadius: BorderRadius.circular(8.0), // Rounded corners
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12, // Shadow color
                                  blurRadius: 4.0, // Blur radius for the shadow
                                  offset: Offset(0, 2), // Offset for the shadow
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start
                              children: [
                                Text(
                                  product['title'], // Display product title
                                  style: const TextStyle(
                                    fontSize: 16.0, // Font size for the title
                                    fontWeight: FontWeight.bold, // Bold font weight
                                  ),
                                ),
                                const SizedBox(height: 8.0), // Add space between title and description
                                Text(
                                  product['body'] ?? 'No description available', // Display product description or fallback text
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is ProductError) {
              // Display an error message if there's an error fetching products
              return Center(child: Text('Error: ${state.message}'));
            } else {
              // Default state when there are no products
              return const Center(child: Text('No Products'));
            }
          },
        ),
      ),
    );
  }
}
