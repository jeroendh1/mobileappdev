import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobileappdev/model/customer.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mobileappdev/viewmodel/Auth_viewmodel.dart';
import 'package:mobileappdev/service/auth_service.dart';
import 'package:mobileappdev/data/SecureStorage.dart';

class MockAuthService extends Mock implements AuthenticationService {}

class MockSecureStorage extends Mock implements SecureStorage {}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  late AuthenticationViewModel authViewModel;
  late MockAuthService mockAuthService;
  late MockSecureStorage mockSecureStorage;
  late SharedPreferences mockPrefs;

  setUp(() async {
    mockAuthService = MockAuthService();
    mockSecureStorage = MockSecureStorage();
    SharedPreferences.setMockInitialValues({});
    mockPrefs = await SharedPreferences.getInstance();

    authViewModel = AuthenticationViewModel();
  });

  group('AuthenticationViewModel', () {
    test('login - successful login', () async {
      Future<String> future = Future.delayed(
        const Duration(seconds: 2),
            () => "mocked_token",
      );
      final token = Future.value("mocked-token");


      when(mockAuthService.login('mock_username', 'mock_password', true))
          .thenAnswer(future);
      // when(mockSecureStorage.writeSecureData('token', 'mocked_token'))
      //     .thenAnswer((_) async => true);
      // when(mockSecureStorage.writeSecureData('username', 'mock_username'))
      //     .thenAnswer((_) async => true);
      // when(mockSecureStorage.writeSecureData('password', 'mock_password'))
      //     .thenAnswer((_) async => true);
      // when(mockPrefs.setBool('tokenValid', true)).thenAnswer((_) async => true);
      // when(mockPrefs.setInt('customerId', 123)).thenAnswer((_) async => true);
      // when(mockPrefs.setString('firstName', "testName")).thenAnswer((_) async => true);
      // when(mockPrefs.setString('lastName', "testName")).thenAnswer((_) async => true);

      // Run the test
      final result = await authViewModel.login('mock_username', 'mock_password', true);

      // Verify
      verify(mockAuthService.login('mock_username', 'mock_password', true)).called(1);
      verify(mockSecureStorage.writeSecureData('token', 'mocked_token')).called(1);
      verify(mockPrefs.setBool('tokenValid', true)).called(1);

      expect(result, 'mocked_token');
    });

    // test('login - unsuccessful login', () async {
    //   // Mock dependencies
    //   when(mockAuthService.login(any, any, any)).thenAnswer((_) async => null);
    //
    //   // Run the test
    //   final result = await authViewModel.login('mock_username', 'mock_password', true);
    //
    //   // Verify
    //   verify(mockAuthService.login('mock_username', 'mock_password', true)).called(1);
    //   verifyNever(mockSecureStorage.writeSecureData(any, any));
    //   verifyNever(mockPrefs.setBool(any, any));
    //
    //   expect(result, null);
    // });

    // Add more tests for other methods in AuthenticationViewModel
  });
}
