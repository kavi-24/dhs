import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WebsiteCard extends StatefulWidget {
  final String text;
  final String url;
  const WebsiteCard({
    super.key,
    required this.text,
    required this.url,
  });

  @override
  State<WebsiteCard> createState() => _WebsiteCardState();
}

class _WebsiteCardState extends State<WebsiteCard> {
  launchURL(String url) async {
    if (await(canLaunchUrl(Uri.parse(url)))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await launchURL(widget.url);
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
