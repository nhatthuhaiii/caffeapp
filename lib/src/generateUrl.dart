import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';

String generateVnpayUrl({
  required String tmnCode,
  required String hashSecret,
  required String returnUrl,
  required double amount,
}) {
  final dateFormat = DateFormat('yyyyMMddHHmmss');
  final createDate = dateFormat.format(DateTime.now());
  final expireDate = dateFormat.format(DateTime.now().add(Duration(minutes: 15)));
  final ipAddr = '127.0.0.1';
  final txnRef = DateTime.now().millisecondsSinceEpoch.toString();

  final params = {
    'vnp_Version': '2.1.0',
    'vnp_Command': 'pay',
    'vnp_TmnCode': tmnCode,
    'vnp_Amount': (amount * 100).toInt().toString(),
    'vnp_CurrCode': 'VND',
    'vnp_TxnRef': txnRef,
    'vnp_OrderInfo': 'Thanh toan don hang',
    'vnp_OrderType': 'other',
    'vnp_Locale': 'vn',
    'vnp_ReturnUrl': returnUrl,
    'vnp_IpAddr': ipAddr,
    'vnp_CreateDate': createDate,
    'vnp_ExpireDate': expireDate,
  };


  final sortedKeys = params.keys.toList()..sort();
  final query = sortedKeys.map((k) => '$k=${Uri.encodeQueryComponent(params[k]!)}').join('&');


  final hashData = sortedKeys.map((k) => '$k=${params[k]}').join('&');
  final hmac = Hmac(sha512, utf8.encode(hashSecret));
  final secureHash = hmac.convert(utf8.encode(hashData)).toString();

  final paymentUrl = 'https://sandbox.vnpayment.vn/paymentv2/vpcpay.html?$query&vnp_SecureHash=$secureHash';
  return paymentUrl;
}
