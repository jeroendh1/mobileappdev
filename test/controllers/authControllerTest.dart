// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:mobileappdev/viewmodel/Auth_viewmodel.dart';
// import 'package:mobileappdev/service/auth_service.dart';
// import 'package:mobileappdev/data/SecureStorage.dart';
//
// class MockAuthService extends Mock implements AuthenticationService {}
//
// class MockSecureStorage extends Mock implements SecureStorage {}
//
// void main() {
//   late AuthenticationViewModel authViewModel;
//   late MockAuthService mockAuthService;
//   late MockSecureStorage mockSecureStorage;
//   late SharedPreferences mockPrefs;
//
//   setUp(() async {
//     mockAuthService = MockAuthService();
//     mockSecureStorage = MockSecureStorage();
//     mockPrefs = await SharedPreferences.getInstance();
//
//     authViewModel = AuthenticationViewModel();
//   });
//   group('AuthenticationViewModel', () {
//     test('login - successful login', () async {
//       // Mock dependencies
//       when(mockAuthService.login(, "test", true)).thenAnswer((_) async => 'mocked_token');
//       when(mockSecureStorage.writeSecureData(any, any)).thenAnswer((_) async => true);
//       when(mockPrefs.setBool(any, any)).thenAnswer((_) async => true);
//       when(mockPrefs.setInt(any, any)).thenAnswer((_) async => true);
//       when(mockPrefs.setString(any, any)).thenAnswer((_) async => true);
//
//       // Run the test
//       final result = await authViewModel.login('mock_username', 'mock_password', true);
//
//       // Verify
//       verify(mockAuthService.login(captureAny, captureAny, captureAny)).called(1);
//       verify(mockSecureStorage.writeSecureData('token', 'mocked_token')).called(1);
//       verify(mockPrefs.setBool('tokenValid', true)).called(1);
//
//       expect(result, 'mocked_token');
//     });
//
//     test('login - unsuccessful login', () async {
//       // Mock dependencies
//       when(mockAuthService.login(any, any, any)).thenAnswer((_) async => null);
//
//       // Run the test
//       final result = await authViewModel.login('mock_username', 'mock_password', true);
//
//       // Verify
//       verify(mockAuthService.login(captureAny, captureAny, captureAny)).called(1);
//       verifyNever(mockSecureStorage.writeSecureData(any, any));
//       verifyNever(mockPrefs.setBool(any, any));
//
//       expect(result, null);
//     });
//
//     // Add more tests for other methods in AuthenticationViewModel
//   });
// }