import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'tma.state.dart';

class TMAPage extends StatelessWidget {
  final TMAState state;
  final String url;

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  TMAPage({Key? key, required this.state, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return ValueListenableBuilder<double>(
      valueListenable: state.height,
      builder: (_, mode, __) {
        return Positioned(
          // left: 0.0,
          top: height - state.toHeight(height),
          height: state.toHeight(height),
          child: SizedBox(
            width: width,
            height: state.toHeight(height),
            // color: Colors.yellow,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              color: Colors.blue,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 0.0, right: 0.0, bottom: 8.0),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox.fromSize(size: const Size(10, 10)),
                      Expanded(
                        flex: 4,
                        child: GestureDetector(
                          onPanUpdate: (details) {
                            if (state.toHeight(height) < height) {
                              state.change(-details.delta.dy / height * 100);
                            }
                          },
                          child: const Text(
                            'Telegram Mini App Window',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      (height / 2 > height - state.toHeight(height))
                          ? GestureDetector(
                              onTap: () {
                                state.height.value = 20;
                              },
                              child: const Icon(
                                Icons.download_for_offline_outlined,
                                color: Colors.white,
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                state.height.value = 0;
                              },
                              child: const Icon(
                                Icons.cancel_outlined,
                                color: Colors.white,
                              ),
                            ),
                      SizedBox.fromSize(size: const Size(10, 10)),
                    ],
                  ),
                  Expanded(
                    child: ColoredBox(
                      color: Colors.white,
                      child: Stack(children: [
                        WebView(
                          initialUrl: url,
                          javascriptMode: JavascriptMode.unrestricted,
                          onWebViewCreated: (WebViewController webViewController) {
                            _controller.complete(webViewController);
                          },
                          onPageStarted: (url) {
                            state.isLoading.value = true;
                          },
                          onPageFinished: (url) {
                            state.isLoading.value = false;
                          },
                        ),
                        if (state.isLoading.value)
                          const Center(
                            child: CircularProgressIndicator(),
                          ),
                      ]),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
