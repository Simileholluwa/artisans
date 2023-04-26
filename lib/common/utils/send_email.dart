import 'package:artisans/common/widgets/toast_message.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openEmail() async {
  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  try {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'maxoluwatosin@gmail.com',
      query: encodeQueryParameters(
          <String, String>{'subject': 'Passcode reset'}),
    );
    launchUrl(emailLaunchUri);
  } catch (e) {
    message('Could not open Email App.',);
  }
}