import 'package:flutter/material.dart';
import 'store_card.dart'; // Import the Store and Product models
import 'map_screen.dart'; // Import the new MapScreen to show store location

// Stateless widget that shows the details of a store
class StoreDetailsScreen extends StatelessWidget {
  // Store object that holds the information about the store
  final Store store;

  // Constructor to initialize the store
  const StoreDetailsScreen({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Display the store's name in the AppBar
        title: Text(store.name),
        actions: [
          // IconButton to allow users to call the store by clicking the phone icon
          IconButton(
            icon: const Icon(Icons.call), // Call icon
            onPressed: () {
              // Open the phone dialer with the store's contact number
              launch('tel:${store.contact}');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the body content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
          children: [
            // Display store name in a bold, large font
            Text(
              store.name,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24, // Font size of 24 for the store name
                  ),
            ),
            const SizedBox(height: 8), // Add some vertical spacing
            // Display store address
            Text(
              store.address,
              style: TextStyle(color: Colors.grey[600], fontSize: 18), // Gray text with font size 18
            ),
            const SizedBox(height: 8), // Add vertical spacing
            // Display store contact number
            Text(
              'Contact: ${store.contact}',
              style: TextStyle(color: Colors.grey[600], fontSize: 18),
            ),
            const SizedBox(height: 8), // Add vertical spacing
            // Display store opening hours
            Text(
              'Opening Hours: ${store.openingHours}',
              style: TextStyle(color: Colors.grey[600], fontSize: 18),
            ),
            const SizedBox(height: 16), // Add more vertical spacing

            // Centered button for locating the store on a map
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigate to the MapScreen to display store location
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapScreen(store: store),
                    ),
                  );
                },
                icon: const Icon(Icons.map), // Map icon
                label: const Text('View on Map'), // Button text
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16), // Padding inside the button
                  textStyle: const TextStyle(fontSize: 18), // Text style with font size 18
                ),
              ),
            ),

            const SizedBox(height: 16), // Vertical spacing before the description section
            // Display "Description" heading
            Text(
              'Description:',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24, // Font size of 24 for heading
                  ),
            ),
            const SizedBox(height: 4), // Small vertical spacing
            // Display store description
            Text(
              store.description,
              style: TextStyle(color: Colors.grey[700], fontSize: 18),
            ),
            const SizedBox(height: 16), // Vertical spacing before the products section
            // Display "Available Products" heading
            Text(
              'Available Products:',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24, // Font size of 24 for heading
                  ),
            ),
            const SizedBox(height: 8), // Small vertical spacing
            // Display a list of products available in the store
            Expanded(
              child: ListView.builder(
                itemCount: store.products.length, // Number of products
                itemBuilder: (context, index) {
                  // Get each product from the store's product list
                  final product = store.products[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4), // Card margin for each product
                    child: ListTile(
                      title: Text(product.name), // Product name
                      subtitle: Text('\$${product.price.toStringAsFixed(2)}'), // Product price
                      trailing: Icon(
                        // Check if the product is available and show an icon accordingly
                        product.isAvailable ? Icons.check_circle : Icons.cancel,
                        color: product.isAvailable ? Colors.green : Colors.red, // Icon color based on availability
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to handle launching a phone dialer
  void launch(String url) {
    // Add your logic here to launch the phone dialer
  }
}

