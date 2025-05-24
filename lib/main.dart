import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String url = 'https://calendar-app-production-bcfc.up.railway.app';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Persian Calendar',
      home: Scaffold(
        appBar: AppBar(title: Text('تقویم فارسی')),
        body: Platform.isAndroid || Platform.isIOS
            ? WebViewWidget(url: url)
            : LauncherWidget(url: url),
      ),
    );
  }
}

class WebViewWidget extends StatelessWidget {
  final String url;
  const WebViewWidget({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: url,
      javascriptMode: JavascriptMode.unrestricted,
    );
  }
}

class LauncherWidget extends StatelessWidget {
  final String url;
  const LauncherWidget({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          if (await canLaunchUrl(Uri.parse(url))) {
            await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
          } else {
            throw 'Could not launch $url';
          }
        },
        child: Text('باز کردن تقویم در مرورگر'),
      ),
    );
  }
}
