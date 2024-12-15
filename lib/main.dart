import 'dart:ui';

import 'package:copykit/widgets/item_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    // 在这里初始化内容，例如监听事件或加载数据
    print('应用已启动');
  }

  @override
  void dispose() {
    // 在这里清理资源，例如关闭流或取消监听器
    print('应用已销毁');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ItemList(),
      ),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    print("$state");
    if (state == AppLifecycleState.resumed) {
      //do sth }
    }
  }
}
