import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:window_size/window_size.dart' as window_size;

void main() async {
  print('当前运行目录: ${Directory.current.path}');
  WidgetsFlutterBinding.ensureInitialized();

  // 读取配置文件获取高度和宽度
  final config = await _getConfiguredSize();

  // 设置窗口大小
  _setWindowSize(config['width'], config['height']);

  runApp(MyApp());
}

// 读取配置文件宽度和高度
Future<Map<String, double>> _getConfiguredSize() async {
  const defaultWidth = 800.0;  // 默认宽度
  const defaultHeight = 400.0; // 默认高度
  const configFilePath = 'config.json';

  try {
    final file = File(configFilePath);
    if (await file.exists()) {
      final content = await file.readAsString();
      final json = jsonDecode(content);
      return {
        'width': (json['width'] ?? defaultWidth).toDouble(),
        'height': (json['height'] ?? defaultHeight).toDouble(),
      };
    }
  } catch (e) {
    debugPrint('读取配置文件失败，使用默认大小: $e');
  }
  return {'width': defaultWidth, 'height': defaultHeight};
}

// 设置窗口大小
void _setWindowSize(double? width, double? height) {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    window_size.getScreenList().then((screens) {
      if (screens.isNotEmpty) {
        final screen = screens.first;

        window_size.setWindowFrame(Rect.fromLTWH(
          0,
          (screen.frame.height - height! ),
          screen.frame.width,
          height ?? screen.frame.height,
        ));
      }
    });
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('桌面端应用'),
        ),
        body: const Center(
          child: Text('窗口宽度和高度由配置文件控制'),
        ),
      ),
    );
  }
}