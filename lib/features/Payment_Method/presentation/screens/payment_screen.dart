import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymenScreen extends StatefulWidget {
  const PaymenScreen({super.key, required this.token});
  final String token;
  @override
  State<PaymenScreen> createState() => _PaymenScreenState();
}

class _PaymenScreenState extends State<PaymenScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(
        Uri.parse(
          "https://accept.paymob.com/api/acceptance/iframes/1016899?payment_token=${widget.token}",
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Paymob Payment")),
      body: WebViewWidget(controller: controller),
    );
  }
}
