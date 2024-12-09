import 'dart:io';
import 'dart:ui';
import 'package:window_size/window_size.dart' as window_size;

class WindowService {
  // 设置窗口大小
  static void setWindowSize(double? width, double? height) {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      window_size.getScreenList().then((screens) {
        if (screens.isNotEmpty) {
          final screen = screens.first;
          window_size.setWindowFrame(Rect.fromLTWH(
            0,
            (screen.frame.height - height!),
            screen.frame.width,
            height ?? screen.frame.height,
          ));
        }
      });
    }
  }
}