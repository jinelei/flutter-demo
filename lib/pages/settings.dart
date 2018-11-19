import 'package:flutter/material.dart';
import '../main.dart' show globalSetting;

class SettingsPage extends StatefulWidget {
  SettingsPage();

  @override
  State<StatefulWidget> createState() {
    return _SettingsPageState();
  }
}

class _SettingsPageState extends State<SettingsPage> {
  var test;

  @override
  void initState() {
    super.initState();
    this.test = globalSetting['test'];
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  _buildAppBar() {
    return new AppBar(
      title: new Text('设置'),
    );
  }

  _buildBody() {
    return new Container(
      child: new ListView(
        children: <Widget>[
          new ListTile(
            title: new Text('test'),
            trailing: new Switch(
              value: this.test,
              activeColor: Colors.blue,
              onChanged: (bool val) {
                this.setState(() {
                  this.test = val;
                  globalSetting['test'] = val;
                });
              },
            ),
          )
        ],
      ),
    );
  }
}
