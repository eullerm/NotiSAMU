import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/foundation.dart';

import 'package:noti_samu/login.dart';

import 'package:appcenter/appcenter.dart';
import 'package:appcenter_analytics/appcenter_analytics.dart';
import 'package:appcenter_crashes/appcenter_crashes.dart';


void main()  {

  final ios = defaultTargetPlatform == TargetPlatform.iOS;

  var appSecret = ios ? "7eb2d2ef-3b41-4ca5-a150-8bf0f373821e" : "78959eae-23d2-4b96-b122-ca99893bf1a0";

  AppCenter.start(appSecret, null);

  runApp(MyApp());
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