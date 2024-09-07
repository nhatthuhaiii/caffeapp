import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

class screen_website extends StatefulWidget {
  screen_website({super.key});

  @override
  State<screen_website> createState() => screen_website_State();
}

class screen_website_State extends State<screen_website> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse('https://thecoffeehouse.com'));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Website The Coffee House'),
      ),
      child: Stack(
        children: [
          SafeArea(
            child: WebViewWidget(controller: _controller),
          ),
          if (_isLoading)
            const Center(
              child: CupertinoActivityIndicator(),
            ),
        ],
      ),
    );
  }
}
