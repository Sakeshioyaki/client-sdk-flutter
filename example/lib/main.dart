import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livekit_example/livekit/theme.dart';
import 'package:livekit_example/main_page.dart';
import 'package:livekit_example/sendbird/notifications/local_notifications_manager.dart';
import 'package:livekit_example/sendbird/notifications/push_manager.dart';
import 'package:livekit_example/sendbird/page/channel/feed_channel/feed_channel_list_page.dart';
import 'package:livekit_example/sendbird/page/channel/feed_channel/feed_channel_page.dart';
import 'package:livekit_example/sendbird/page/channel/group_channel/group_channel_create_page.dart';
import 'package:livekit_example/sendbird/page/channel/group_channel/group_channel_invite_page.dart';
import 'package:livekit_example/sendbird/page/channel/group_channel/group_channel_list_page.dart';
import 'package:livekit_example/sendbird/page/channel/group_channel/group_channel_page.dart';
import 'package:livekit_example/sendbird/page/channel/group_channel/group_channel_search_page.dart';
import 'package:livekit_example/sendbird/page/channel/group_channel/group_channel_send_file_message_page.dart';
import 'package:livekit_example/sendbird/page/channel/group_channel/group_channel_update_page.dart';
import 'package:livekit_example/sendbird/page/channel/open_channel/open_channel_create_page.dart';
import 'package:livekit_example/sendbird/page/channel/open_channel/open_channel_list_page.dart';
import 'package:livekit_example/sendbird/page/channel/open_channel/open_channel_page.dart';
import 'package:livekit_example/sendbird/page/channel/open_channel/open_channel_search_page.dart';
import 'package:livekit_example/sendbird/page/channel/open_channel/open_channel_update_page.dart';
import 'package:livekit_example/sendbird/page/login_page.dart';
import 'package:livekit_example/sendbird/page/main_send_bird_page.dart';
import 'package:livekit_example/sendbird/page/message/message_update_page.dart';
import 'package:livekit_example/sendbird/page/user/user_nickname_update_page.dart';
import 'package:livekit_example/sendbird/page/user/user_page.dart';
import 'package:livekit_example/sendbird/page/user/user_profile_update_page.dart';
import 'package:logging/logging.dart';

//config for sendbird
const sampleVersion = '4.1.0';
const yourAppId = '567D498A-71B9-4D16-A326-D09F63B40C84';

void main() async {
  //
  // WidgetsFlutterBinding.ensureInitialized();
  // await PushManager.initialize();
  // await LocalNotificationsManager.initialize();
  // runApp(const LiveKitExampleApp());

  await runZonedGuarded<Future<void>>(
    () async {
      final format = DateFormat('HH:mm:ss');
      // configure logs for debugging
      Logger.root.level = Level.FINE;
      Logger.root.onRecord.listen((record) {
        print('${format.format(record.time)}: ${record.message}');
      });
      WidgetsFlutterBinding.ensureInitialized();
      FlutterError.onError = (errorDetails) {
        debugPrint('[FlutterError] ${errorDetails.stack}');
        Fluttertoast.showToast(
          msg: '[FlutterError] ${errorDetails.stack}',
          gravity: ToastGravity.CENTER,
          toastLength: Toast.LENGTH_SHORT,
        );
      };

      await PushManager.initialize();
      await LocalNotificationsManager.initialize();

      runApp(const LiveKitExampleApp());
    },
    (error, stackTrace) async {
      debugPrint('[Error] $error\n$stackTrace');
      await Fluttertoast.showToast(
        msg: '[Error] $error',
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT,
      );
    },
  );
}

class LiveKitExampleApp extends StatelessWidget {
  //
  const LiveKitExampleApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Sendbird Chat Sample + LiveKit Flutter Example',
        theme: LiveKitTheme().buildThemeData(context),
        builder: (context, child) {
          return ScrollConfiguration(behavior: _AppBehavior(), child: child!);
        },
        initialRoute: '/main_page',
        getPages: [
          GetPage(
            name: '/main_page',
            page: () =>  MainPage(),
          ),
          GetPage(
            name: '/login',
            page: () => const LoginPage(),
          ),
          GetPage(
            name: '/main_send_bird',
            page: () => const MainSenBirdPage(),
          ),
          GetPage(
            name: '/user',
            page: () => const UserPage(),
          ),
          GetPage(
            name: '/user/update/profile',
            page: () => const UserProfileUpdatePage(),
          ),
          GetPage(
            name: '/user/update/nickname',
            page: () => const UserNicknameUpdatePage(),
          ),
          GetPage(
            name: '/group_channel/list',
            page: () => const GroupChannelListPage(),
          ),
          GetPage(
            name: '/group_channel/search',
            page: () => const GroupChannelSearchPage(),
          ),
          GetPage(
            name: '/group_channel/create',
            page: () => const GroupChannelCreatePage(),
          ),
          GetPage(
            name: '/group_channel/update/:channel_url',
            page: () => const GroupChannelUpdatePage(),
          ),
          GetPage(
            name: '/group_channel/invite/:channel_url',
            page: () => const GroupChannelInvitePage(),
          ),
          GetPage(
            name: '/group_channel/:channel_url',
            page: () => const GroupChannelPage(),
          ),
          GetPage(
            name: '/group_channel/send_file_message/:channel_url',
            page: () => const GroupChannelSendFileMessagePage(),
          ),
          GetPage(
            name: '/open_channel/list',
            page: () => const OpenChannelListPage(),
          ),
          GetPage(
            name: '/open_channel/search',
            page: () => const OpenChannelSearchPage(),
          ),
          GetPage(
            name: '/open_channel/create',
            page: () => const OpenChannelCreatePage(),
          ),
          GetPage(
            name: '/open_channel/update/:channel_url',
            page: () => const OpenChannelUpdatePage(),
          ),
          GetPage(
            name: '/open_channel/:channel_url',
            page: () => const OpenChannelPage(),
          ),
          GetPage(
            name: '/message/update/:channel_type/:channel_url/:message_id',
            page: () => const MessageUpdatePage(),
          ),
          GetPage(
            name: '/feed_channel/list',
            page: () => const FeedChannelListPage(),
          ),
          GetPage(
            name: '/feed_channel/:channel_url',
            page: () => const FeedChannelPage(),
          ),
        ],
      );
}

class _AppBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
