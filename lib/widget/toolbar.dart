import 'package:flutter/material.dart';

class CommonAppBar {
  static Widget getPrimaryAppbar(BuildContext context, String title) {
    return AppBar(
        backgroundColor: Colors.amber,
        title: Text(
          title,
        ),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          // IconButton(
          //   icon: Icon(Icons.search),
          //   onPressed: () {
          //     //  Get.to(() => SearchPage());
          //   },
          // ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {},
          ),
        ]);
  }

  static Widget getPrimarySettingAppbar(BuildContext context, String title) {
    return AppBar(
        backgroundColor: Colors.amber,
        title: Text(title),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showToastClicked(context, "Search");
            },
          ),
          PopupMenuButton<String>(
            onSelected: (String value) {
              showToastClicked(context, value);
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: "Settings",
                child: Text("Settings"),
              ),
            ],
          )
        ]);
  }

  static Widget getPrimaryBackAppbar(BuildContext context, String title) {
    return AppBar(
      backgroundColor: Color(0xFF69BF7D),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 22.0,
            fontFamily: 'Bold',
            color: Color(0xFFC5EDCC),
            fontWeight: FontWeight.bold),
      ),
      leading: IconButton(
        color: Color(0xFFC5EDCC),
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  static void showToastClicked(BuildContext context, String action) {
    print(action);
  }
}
