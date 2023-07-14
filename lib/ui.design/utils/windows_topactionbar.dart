import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class WindowsTopActionBar extends StatefulWidget {
  final String? title;
  final ThemeData themeData;

  const WindowsTopActionBar({
    Key? key,
    this.title,
    required this.themeData,
  }) : super(key: key);

  @override
  State<WindowsTopActionBar> createState() => _WindowsTopActionBarState();
}

class _WindowsTopActionBarState extends State<WindowsTopActionBar>
    with WindowListener {
  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Row(
        textDirection: TextDirection.ltr,
        children: [
          Expanded(
            child: DragToMoveArea(
              child: Container(
                height: double.infinity,
                padding: const EdgeInsets.only(left: 16),
                alignment: Alignment.centerLeft,
                child: DefaultTextStyle(
                    style: const TextStyle(),
                    child: Text(
                      widget.title!,
                      textDirection: TextDirection.ltr,
                    )),
              ),
            ),
          ),
          WindowCaptionButton.minimize(
            brightness: widget.themeData.brightness,
            onPressed: () async {
              bool isMinimized = await windowManager.isMinimized();
              if (isMinimized) {
                windowManager.restore();
              } else {
                windowManager.minimize();
              }
            },
          ),
          FutureBuilder<bool>(
            future: windowManager.isMaximized(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.data == true) {
                return WindowCaptionButton.unmaximize(
                  brightness: widget.themeData.brightness,
                  onPressed: () {
                    windowManager.unmaximize();
                  },
                );
              }
              return WindowCaptionButton.maximize(
                brightness: widget.themeData.brightness,
                onPressed: () {
                  windowManager.maximize();
                },
              );
            },
          ),
          WindowCaptionButton.close(
            brightness: widget.themeData.brightness,
            onPressed: () {
              windowManager.close();
            },
          ),
        ],
      ),
    );
  }

  @override
  void onWindowMaximize() {
    setState(() {});
  }

  @override
  void onWindowUnmaximize() {
    setState(() {});
  }
}
