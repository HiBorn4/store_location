import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart'; // Import the Flutter map package
import 'package:latlong2/latlong.dart'; // Import the LatLong package to work with map coordinates
import 'store_card.dart'; // Import the Store model to get store details like latitude and longitude

// Stateless widget to show the map with the store's location
class MapScreen extends StatelessWidget {
  // Store object that contains the details of the store, including location coordinates
  final Store store;

  // Constructor to initialize the store
  const MapScreen({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    // Get the device's screen size and padding to calculate available space
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height; // Total screen height
    final appBarHeight = AppBar().preferredSize.height; // AppBar height
    final statusBarHeight =
        mediaQuery.padding.top; // Height of the status bar (top padding)
    final bottomPadding = mediaQuery.padding
        .bottom; // Padding at the bottom of the screen (e.g., for navigation bar)

    // Calculate the available height for the map (total screen height minus the app bar, status bar, and bottom padding)
    final mapHeight =
        screenHeight - appBarHeight - statusBarHeight - bottomPadding;

    return Scaffold(
      appBar: AppBar(
        // Display the store's name followed by "Location" in the AppBar title
        title: Text('${store.name} Location'),
      ),
      body: Column(
        children: [
          // SizedBox to define the map's height based on available space
          SizedBox(
            height: mapHeight,
            child: FlutterMap(
              // MapOptions to configure the map's initial settings
              options: MapOptions(
                // Set the initial center of the map to the store's location using latitude and longitude
                initialCenter: LatLng(store.latitude, store.longitude),
                initialZoom: 13.0, // Set the initial zoom level of the map
              ),
              children: [
                // TileLayer is used to load and display map tiles from OpenStreetMap
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const [
                    'a',
                    'b',
                    'c'
                  ], // Subdomains for tile layer
                ),
                // MarkerLayer to display a marker at the store's location
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 40.0, // Width of the marker
                      height: 40.0, // Height of the marker
                      point: LatLng(
                          store.latitude,
                          store
                              .longitude), // Position of the marker (store's coordinates)
                      // Custom marker widget, using an icon
                      child: const Icon(
                        Icons.location_on, // Location pin icon
                        color: Colors.red, // Marker color
                        size: 40.0, // Marker size
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Get Directions', // Tooltip for the floating button
        child: const Icon(
            Icons.directions), // Icon for the floating button (directions icon)
      ),
    );
  }
}
