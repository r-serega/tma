import 'package:flutter/material.dart';

import '../tma/tma.page.dart';
import '../tma/tma.state.dart';

class MainPage extends StatelessWidget {
  final String title;

  final TMAState tmaState = TMAState();

  MainPage({super.key, required this.title});


  void _callTMA() {
    if (tmaState.height.value == 0) {
      tmaState.height.value = 50;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        actions: [IconButton(onPressed: _callTMA, icon: const Icon(Icons.ads_click))],
      ),
      body: Stack(children: [TMAPage(state: tmaState, url: 'https://google.com')]),
    );
  }
}
