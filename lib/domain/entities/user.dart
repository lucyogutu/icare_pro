class User {
  final String? firstName;
  final String? lastName;
  final String? email;
  final int? phoneNumber;
  final String? password;
  final String? gender;
  final String? dateOfBirth;
  final String? bio;
  final String? specialization;
  final int? yearsOfExperience;
  final String? clinic;
  final String address;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.password,
    required this.gender,
    required this.dateOfBirth,
    required this.bio,
    required this.specialization,
    required this.yearsOfExperience,
    required this.clinic,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      password: json['password'],
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'],
      bio: json['bio'],
      specialization: json['specialization'],
      yearsOfExperience: json['years_of_experience'],
      clinic: json['clinic'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone_number': phoneNumber,
        'password': password,
        'gender': gender,
        'date_of_birth': dateOfBirth,
        'bio': bio,
        'specialization': specialization,
        'years_of_experience': yearsOfExperience,
        'clinic': clinic,
        'address': address,
      };
}
