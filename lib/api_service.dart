import 'dart:convert';
import 'package:http/http.dart' as http;
import 'student.dart';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  // Method to register a student
  Future<http.Response> registerStudent(Student student) async {
    try {
      print('Attempting to register student at: $baseUrl');
      print('Request Body: ${jsonEncode(student.toJson())}');

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Access-Control-Allow-Origin': '*',
          'Access-Control-Allow-Methods': 'POST, GET, OPTIONS, PUT, DELETE',
          'Access-Control-Allow-Headers': 'Origin, Content-Type, Accept',
        },
        body: jsonEncode(student.toJson()),
      );

      print('Request URL: $baseUrl');
      print('Request headers: ${response.request?.headers}');
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      return response;

    } catch (e) {
      print('Error during registration: $e');
      rethrow; // This will allow the error to be handled by the calling widget
    }
  }

  // Method to upload profile data
  Future<http.Response> uploadProfileData(Student student) async {
    final url =
        Uri.https('$baseUrl/Student/Post'); // Adjust the endpoint accordingly
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'studentId': student.studentId,
        'firstName': student.firstName,
        'lastName': student.lastName,
        'username': student.username,
        'phoneNumber': student.phoneNumber,
        'email': student.email,
        'dateOfBirth': student.dateOfBirth,
        'campusId': student.campusId,
        'registrationComplete': student.registrationComplete,
      }),
    );

    return response;
  }
}
