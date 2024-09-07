import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vnpay_flutter/vnpay_flutter.dart';
import 'package:webview_flutter/webview_flutter.dart';

class service_vnpay extends StatefulWidget {
  const service_vnpay({super.key, required this.amount});
  final double amount;

  @override
  State<service_vnpay> createState() => _service_vnpayState();
}

class _service_vnpayState extends State<service_vnpay> {
  String paymentStatus = "";
  bool isLoading = false;
  late final WebViewController _controller;

  Future<void> startPayment() async {
    setState(() {
      isLoading = true;
    });

    try {
      final txnRef = DateTime.now().millisecondsSinceEpoch.toString();

      final paymentUrl = VNPAYFlutter.instance.generatePaymentUrl(
        url: 'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html',
        version: '2.0.1',
        tmnCode: 'NPNVV0LP',
        txnRef: txnRef,
        amount: widget.amount,
        returnUrl: 'https://httpbin.org/anything', // nơi nhận kết quả
        orderInfo: 'pay',
        ipAdress: '0.0.0.0',
        locale: 'vn',
        vnpayHashKey: '7G18EWQBKJMCSW1MBIXI0GC3BG8QCQQ5',
        vnpayExpireDate: DateTime.now().add(const Duration(minutes: 15)),
      );

      _controller.loadRequest(Uri.parse(paymentUrl));
    } catch (e) {
      setState(() {
        paymentStatus = 'Lỗi tạo URL: $e';
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            debugPrint("Đã tải xong: $url");
            setState(() {
              isLoading = false;
            });
          },
          onNavigationRequest: (request) {
            final url = request.url;
            if (url.contains('vnp_ResponseCode=')) {
              final uri = Uri.parse(url);
              final code = uri.queryParameters['vnp_ResponseCode'] ?? '';

              if (code == '00') {
                // Thành công
                Navigator.pop(context, {
                  'status': 'success',
                  'responseCode': code,
                  'message': 'Thanh toán thành công',
                  'url': url,
                });
              } else {
                // Thất bại
                Navigator.pop(context, {
                  'status': 'error',
                  'responseCode': code,
                  'message': 'Thanh toán thất bại',
                  'url': url,
                });
              }

              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      );

    startPayment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán VNPAY'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, {
              'status': 'cancelled',
              'message': 'Người dùng đã hủy thanh toán',
            });
          },
        ),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
