import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';

import 'constants.dart';

class ConfigService {
  // 读取配置文件获取宽度和高度
  static Future<Map<String, double>> getConfiguredSize() async {
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
}