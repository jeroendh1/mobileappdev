import 'package:flutter_test/flutter_test.dart';
import 'package:mobileappdev/data/car_database_helper.dart';
import 'package:mobileappdev/model/car.dart';
import 'package:mobileappdev/service/Api_service.dart';
import 'package:mobileappdev/viewmodel/home_viewmodel.dart';
import 'package:mockito/mockito.dart';


import 'package:connectivity_plus/connectivity_plus.dart';
class MockApiService extends Mock implements ApiService {}

class MockCarDatabaseHelper extends Mock implements CarDatabaseHelper {}

void main() {
  late HomeViewModel homeViewModel;
  late MockApiService mockApiService;
  late MockCarDatabaseHelper mockCarDatabaseHelper;

  setUp(() {
    mockApiService = MockApiService();
    mockCarDatabaseHelper = MockCarDatabaseHelper();
    homeViewModel = HomeViewModel();
  });

  test('getCars - successful fetch and save', () async {
    final mockCars = [
      Car(
        id: 1,
        brand: 'Toyota',
        model: 'Camry',
        fuel: 'Gasoline',
        options: 'Automatic',
        licensePlate: 'ABC123',
        engineSize: 2000,
        modelYear: 2022,
        since: '2022-01-01',
        price: 25000.0,
        nrOfSeats: 5,
        body: 'Sedan',
        img: 'assets/toyota.png',
      ),
      // Add more mock cars as needed
    ];

    // Mock ApiService
    when(mockApiService.getCars()).thenAnswer((_) async => mockCars);

    // Mock Connectivity
    when(Connectivity().checkConnectivity()).thenAnswer((_) async => ConnectivityResult.wifi);

    // Mock CarDatabaseHelper
    when(mockCarDatabaseHelper.getDataFromDatabase()).thenAnswer((_) async => mockCars);

    // Run the test
    await homeViewModel.getCars();

    // Verify
    verify(mockApiService.getCars()).called(1);
    verify(mockCarDatabaseHelper.saveDataToDatabase(mockCars)).called(1);
    verify(mockCarDatabaseHelper.getDataFromDatabase()).called(1);

    // Check if posts are set correctly
    expect(homeViewModel.posts, mockCars);
    expect(homeViewModel.originalPosts, mockCars);
    expect(homeViewModel.isLoaded.value, true);
  });

  // Add more tests for searchFilter, filterCars, and other methods in HomeViewModel
}