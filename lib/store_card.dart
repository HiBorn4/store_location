// Class representing a store with various details
class Store {
  // Name of the store
  final String name;
  
  // Address of the store
  final String address;
  
  // Contact number of the store
  final String contact; // New contact field added
  
  // Opening hours of the store
  final String openingHours;
  
  // Description of the store
  final String description;
  
  // Distance to the store (for showing how far it is from the user)
  final double distance;
  
  // Latitude of the store's location (for map display)
  final double latitude;
  
  // Longitude of the store's location (for map display)
  final double longitude;

  // List of products available in the store
  final List<Product> products;

  // Constructor to initialize all the fields of the Store class
  Store({
    required this.name,
    required this.address,
    required this.contact,  // Initialize contact field
    required this.openingHours,
    required this.description,
    required this.products,
    required this.distance,  // Initialize distance field
    required this.latitude,  // Initialize latitude field
    required this.longitude, // Initialize longitude field
  });
}

// Class representing a product with details
class Product {
  // Name of the product
  final String name;

  // Price of the product
  final double price;

  // Availability status of the product (true if available, false otherwise)
  final bool isAvailable;

  // Constructor to initialize all the fields of the Product class
  Product({
    required this.name,
    required this.price,
    required this.isAvailable, // Initialize availability status
  });
}
