import 'package:agah/model/choice.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryController extends GetxController {
  // ignore: deprecated_member_use
  var categoryList = List<Choice>().obs;

  @override
  @override
  void onInit() {
    getList();
    super.onInit();
  }

  getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> llll = prefs.getStringList("categories");

    if (llll != null) {
      categoryList.value = llll.map((e) => choiceFromJson(e)).toList();
    } else {
      categoryList.value = [];
    }
  }
}
