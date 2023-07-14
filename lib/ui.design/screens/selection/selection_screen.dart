import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:winwall/bloc/route_bloc.dart';
import 'package:winwall/logic/models/version.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen(this.versions, {super.key});
  final List<Version> versions;

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  final selectedVersions = <Version>[];
  Widget button(int index) {
    var version = widget.versions[index];
    var sw = false;
    return OutlinedButton(
      onPressed: () => setState(() {
        selectedVersions.add(version);
        sw = !sw;
      }),
      style: OutlinedButton.styleFrom(),
      child: Text(version.title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Wrap(
        alignment: WrapAlignment.center,
        children: [for (int i = 0; i < widget.versions.length; i++) button(i)],
      )),
      floatingActionButton: ElevatedButton(
        child: const Text('Continue'),
        onPressed: () => BlocProvider.of<RouteBloc>(context)
            .add(VersionSelection(selectedVersions)),
      ),
    );
  }
}
