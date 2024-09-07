import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class vnpay_screen extends StatefulWidget {
  const vnpay_screen({super.key});

  @override
  State<vnpay_screen> createState() => _vnpay_screenState();
}

class _vnpay_screenState extends State<vnpay_screen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse('https://vidientu-static.vnpay.vn/mobile-terms.html'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Điều khoản VNPAY'),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
