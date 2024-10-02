class User {
  final String firstName;
  final String lastName;
  final String city; // Changed from address to city
  final String contactNumber; // Changed from phoneNumber to contactNumber

  User({
    required this.firstName,
    required this.lastName,
    required this.city,
    required this.contactNumber,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'],
      lastName: json['last_name'],
      city: json['city'],
      contactNumber: json['contact_number'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'city': city,
      'contact_number': contactNumber,
    };
  }
}
