import 'package:ejar/features/auth/presentation/pages/email_login_page.dart';
import 'package:ejar/features/auth/presentation/widgets/login_page_widget.dart';
import 'package:ejar/generated/l10n.dart';
import 'package:flutter/material.dart';

class LoginPageCategory extends StatelessWidget {
  const LoginPageCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: double.infinity),
          Padding(
            padding: const EdgeInsets.only(top: 60),
            child: Text(
              textAlign: TextAlign.center,
              S.of(context).ejar,
              style: TextStyle(
                color: Color(0xff087513),
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(S.of(context).egypt, style: TextStyle(color: Colors.black)),
          SizedBox(height: 140),
          Expanded(
            child: LoginPageWidget(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EmailLoginPage()),
                );
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
