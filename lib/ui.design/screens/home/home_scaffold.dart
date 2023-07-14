import 'package:flutter/material.dart';
import '/ui.design/utils/ext.dart';
import '../widgets/winwall_navigationbar.dart';

class HomeScaffold extends StatelessWidget {
  final Widget appBar;
  final SliverChildDelegate body;
  const HomeScaffold({
    Key? key,
    required this.appBar,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size;
    return Row(
      children: [
        const WinWallNavigationBar(),
        Expanded(
          child: Scaffold(
            body: CustomScrollView(slivers: [
              SliverAppBar(
                floating: true,
                elevation: 0,
                toolbarHeight: s.adopt(72.0, 72.0, 92.0),
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    titlePadding: const EdgeInsets.fromLTRB(0, 18, 0, 12),
                    title: appBar),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 16 / 9,
                      crossAxisCount: s.adopt(3, 4, 5),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12),
                  delegate: body,
                ),
              )
            ]),
          ),
        ),
      ],
    );
  }
}
