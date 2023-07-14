import 'package:flutter/material.dart';
import '/ui.design/utils/ext.dart';

class WinWallNavigationBar extends StatefulWidget {
  const WinWallNavigationBar({super.key});

  @override
  State<WinWallNavigationBar> createState() => _WinWallNavigationBarState();
}

class _WinWallNavigationBarState extends State<WinWallNavigationBar> {
  int selectedIndex = 0;
  var destinations = {
    'Home': Icons.home_outlined,
    'Library': Icons.library_books
  }
      .entries
      .map((e) =>
          NavigationRailDestination(icon: Icon(e.value), label: Text(e.key)))
      .toList();
  @override
  Widget build(BuildContext context) {
    var s = MediaQuery.of(context).size;
    return NavigationRail(
      minWidth: s.adopt(42.0, 52.0, 58.0),
      backgroundColor: Colors.black,
      selectedIndex: selectedIndex,
      destinations: destinations,
      trailing: bottamIconButton(),
      onDestinationSelected: (value) => setState(() => selectedIndex = value),
    );
  }

  Expanded bottamIconButton() {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: IconButton(
          padding: const EdgeInsets.only(bottom: 24),
          icon: const Icon(Icons.dark_mode),
          onPressed: () {},
        ),
      ),
    );
  }
}
