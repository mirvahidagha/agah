import 'package:agah/page/WebNews.dart';
import 'package:agah/controller/category_controller.dart';
import 'package:agah/controller/site_controller.dart';
import 'package:agah/model/choice.dart';
import 'package:agah/page/about.dart';
import 'package:agah/page/categories.dart';
import 'package:agah/page/save_page.dart';
import 'package:agah/provider/google_sign_in.dart';
import 'package:agah/widget/popup_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

// ignore: must_be_immutable
class TabbedAppBarDemo extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  final CategoryController controller = Get.put(CategoryController());
  final _scaffoldKey = new GlobalKey<ScaffoldState>();

  Widget noItem(String text) {
    return Container(
      color: Color(0xFFe6e6e6),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child:
                Image.asset('assets/images/city.png', width: double.infinity),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 50),
              width: 380,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Bold",
                      fontSize: 17,
                      color: Colors.black38,
                    ),
                  ),
                  OutlineButton(
                    child: Text(
                      "Seçim et",
                      style: TextStyle(
                        fontFamily: "Bold",
                        fontSize: 17,
                        color: Colors.black38,
                      ),
                    ),
                    highlightedBorderColor: Colors.black54,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    onPressed: () {
                      Get.to(() => Categories());
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    PopupMenu.context = context;

    return Obx(() => DefaultTabController(
          length: controller.categoryList.length,
          child: Scaffold(
            key: _scaffoldKey,
            body: (controller.categoryList.isBlank ||
                    controller.categoryList.isEmpty)
                ? noItem(
                    "Hələ ki, heç bir kateqoriya və sayt seçimi etməmisiniz.")
                : NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          actions: <Widget>[
                            IconButton(
                              color: Color(0xFFC5EDCC),
                              icon: Icon(Icons.search_rounded, size: 28),
                              onPressed: () {},
                            ),
                          ],
                          leading: IconButton(
                            icon: Icon(Icons.menu_rounded,
                                size: 34), // change this size and style
                            onPressed: () =>
                                _scaffoldKey.currentState.openDrawer(),
                          ),
                          iconTheme: IconThemeData(color: Color(0xFFC5EDCC)),
                          flexibleSpace: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF69BF7D),
                                Color(0xFF69BF7D),
                              ],
                            )),
                          ),
                          elevation: 32,
                          title: Text(
                            "Agah",
                            //headline1
                            style: TextStyle(
                                fontSize: 25.0,
                                fontFamily: 'ExtraBold',
                                color: Color(0xFFC5EDCC),
                                fontWeight: FontWeight.bold),
                          ),
                          centerTitle: true,
                          floating: true,
                          pinned: true,
                          snap: true,
                          bottom: TabBar(
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: Color(0xFFC5EDCC),
                            labelStyle:
                                TextStyle(fontFamily: 'Bold', fontSize: 17),
                            indicatorColor: Colors.white,
                            isScrollable: true,
                            tabs: controller.categoryList
                                .map<Widget>((Choice choice) {
                              return Tab(
                                text: choice.title,
                                icon: Icon(
                                  choice.icon,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ];
                    },
                    body: TabBarView(
                      children: (controller.categoryList.isBlank ||
                              controller.categoryList.isEmpty)
                          ? [noItem("text")]
                          : controller.categoryList.map((Choice choice) {
                              return ChoicePage(
                                choice: choice,
                              );
                            }).toList(),
                    ),
                  ),
            drawer: Drawer(
              child: new ListView(
                children: <Widget>[
                  new UserAccountsDrawerHeader(
                    accountName: new Text(
                      user.displayName,
                      style: TextStyle(
                        fontFamily: 'Bold',
                        fontSize: 17.0,
                        color: Color(0xFFC5EDCC),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    accountEmail: new Text(
                      user.email,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontFamily: 'Bold',
                        color: Color(0xFFC5EDCC),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF69BF7D),
                        Color(0xFF69BF7D),
                      ],
                    )),
                    currentAccountPicture: CircleAvatar(
                        backgroundImage: NetworkImage(user.photoURL)),
                  ),
                  new ListTile(
                      leading: Icon(Icons.bookmark_rounded),
                      title: new Text(
                        "Saxlanılmışlar",
                        style: TextStyle(
                          fontFamily: 'Bold',
                          fontSize: 18.0,
                          color: Colors.black45,
                        ),
                      ),
                      onTap: () {
                        Get.to(() => SavePage());
                      }),
                  new ListTile(
                      leading: Icon(Icons.category_rounded),
                      title: new Text(
                        "Kateqoriyalar",
                        style: TextStyle(
                          fontFamily: 'Bold',
                          fontSize: 18.0,
                          color: Colors.black45,
                        ),
                      ),
                      onTap: () {
                        Get.to(() => Categories());
                      }),
                  new Divider(),
                  new ListTile(
                      leading: Icon(Icons.info_rounded),
                      title: new Text(
                        "Barə",
                        style: TextStyle(
                          fontFamily: 'Bold',
                          fontSize: 18.0,
                          color: Colors.black45,
                        ),
                      ),
                      onTap: () {
                        Get.to(() => About());
                      }),
                  new ListTile(
                      leading: Icon(Icons.logout),
                      title: new Text(
                        "Hesabdan çıx",
                        style: TextStyle(
                          fontFamily: 'Bold',
                          fontSize: 18.0,
                          color: Colors.black45,
                        ),
                      ),
                      onTap: () {
                        final provider = Provider.of<GoogleSignInProvider>(
                            context,
                            listen: false);
                        provider.logout();
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}

class ChoicePage extends StatefulWidget {
  ChoicePage({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  _ChoicePageState createState() => _ChoicePageState();
}

class _ChoicePageState extends State<ChoicePage> {
  final SiteController siteController = Get.put(SiteController());
  PopupMenu menu;

  void onClickMenu(MenuItemProvider item, List<dynamic> document, int i) {
    if (item.menuTitle == "Paylaş") {
      Share.share(document[i]['url']);
    }
    if (item.menuTitle == "Saxla") {
      final user = FirebaseAuth.instance.currentUser;

      DocumentReference saved =
          FirebaseFirestore.instance.collection('saved').doc(user.uid);
      saved.set({DateTime.now().millisecondsSinceEpoch.toString(): document[i]},
          SetOptions(merge: true));
    }
  }

  void customBackground(BuildContext context, GlobalKey btnKey,
      List<dynamic> document, int index) {
    menu = PopupMenu(
      backgroundColor: Color(0xFF69BF7D),
      lineColor: Color(0xFFC5EDCC),
      context: context,
      highlightColor: Colors.green,
      maxColumn: 2,
      items: [
        MenuItem(
            title: 'Paylaş',
            textStyle: TextStyle(
              fontFamily: "Bold",
              fontSize: 16,
              color: Color(0xFFC5EDCC),
            ),
            image: Icon(
              Icons.share_rounded,
              color: Color(0xFFC5EDCC),
            )),
        MenuItem(
            title: 'Saxla',
            textStyle: TextStyle(
              fontFamily: "Bold",
              fontSize: 16,
              color: Color(0xFFC5EDCC),
            ),
            image: Icon(
              Icons.bookmark_border_rounded,
              color: Color(0xFFC5EDCC),
            ))
      ],
      onClickMenu: (item) {
        onClickMenu(item, document, index);
      },
    );
    //  if (menu.isShow) menu.dismiss();
    menu.show(widgetKey: btnKey);
  }

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width * 0.6;
    // PopupMenu.context = context;

    DocumentReference economy = FirebaseFirestore.instance
        .collection('news')
        .doc(widget.choice.category);
    return StreamBuilder<DocumentSnapshot>(
      stream: economy.snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final DocumentSnapshot ds = snapshot.data;
        final Map<String, dynamic> map = ds.data();
        final List<dynamic> sections = map['news'];

        return Obx(() => makeList(sections, context, cWidth));
      },
    );
  }

  ListView makeList(List sections, BuildContext context, double cWidth) {
    List<String> sites =
        siteController.siteList.map((element) => element.title).toList();

    final List<dynamic> filteredSites =
        sections.where((element) => sites.contains(element['from'])).toList();

    return ListView.builder(
      itemCount: filteredSites != null ? filteredSites.length : 0,
      itemBuilder: (_, int index) {
        return buildListItem(context, index, filteredSites, cWidth);
      },
    );
  }

  InkWell buildListItem(
      BuildContext context, int index, List<dynamic> document, double cWidth) {
    final GlobalKey btnKey = GlobalKey();

    return InkWell(
      key: btnKey,
      onLongPress: () {
        customBackground(context, btnKey, document, index);
      },
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WebNews(
              url: document[index]['url'],
              title: document[index]['from'],
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 8, left: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 85,
                    margin: const EdgeInsets.only(left: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    width: cWidth,
                                    child: Text(
                                      document[index]['title'],
                                      overflow: TextOverflow.fade,
                                      maxLines: 3,
                                      softWrap: true,
                                      style: TextStyle(
                                        fontFamily: "Bold",
                                        fontSize: 17,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    makeDateTime(document[index]['time']),
                                    style: TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14.0,
                                      color: Colors.black45,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 120,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(document[index]['image']),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Row(children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(
                    margin: const EdgeInsets.only(left: 8, right: 8.0),
                    child: Divider(
                      color: Colors.black45,
                    )),
              ),
              Text(
                document[index]['from'],
                style: TextStyle(fontSize: 11),
              ),
              Expanded(
                flex: 1,
                child: Container(
                    margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                    child: Divider(
                      color: Colors.black45,
                    )),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  String makeDateTime(datetime) {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(datetime.toInt() * 1000).toLocal();

    initializeDateFormatting();

    DateFormat formatter = DateFormat('HH:mm   dd MMMM yyyy', 'az_AZ');

    return formatter.format(date);

    //final String formatted = formatter.format(date);
  }
}
