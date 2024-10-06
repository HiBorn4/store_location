import 'package:flutter/material.dart';
import 'store_card.dart'; // Import the Store model to access store details
import 'store_details.dart'; // Import the StoreDetailsScreen to navigate to store details page

// This screen displays the user's favorite stores.
class FavouritesScreen extends StatelessWidget {
  // List of favorite stores passed from another screen.
  final List<Store> favoriteStores;

  // Constructor to initialize the list of favorite stores.
  const FavouritesScreen({super.key, required this.favoriteStores});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar with the title "Favourites"
      appBar: AppBar(
        title: const Text('Favourites'),
      ),
      // Body of the screen, checking if the list of favorite stores is empty
      body: favoriteStores.isEmpty
          // If no stores are marked as favorite, show a message in the center
          ? const Center(child: Text('No favorite stores added.'))
          // If there are favorite stores, display them in a list
          : ListView.builder(
              // Set the number of items in the list based on the number of favorite stores
              itemCount: favoriteStores.length,
              // Build the list of favorite stores
              itemBuilder: (context, index) {
                // Get the store at the current index
                final store = favoriteStores[index];
                return ListTile(
                  // Display the store's name in the title
                  title: Text(store.name),
                  // Display the store's address in the subtitle
                  subtitle: Text(store.address),
                  // When the store is tapped, navigate to the StoreDetailsScreen
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        // Pass the store details to the StoreDetailsScreen
                        builder: (context) => StoreDetailsScreen(store: store),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}


