import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:noti_samu/login.dart';

import 'package:appcenter/appcenter.dart';
import 'package:appcenter_analytics/appcenter_analytics.dart';
import 'package:appcenter_crashes/appcenter_crashes.dart';

import 'package:flutter/foundation.dart';

void main()  {

  runApp(MyApp());

  final ios = defaultTargetPlatform == TargetPlatform.iOS;

  var app_secret = ios ? "7eb2d2ef-3b41-4ca5-a150-8bf0f373821e" : "78959eae-23d2-4b96-b122-ca99893bf1a0";

  await AppCenter.start(app_secret, [AppCenterAnalytics.id, AppCenterCrashes.id]);

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
      localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt'),
      ],
    );
  }
}