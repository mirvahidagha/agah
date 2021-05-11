import 'package:agah/model/site.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SiteController extends GetxController {
  // ignore: deprecated_member_use
  var siteList = List<Site>().obs;

  @override
  @override
  void onInit() {
    getList();
    super.onInit();
  }

  getList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> llll = prefs.getStringList("sites");

    if (llll != null) {
      siteList.value = llll.map((e) => siteFromJson(e)).toList();
    } else {
      siteList.value = [];
    }
  }
}
