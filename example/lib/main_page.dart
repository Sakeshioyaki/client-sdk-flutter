import 'package:flutter/material.dart';
import 'package:livekit_example/livekit/pages/connect.dart';
import 'package:livekit_example/main.dart';
import 'package:livekit_example/sendbird/page/login_page.dart';
import 'package:livekit_example/sendbird/page/main_send_bird_page.dart';
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';

class MainPage extends StatelessWidget {
  // const MainPage({super.key});
  MainPage({super.key}) {
    SendbirdChat.init(appId: yourAppId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              },
              child: const Text(
                'CHAT DEMO',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //go to connect page
                Navigator.push<void>(
                  context,
                  MaterialPageRoute(builder: (_) => const ConnectPage()),
                );
              },
              child: const Text(
                'LIVE DEMO',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
