import 'package:ejar/core/routes/app_routes.dart';
import 'package:ejar/generated/l10n.dart';
import 'package:flutter/material.dart';

class SpalshPage extends StatefulWidget {
  const SpalshPage({super.key});

  @override
  State<SpalshPage> createState() => _SpalshPageState();
}

class _SpalshPageState extends State<SpalshPage> {
  @override
  void initState() {
    Future.delayed(
      Duration(seconds: 3),
      // ignore: use_build_context_synchronously
    ).then((value) => Navigator.pushReplacementNamed(context, AppRoutes.login));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff087513),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity),
          Padding(
            padding: const EdgeInsets.only(top: 60, bottom: 25),
            child: Text(
              textAlign: TextAlign.center,
              S.of(context).ejar,
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
