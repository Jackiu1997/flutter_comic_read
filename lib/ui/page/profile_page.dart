import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:comic_read/provider/settings_provider.dart';
import 'package:comic_read/ui/helper/color_helper.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Size screenSize;
  ThemeData _theme;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    _theme = Theme.of(context);

    final _settings = Provider.of<SettingsProvider>(context);

    return Scaffold(
      backgroundColor: _theme.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenSize.height * 0.1),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Profile", style: _theme.textTheme.headline2),
              Container(
                width: 50,
                margin: EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: redC1,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.bell,
                        size: 16,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          // user profile
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 150,
            child: Row(
              children: <Widget>[
                // user icon
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://img2.woyaogexing.com/2020/03/10/07370d1f19974bf48f99cc90a0fd2837!400x400.jpeg"),
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                // user message
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Jackiu Hu", style: _theme.textTheme.bodyText1),
                      SizedBox(height: 10),
                      Text("+86 15055478393", style: _theme.textTheme.bodyText2),
                      SizedBox(height: 10),
                      Text("离线", style: _theme.textTheme.bodyText2),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // setting switches
          SizedBox(height: 20),
          Flexible(
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                _buildSwitch(
                  "黑夜模式",
                  FontAwesomeIcons.starAndCrescent,
                  CupertinoSwitch(
                    activeColor: redC1,
                    value: _settings.value,
                    onChanged: (bool value) {
                      _settings.turnDarkMode();
                    }, 
                  ),
                ),
                _buildSwitch(
                  "搜索速率",
                  FontAwesomeIcons.bolt,
                  CupertinoSwitch(
                    activeColor: redC1,
                    value: _settings.value,
                    onChanged: (bool value) {
                      _settings.turnDarkMode();
                    },
                  ),
                ),
                _buildSwitch("缓存管理", FontAwesomeIcons.download, null),
                _buildSwitch("收藏管理", FontAwesomeIcons.heartbeat, null),
                _buildSwitch("检测更新", FontAwesomeIcons.syncAlt, null),
                _buildSwitch("设置", FontAwesomeIcons.cog, null),
                _buildSwitch("关于", FontAwesomeIcons.infoCircle, null),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitch(String title, IconData icon, CupertinoSwitch switcher) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 30),
      width: screenSize.width - 40,
      height: screenSize.height * 0.1 - 30,
      decoration: BoxDecoration(
        color: _theme.disabledColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, size: 16, color: _theme.primaryColor),
              SizedBox(width: 20),
              Text(title, style: _theme.textTheme.bodyText2),
            ],
          ),
          switcher != null ? switcher : Divider(),
        ],
      ),
    );
  }
}
