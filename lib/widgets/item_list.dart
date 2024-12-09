import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class ItemList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(8.0),
      scrollDirection: Axis.horizontal,
      children: [
        _buildListItem('Item 1', 'assets/music.png'),
        _buildListItem('Item 2', 'assets/navicat.png'),
        _buildListItem('Item 3', 'assets/idea.png'),
      ],
    );
  }

  // 构建一个分为上下两部分的单项，并加上点击反馈
  Widget _buildListItem(String title, String imagePath) {
    return Padding(
      padding: EdgeInsets.only(bottom: 18.0), // item之间的底部边距
      child: InkWell(
        onTap: () {
          print('$title clicked'); // 打印点击事件
        },
        borderRadius: BorderRadius.circular(16.0), // 点击时水波纹的圆角范围
        child: Card(
          elevation: 4.0, // 卡片阴影
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0), // 卡片圆角
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              double itemSize = constraints.maxHeight;

              return FutureBuilder<PaletteGenerator>(
                future: _getPaletteFromImage(imagePath),
                builder: (context, snapshot) {
                  Color? backgroundColor = snapshot.data?.dominantColor?.color;

                  return Container(
                    width: itemSize,
                    height: itemSize,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0), // 整体卡片圆角
                      color: Colors.grey[200], // 默认背景色
                    ),
                    child: Column(
                      children: [
                        // 上部，背景颜色从图片中提取
                        Expanded(
                          flex: 1, // 占整个卡片高度的1/4
                          child: Container(
                            decoration: BoxDecoration(
                              color: backgroundColor ?? Colors.grey[300], // 提取的背景色或默认灰色
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(16.0), // 顶部圆角
                              ),
                            ),
                            child: Row(
                              children: [
                                // 左侧文字
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            title,
                                            style: TextStyle(fontSize: 14, color: Colors.black),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            'Subtitle',
                                            style: TextStyle(fontSize: 12, color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // 右侧图片
                                SizedBox(
                                  width: 80, // 图片的宽度
                                  child: Align(
                                    alignment: Alignment.centerRight, // 图片靠右对齐
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Image.asset(
                                        imagePath,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // 下部，显示更多信息
                        Expanded(
                          flex: 3, // 占整个卡片高度的3/4
                          child: Center(
                            child: Text(
                              'More info',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  // 从图片中提取颜色
  Future<PaletteGenerator> _getPaletteFromImage(String imagePath) async {
    final imageProvider = AssetImage(imagePath);
    return await PaletteGenerator.fromImageProvider(imageProvider);
  }
}