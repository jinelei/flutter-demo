import 'package:flutter/material.dart';
import 'package:jinelei/component/book.dart';
import 'package:jinelei/component/moive.dart';
import 'package:jinelei/component/random-words.dart';
import 'package:jinelei/component/logo.dart';
import '../tools/debug.dart';
import './settings.dart';
import '../main.dart' show globalSetting;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomePageState();
  }
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  String appBarTitle;
  var _searchQuery;
  var tabController;
  var test;

  @override
  void initState() {
    super.initState();
    this.test = globalSetting['test'];
    this.appBarTitle = '主页';
    this.tabController = new TabController(length: 3, vsync: this);
    this.tabController.addListener(() {
      switch (this.tabController.index) {
        case 0:
          this.setState(() {
            this.appBarTitle = '主页';
          });
          break;
        case 1:
          this.setState(() {
            this.appBarTitle = '电影';
          });
          break;
        case 2:
          this.setState(() {
            this.appBarTitle = '书籍';
          });
          break;
      }
    });
  }

  @override
  void dispose() {
    this.tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _buildAppBar(context),
      bottomNavigationBar: _buildTabBar(),
      drawer: _buildDrawer(),
      body: _buildTabBarView(),
      floatingActionButton: _buildFloatingActionBurrn(context),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  _buildSelectView(IconData icon, String text, String id) {
    return new PopupMenuItem<String>(
        value: id,
        child: new ListTile(
          leading: new Icon(icon),
          title: new Text(
            text,
          ),
          key: new Key(id),
        ));
  }

  _buildDrawerItemView(IconData icon, String text, String id) {
    return new ListTile(
        leading: new Icon(icon),
        title: new Text(
          text,
          style: new TextStyle(fontSize: 20.0),
        ),
        trailing: new Icon(Icons.chevron_right),
        onTap: () {
          switch (id) {
            case 'drawer_key_index':
              Navigator.of(context).pop();
              break;
            case 'drawer_key_settings':
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new SettingsPage()));
              break;
          }
        });
  }

  _buildDrawer() {
    var imgUrl = 'https://www.linuxidc.com/upload/2013_03/13030519324842.jpg';
    return new Drawer(
      child: new Container(
        child: new Column(
          children: <Widget>[
            new Image.network(imgUrl),
            _buildDrawerItemView(Icons.home, '首页', 'drawer_key_index'),
            new Divider(),
            _buildDrawerItemView(Icons.settings, '设置', 'drawer_key_settings'),
          ],
        ),
      ),
    );
  }

  _buildTabBar() {
    return new Material(
        color: Colors.blue,
        child: new TabBar(
            controller: this.tabController,
            unselectedLabelColor: Colors.black38,
            indicatorColor: Colors.white,
            tabs: <Tab>[
              new Tab(
                text: '主页',
                icon: new Icon(Icons.home),
              ),
              new Tab(
                text: '电影',
                icon: new Icon(Icons.movie),
              ),
              new Tab(
                text: '书籍',
                icon: new Icon(Icons.book),
              ),
            ]));
  }

  _buildAppBar(BuildContext context) {
    return new AppBar(
      centerTitle: true,
      title: new Text(this.appBarTitle),
      flexibleSpace: new Icon(Icons.search),
      toolbarOpacity: 1,
      actions: <Widget>[
        new IconButton(
            icon: new Icon(Icons.search),
            key: new Key('search_icon_btn'),
            onPressed: () {
              Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => new LogoComponent()));
            }),
        new PopupMenuButton<String>(
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                this._buildSelectView(Icons.message, '发起群聊', 'A'),
                this._buildSelectView(Icons.group_add, '添加服务', 'B'),
                this._buildSelectView(Icons.cast_connected, ' 扫一扫  ', 'C'),
              ],
        )
      ],
    );
  }

  _buildTabBarView() {
    return new TabBarView(controller: this.tabController, children: [
      new LogoComponent(),
      new MoiveComponent(),
      new BookComponnet(),
    ]);
  }

  _buildFloatingActionBurrn(BuildContext context) {
    return new FloatingActionButton(
        tooltip: 'add',
        onPressed: () {
          print('pressed');
          Scaffold.of(context).showSnackBar(
            new SnackBar(
              content: new Text(this.test),
            ),
          );
        },
        child: new Icon(Icons.add));
  }
}
