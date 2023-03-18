import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:icare_pro/application/api/endpoints.dart';
import 'package:icare_pro/domain/entities/appointment.dart';
import 'package:icare_pro/domain/entities/patient.dart';
import 'package:icare_pro/domain/entities/user.dart';
import 'package:icare_pro/domain/value_objects/app_strings.dart';

const FlutterSecureStorage storage = FlutterSecureStorage();

class APIService {
  // handle the api futures here

}

// register doctor into the application
Future<User> registerUser(User user) async {
  Uri url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.registerDoctor);
  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'first_name': user.firstName,
        'last_name': user.lastName,
        'email': user.email,
        'phone_number': user.phoneNumber,
        'password': user.password,
        'gender': user.gender,
        'date_of_birth': user.dateOfBirth,
        'bio': user.bio,
        'specialization': user.specialization,
        'years_of_experience': user.yearsOfExperience,
        'clinic': user.clinic,
        'address': user.address,
        'is_doctor': user.isDoctor,
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return User.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw jsonDecode(response.body)['message'];
    }
  } catch (e) {
    rethrow;
  }
}

// login doctor into the application
Future<User> loginUser(User user) async {
  Uri url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.loginDoctor);
  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': user.email!,
        'password': user.password!,
      }),
    );

    if (response.statusCode == 200) {
      final authToken = jsonDecode(response.body)['tokens'];
      await storage.write(key: 'access', value: authToken['access']);
      await storage.write(key: 'refresh', value: authToken['refresh']);

      return User.fromJson(jsonDecode(response.body));
    } else {
      throw jsonDecode(response.body)['message'];
    }
  } catch (e) {
    rethrow;
  }
}

// logout doctor out of the application
Future<User> logoutUser() async {
  final authToken = await storage.read(key: 'access');
  final refreshToken = await storage.read(key: 'refresh');

  Uri url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.logoutDoctor);
  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'refresh': '$refreshToken',
      }),
    );

    if (response.statusCode == 205) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw jsonDecode(response.body)['message'];
    }
  } catch (e) {
    rethrow;
  }
}

// delete doctor out of the application
Future<User> optoutUser() async {
  final authToken = await storage.read(key: 'access');

  Uri url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.optoutDoctor);
  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 204) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw jsonDecode(response.body)['message'];
    }
  } catch (e) {
    rethrow;
  }
}

// get profile details
Future<User> getProfile() async {
  final authToken = await storage.read(key: 'access');
  Uri url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.profileView);
  try {
    final response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw jsonDecode(response.body)['message'];
    }
  } catch (e) {
    rethrow;
  }
}

// edit profile details
Future<User> editUserProfile(User user) async {
  final authToken = await storage.read(key: 'access');

  Uri url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.editProfileView);
  try {
    final response = await http.put(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'first_name': user.firstName,
        'last_name': user.lastName,
        'email': user.email,
        'phone_number': user.phoneNumber,
        'password': user.password,
        'gender': user.gender,
        'date_of_birth': user.dateOfBirth,
        'bio': user.bio,
        'specialization': user.specialization,
        'years_of_experience': user.yearsOfExperience,
        'clinic': user.clinic,
        'address': user.address,
        'is_doctor': user.isDoctor,
      }),
    );

    if (response.statusCode == 201) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw jsonDecode(response.body)['message'];
    }
  } catch (e) {
    rethrow;
  }
}

// get upcoming appointments
Future<List<Appointment>> getUpcomingAppointments() async {
  final authToken = await storage.read(key: 'access');
  Uri url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.viewAppointments);
  try {
    final response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      Iterable jsonList = json.decode(response.body);
      return List<Appointment>.from(
          jsonList.map((model) => Appointment.fromJson(model)));
    } else {
      throw jsonDecode(response.body)['message'];
    }
  } catch (e) {
    rethrow;
  }
}

// get canceled appointments
Future<List<Appointment>> getCanceledAppointments() async {
  final authToken = await storage.read(key: 'access');
  Uri url =
      Uri.parse(APIEndpoints.baseUrl + APIEndpoints.viewCanceledAppointments);
  try {
    final response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      Iterable jsonList = json.decode(response.body);
      return List<Appointment>.from(
          jsonList.map((model) => Appointment.fromJson(model)));
    } else {
      throw jsonDecode(response.body)['message'];
    }
  } catch (e) {
    rethrow;
  }
}

// get past appointments
Future<List<Appointment>> getPastAppointments() async {
  final authToken = await storage.read(key: 'access');
  Uri url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.viewPastAppointments);
  try {
    final response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      Iterable jsonList = json.decode(response.body);
      return List<Appointment>.from(
          jsonList.map((model) => Appointment.fromJson(model)));
    } else {
      throw jsonDecode(response.body)['message'];
    }
  } catch (e) {
    rethrow;
  }
}

// get a list of patients
Future<List<Patient>> getPatients() async {
  final authToken = await storage.read(key: 'access');
  Uri url = Uri.parse(APIEndpoints.baseUrl + APIEndpoints.patientsList);
  try {
    final response = await http.get(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer $authToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      Iterable jsonList = json.decode(response.body);
      return List<Patient>.from(
          jsonList.map((model) => Patient.fromJson(model)));
    } else {
      throw jsonDecode(response.body)['message'];
    }
  } catch (e) {
    rethrow;
  }
}
