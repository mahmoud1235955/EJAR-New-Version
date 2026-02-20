import 'package:flutter/material.dart';

class LoginPageWidget extends StatelessWidget {
  const LoginPageWidget({super.key, required this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: double.infinity,
      height: MediaQuery.sizeOf(context).height - 375,
      decoration: const BoxDecoration(
        color: Color(0xff087513),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [Icon(Icons.smartphone), Text("Continue with Phone ")],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.g_mobiledata),
                Text("Continue with Google "),
              ],
            ),
          ),
          Text("OR", style: TextStyle(fontWeight: FontWeight.bold)),
          TextButton(
            onPressed: onPressed,
            child: Text(
              "Login with Gmail",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Text(
            "If you continue, you are acceptingthe Ejar Terms and Conditions and Privacy Policy",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
