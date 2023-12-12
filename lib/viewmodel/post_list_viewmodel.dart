import 'package:get/get.dart';

import '../service/Api_service.dart';
import 'car_viewmodel.dart';

class PostListViewModel extends GetxController {
  List<CarViewModel>? posts = RxList<CarViewModel>();
  var isLoaded = false.obs;

  getData() async {
    final result = await ApiService().getPosts();
    if (result != null) {
      posts = result.map((p) => CarViewModel(car: p)).toList();
      print("getdata");
      isLoaded.value = true;
    }
  }

  @override
  void onInit() {
    super.onInit();
    getData();
  }
}
