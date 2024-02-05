// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:mobileappdev/service/auth_service.dart';
//
// class MockClient extends Mock implements http.Client {}
//
// void main() {
//   group('AuthService', () {
//     late AuthenticationService authService;
//     late MockClient mockClient;
//
//     setUp(() {
//       mockClient = MockClient();
//     });
//
//     test('login - success', () async {
//       // Arrange
//       when(mockClient.post(
//         Uri.parse('your_base_url/api/authenticate'),
//         body: jsonEncode({
//           'username': 'test_user',
//           'password': 'test_password',
//           'rememberMe': true,
//         }),
//         headers: {'Content-Type': 'application/json'},
//       )).thenAnswer((_) async => http.Response('{"authorization": "fake_token"}', 200));
//
//       // Act
//       final result = await authService.login('test_user', 'test_password', true);
//
//       // Assert
//       expect(result, 'fake_token');
//     });
//
//     test('login - failure', () async {
//       // Arrange
//       when(mockClient.post(
//         Uri.parse('your_base_url/api/authenticate'),
//         body: jsonEncode({
//           'username': 'test_user',
//           'password': 'test_password',
//           'rememberMe': true,
//         }),
//         headers: {'Content-Type': 'application/json'},
//       )).thenAnswer((_) async => http.Response('Failed to authenticate', 401));
//
//       // Act and Assert
//       expect(() async {
//         await authService.login('test_user', 'test_password', true);
//       }, throwsException);
//     });
//
//     // Add more tests as needed
//   });
// }
