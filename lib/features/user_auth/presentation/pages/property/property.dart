class Property {
  final String title;
  final String description;
  final String price;
  final String location;
  final String imagePath;
  final String ownerName;
  final String ownerContact;  // Owner's phone/WhatsApp number
  final String contactEmail;  // Owner's email
  final String telegramUsername; // Owner's Telegram username
  final int bedrooms;  // Number of bedrooms
  final int bathrooms; // Number of bathrooms
  final int area;      // Area in square feet or meters

  Property({
    required this.title,
    required this.description,
    required this.price,
    required this.location,
    required this.imagePath,
    required this.ownerName,
    required this.ownerContact,
    required this.contactEmail,
    required this.telegramUsername,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
  });
}

List<Property> favoriteProperties = [];
final List<Property> properties = [
  Property(
    title: 'Luxury Villa',
    description: 'A beautiful luxury villa with 5 bedrooms and 3 bathrooms.',
    price: '\$1,200,000',
    location: 'Los Angeles, CA',
    imagePath: 'images/house1.jpg',
    ownerName: 'John Doe',
    ownerContact: '+251988734529',  // Phone and WhatsApp number
    contactEmail: 'calebworku01@gmail.com',  // Email
    telegramUsername: 'cayshred',
        bedrooms: 5,  // Number of bedrooms
    bathrooms: 3, // Number of bathrooms
    area: 3500,   // Area in square feet
  ),
  Property(
    title: 'Modern Family House',
    description: 'A modern family house with 4 beds and a large backyard.',
    price: '\$500,000',
    location: 'Austin, TX',
    imagePath: 'images/house2.jpg',
    ownerName: 'Jane Smith',
    ownerContact: '+251988734529',  // Phone and WhatsApp number
    contactEmail: 'calebworku01@gmail.com',  // Email
    telegramUsername: 'cayshred',
        bedrooms: 5,  // Number of bedrooms
    bathrooms: 3, // Number of bathrooms
    area: 3500,   // Area in square feet
  ),
  Property(
    title: 'Modern Family House',
    description: 'A modern family house with 4 beds and a large backyard.',
    price: '\$500,000',
    location: 'Austin, TX',
    imagePath: 'images/house3.jpg',
    ownerName: 'Jane Smith',
    ownerContact: '+251988734529',  // Phone and WhatsApp number
    contactEmail: 'calebworku01@gmail.com',  // Email
    telegramUsername: 'cayshred',
        bedrooms: 5,  // Number of bedrooms
    bathrooms: 3, // Number of bathrooms
    area: 3500,   // Area in square feet
  ),
  Property(
    title: 'Modern Family House',
    description: 'A modern family house with 4 beds and a large backyard.',
    price: '\$500,000',
    location: 'Austin, TX',
    imagePath: 'images/house4.jpg',
    ownerName: 'Jane Smith',
    ownerContact: '+251988734529',  // Phone and WhatsApp number
    contactEmail: 'calebworku01@gmail.com',  // Email
    telegramUsername: 'cayshred',
        bedrooms: 5,  // Number of bedrooms
    bathrooms: 3, // Number of bathrooms
    area: 3500,   // Area in square feet
  ),
  Property(
    title: 'Modern Family House',
    description: 'A modern family house with 4 beds and a large backyard.',
    price: '\$500,000',
    location: 'Austin, TX',
    imagePath: 'images/house5.jpg',
    ownerName: 'Jane Smith',
    ownerContact: '+251988734529',  // Phone and WhatsApp number
    contactEmail: 'calebworku01@gmail.com',  // Email
    telegramUsername: 'cayshred',
        bedrooms: 5,  // Number of bedrooms
    bathrooms: 3, // Number of bathrooms
    area: 3500,   // Area in square feet
  ),
  Property(
    title: 'Modern Family House',
    description: 'A modern family house with 4 beds and a large backyard.',
    price: '\$500,000',
    location: 'Austin, TX',
    imagePath: 'images/house6.jpg',
    ownerName: 'Jane Smith',
    ownerContact: '+251988734529',  // Phone and WhatsApp number
    contactEmail: 'calebworku01@gmail.com',  // Email
    telegramUsername: 'cayshred',
        bedrooms: 5,  // Number of bedrooms
    bathrooms: 3, // Number of bathrooms
    area: 3500,   // Area in square feet
  ),
  // Add more properties with contact details
];

