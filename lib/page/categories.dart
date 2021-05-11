import 'dart:math';
import 'package:agah/controller/category_controller.dart';
import 'package:agah/controller/site_controller.dart';
import 'package:agah/model/choice.dart';
import 'package:agah/model/site.dart';
import 'package:agah/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<Choice> selectedCategories = [];
  List<Site> selectedSites = [];
  List<Choice> choices = <Choice>[
    Choice(
        title: 'Iqtisadiyyat', icon: Icons.euro_rounded, category: 'economy'),
    Choice(
        title: 'Siyasət', icon: Icons.language_rounded, category: 'politics'),
    Choice(
        title: 'Idman', icon: Icons.sports_handball_rounded, category: 'sport'),
    Choice(
        title: 'Texnoloji',
        icon: Icons.precision_manufacturing_rounded,
        category: 'techno'),
    Choice(
        title: 'Mədəniyyət', icon: Icons.theater_comedy, category: 'culture'),
    Choice(title: 'Cəmiyyət', icon: Icons.group, category: 'social'),
    Choice(
        title: 'Müsahibə',
        icon: Icons.question_answer_rounded,
        category: 'interview'),
  ];

  List<Site> sites = <Site>[
    Site(title: "Apa.az"),
    Site(title: "Goal.az"),
    Site(title: "Trend.az"),
    Site(title: "Report.az"),
    Site(title: "Modern.az"),
    Site(title: "Fanat.az"),
    Site(title: "Oxu.az"),
    Site(title: "Milli.az"),
    Site(title: "Lent.az"),
  ];

  final CategoryController controller = Get.put(CategoryController());
  final SiteController siteController = Get.put(SiteController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF69BF7D),
          title: Text('Arıtla'),
          actions: [
            InkWell(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                List<String> list =
                    selectedCategories.map((e) => choiceToJson(e)).toList();

                List<String> sites =
                    selectedSites.map((e) => siteToJson(e)).toList();

                await prefs.setStringList("categories", list);

                await prefs.setStringList("sites", sites);

                Get.to(HomePage());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.done_rounded),
              ),
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Kateqoriyalar:",
                style: TextStyle(
                    fontSize: 24.0, color: Colors.black54, fontFamily: 'Bold'),
              ),
              Obx(
                () => Wrap(
                  children: makeCategories(choices, controller.categoryList),
                ),
              ),
              Text(
                "Qaynaqlar:",
                style: TextStyle(
                    fontSize: 24.0, color: Colors.black54, fontFamily: 'Bold'),
              ),
              Obx(
                () => Wrap(
                  children: makeSites(sites, siteController.siteList),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> makeCategories(List<Choice> list, List<Choice> selectedList) {
    selectedCategories = selectedList;
    return list
        .map((e) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilterChip(
                label: Text(e.title),
                avatar: Icon(e.icon),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected)
                      selectedList.add(e);
                    else
                      selectedList.remove(e);
                  });
                },
                selected: selectedList.contains(e),
              ),
            ))
        .toList();
  }

  List<Widget> makeSites(List<Site> list, List<Site> selectedList) {
    selectedSites = selectedList;
    return list
        .map((e) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilterChip(
                label: Text(e.title),
                avatar: Icon(Icons.language_rounded),
                onSelected: (bool selected) {
                  setState(() {
                    if (selected)
                      selectedList.add(e);
                    else
                      selectedList.remove(e);
                  });
                },
                selected: selectedList.contains(e),
              ),
            ))
        .toList();
  }
}

class RandomColorModel {
  Random random = Random();
  Color getColor() {
    return Color.fromARGB(200, 40, 40, 40);
  }
}
