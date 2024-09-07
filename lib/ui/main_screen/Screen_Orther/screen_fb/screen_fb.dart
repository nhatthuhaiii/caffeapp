import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class screen_fb extends StatelessWidget {
  const screen_fb({super.key});

  Future<void> _launchFacebookPage() async {
    final Uri url = Uri.parse('https://www.facebook.com/The.Coffee.House.2014/');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Facebook The Coffee House'),
      ),
      child: Center(
        child: CupertinoButton.filled(
          child: const Text('Mở fanpage Facebook'),
          onPressed: _launchFacebookPage,
        ),
      ),
    );
  }
}
