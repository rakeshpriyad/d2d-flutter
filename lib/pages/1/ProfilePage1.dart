import 'package:d2d_flutter/pages/1/AboutUsPage1.dart';
import 'package:d2d_flutter/pages/1/list_profile_section.dart';
import 'package:d2d_flutter/utils/CustomTextStyle.dart';
import 'package:d2d_flutter/utils/CustomUtils.dart';
import 'package:flutter/material.dart';

import 'AboutUsPage1.dart';
import 'InviteFriendsPage1.dart';
import 'NotificationPage1.dart';

class ProfilePage1 extends StatefulWidget {
  @override
  _ProfilePageState1 createState() => _ProfilePageState1();
}

class _ProfilePageState1 extends State<ProfilePage1> {
  List<ListProfileSection> listSection = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createListItem();
  }

  void createListItem() {
    listSection.add(createSection("Notifications", "assets/images/ic_notification.png",
        Colors.blue.shade800, NotificationPage1()));
    listSection.add(createSection(
        "Payment Method", "assets/images/ic_payment.png", Colors.teal.shade800, null));
    listSection.add(createSection(
        "Settings", "assets/images/ic_settings.png", Colors.red.shade800, null));
    listSection.add(createSection(
        "Invite Friends",
        "assets/images/ic_invite_friends.png",
        Colors.indigo.shade800,
        InviteFriendsPage1()));
    listSection.add(createSection("About Us", "assets/images/ic_about_us.png",
        Colors.black.withOpacity(0.8), AboutPage1()));
    listSection.add(createSection(
        "Logout", "assets/images/ic_logout.png", Colors.red.withOpacity(0.7), null));
  }

  createSection(String title, String icon, Color color, Widget? widget) {
    return ListProfileSection(title, icon, color, widget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Utils.getSizedBox(height: 24),
          buildHeader(),
          Utils.getSizedBox(height: 24),
          buildListView()
        ],
      ),
    );
  }

  Container buildHeader() {
    return Container(
      child: Row(
        children: <Widget>[
          Utils.getSizedBox(width: 14),
          Container(
            width: 60,
            margin: EdgeInsets.only(top: 8),
            height: 60,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/ic_user_profile.png")),
                borderRadius: BorderRadius.all(Radius.circular(24))),
          ),
          Utils.getSizedBox(width: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Dev",
                      textAlign: TextAlign.start,
                      style: CustomTextStyle.textFormFieldBlack
                          .copyWith(color: Colors.blue.shade900, fontSize: 14),
                    ),
                    Utils.getSizedBox(height: 2),
                    Text(
                      "dev@gmail.com",
                      style: CustomTextStyle.textFormFieldMedium
                          .copyWith(color: Colors.grey.shade400, fontSize: 12),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                  ),
                )
              ],
            ),
            flex: 100,
          )
        ],
      ),
    );
  }

  ListView buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) {
        return createListViewItem(listSection[index]);
      },
      itemCount: listSection.length,
    );
  }

  createListViewItem(ListProfileSection listSection) {
    return Builder(builder: (context) {
      return InkWell(
        splashColor: Colors.teal.shade200,
        onTap: () {
          if (listSection.widget != null) {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => listSection.widget!));
          }
        },
        child: Container(
          padding: EdgeInsets.only(top: 14, left: 24, right: 8, bottom: 14),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      color: listSection.color),
                  child: Image(
                    image: AssetImage(listSection.icon),
                    color: Colors.white,
                  ),
                ),
                flex: 8,
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    listSection.title,
                    style: CustomTextStyle.textFormFieldMedium,
                  ),
                ),
                flex: 84,
              ),
              Expanded(
                child: Container(
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                  ),
                ),
                flex: 8,
              ),
            ],
          ),
        ),
      );
    });
  }
}
