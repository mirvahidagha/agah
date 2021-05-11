import 'package:agah/page/WebNews.dart';
//import 'package:agah/controller/category_controller.dart';
import 'package:agah/model/choice.dart';
//import 'package:agah/provider/google_sign_in.dart';
import 'package:agah/widget/popup_menu.dart';
import 'package:agah/widget/toolbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:get/get.dart';
import 'package:share/share.dart';

class SavePage extends StatefulWidget {
  SavePage({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  _SavePageState createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  final user = FirebaseAuth.instance.currentUser;

  //final SiteController siteController = Get.put(SiteController());
  PopupMenu menu;

  void onClickMenu(MenuItemProvider item, List<dynamic> document, int i) {
    if (item.menuTitle == "Paylaş") {
      Share.share(document[i]['url']);
    }
    if (item.menuTitle == "Sil") {
      final user = FirebaseAuth.instance.currentUser;

      DocumentReference saved =
          FirebaseFirestore.instance.collection('saved').doc(user.uid);
      // saved.set({DateTime.now().millisecondsSinceEpoch.toString(): document[i]},
      //     SetOptions(merge: true));

      saved.get().then((doc) {
        if (doc.exists) {
          List keys = doc.data().keys.toList();

          saved.update({
            keys[i].toString(): FieldValue.delete(),
          });
        } else {}
      });
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
            title: 'Sil',
            textStyle: TextStyle(
              fontFamily: "Bold",
              fontSize: 16,
              color: Color(0xFFC5EDCC),
            ),
            image: Icon(
              Icons.delete_outline_rounded,
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
    PopupMenu.context = context;
    DocumentReference saved =
        FirebaseFirestore.instance.collection('saved').doc(user.uid);
    return Scaffold(
      appBar: CommonAppBar.getPrimaryBackAppbar(context, 'Saxlanmışlar'),
      body: StreamBuilder<DocumentSnapshot>(
        stream: saved.snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return noItem(
                "Saxlanılmış xəbərlər burada olacaq. \nHələ ki, heç bir xəbər saxlanılmayıb.");
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return noItem(
                "Saxlanılmış xəbərlər burada olacaq. \nHələ ki, heç bir xəbər saxlanılmayıb.");
          }

          final DocumentSnapshot ds = snapshot.data;
          final Map<String, dynamic> map = ds.data();
          final List<dynamic> collection = map.values.toList();

          if (collection.isEmpty || collection.length == 0) {
            return noItem("Xəbər yoxdur.");
          }

          return Padding(
            padding: const EdgeInsets.only(top: 40),
            child: makeList(collection, context, cWidth),
          );
        },
      ),
    );
  }

  Widget noItem(String text) {
    return Container(
      color: Color(0xFFe6e6e6),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child:
                Image.asset('assets/images/cactus.png', width: double.infinity),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 50),
              width: 380,
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Bold",
                  fontSize: 17,
                  color: Colors.black38,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ListView makeList(
      List<dynamic> collection, BuildContext context, double cWidth) {
    return ListView.builder(
      itemCount: collection != null ? collection.length : 0,
      itemBuilder: (_, int index) {
        return buildListItem(context, index, collection, cWidth);
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
