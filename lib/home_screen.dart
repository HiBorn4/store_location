import 'package:flutter/material.dart';
import 'store_card.dart'; // Import the Store and Product models
import 'store_details.dart'; // Import the StoreDetailsScreen
import 'favourites_screen.dart'; // Import the FavouritesScreen

// Main app widget
class StoreListApp extends StatefulWidget {
  const StoreListApp({super.key});

  @override
  _StoreListAppState createState() => _StoreListAppState();
}

class _StoreListAppState extends State<StoreListApp> {
  bool isDarkMode = false; // Boolean to toggle dark mode
  final List<Store> favoriteStores = []; // List to store favorite stores

  // Method to toggle favorite status for a store
  void toggleFavorite(Store store) {
    setState(() {
      if (favoriteStores.contains(store)) {
        favoriteStores.remove(store); // Remove from favorites if already added
      } else {
        favoriteStores.add(store); // Add to favorites if not already added
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Store List', // Title of the app
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(), // Toggle between dark and light themes
      home: StoreListScreen(
        isDarkMode: isDarkMode, // Pass dark mode state to the screen
        onToggleDarkMode: () {
          setState(() {
            isDarkMode = !isDarkMode; // Toggle dark mode on button press
          });
        },
        favoriteStores: favoriteStores, // Pass the favorite stores list
        onToggleFavorite: toggleFavorite, // Pass the favorite toggle function
      ),
    );
  }
}

// Main screen showing the list of stores
class StoreListScreen extends StatefulWidget {
  final bool isDarkMode; // Dark mode flag
  final VoidCallback onToggleDarkMode; // Callback to toggle dark mode
  final List<Store> favoriteStores; // List of favorite stores
  final Function(Store) onToggleFavorite; // Function to toggle favorite status

  const StoreListScreen({
    super.key,
    required this.isDarkMode,
    required this.onToggleDarkMode,
    required this.favoriteStores,
    required this.onToggleFavorite,
  });

  @override
  _StoreListScreenState createState() => _StoreListScreenState();
}

class _StoreListScreenState extends State<StoreListScreen> {
  // List of stores to display
  final List<Store> stores = [
    // Store 1
    Store(
      name: 'Green Grocer',
      address: 'Bandra West, Mumbai',
      distance: 2.5,
      contact: '8989785677',
      openingHours: '9:00 AM - 8:00 PM',
      description: 'A general store with a variety of goods.',
      latitude: 19.0596,
      longitude: 72.8295,
      products: [
        Product(name: 'Organic Apples', price: 3.99, isAvailable: true),
        Product(name: 'Whole Wheat Bread', price: 2.49, isAvailable: false),
        Product(name: 'Almond Milk', price: 2.99, isAvailable: true),
      ],
    ),
    // More store data...
  ];

  String query = ''; // Search query

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            SizedBox(width: 10),
            Text('Store List'), // Title of the screen
          ],
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite), // Favorite button in the AppBar
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FavouritesScreen(favoriteStores: widget.favoriteStores), // Navigate to Favourites screen
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.settings), // Settings button in AppBar
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Dark Mode'),
                    Switch(
                      value: widget.isDarkMode, // Show dark mode toggle switch
                      onChanged: (bool value) {
                        widget.onToggleDarkMode(); // Toggle dark mode on switch press
                        Navigator.pop(context); // Close popup menu after switching
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search), // Search icon in the text field
                labelText: 'Search Store', // Placeholder text for the search field
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), // Rounded corners for the text field
                ),
              ),
              onChanged: (value) {
                setState(() {
                  query = value.toLowerCase(); // Update search query when text is entered
                });
              },
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: stores
                  .where((store) => store.name.toLowerCase().contains(query)) // Filter stores by search query
                  .map((store) => Card(
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // Rounded corners for store cards
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue.shade100, // Light blue background for the icon
                            child: Icon(Icons.store, color: Colors.blue.shade700), // Store icon
                          ),
                          title: Text(
                            store.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 4),
                              Text(store.address), // Store address
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.location_on,
                                      size: 16, color: Colors.grey), // Location icon
                                  const SizedBox(width: 4),
                                  Text('${store.distance} km away',
                                      style: const TextStyle(color: Colors.grey)), // Store distance
                                ],
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Chip(
                                label: Text(
                                  '${store.distance} km', // Distance chip
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                                backgroundColor: Colors.blue, // Blue color for the distance chip
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 4),
                              ),
                              IconButton(
                                icon: Icon(
                                  widget.favoriteStores.contains(store)
                                      ? Icons.favorite
                                      : Icons.favorite_border, // Toggle favorite icon
                                  color: widget.favoriteStores.contains(store)
                                      ? Colors.red
                                      : null,
                                ),
                                onPressed: () {
                                  widget.onToggleFavorite(store); // Toggle favorite status on icon press
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    StoreDetailsScreen(store: store), // Navigate to store details screen on tap
                              ),
                            );
                          },
                        ),
                      ))
                  .toList(), // Convert filtered stores to a list of widgets
            ),
          ),
        ],
      ),
    );
  }
}


