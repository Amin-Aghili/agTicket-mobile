import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class CopyableLink extends StatefulWidget {
  final String productUrl;

  const CopyableLink({super.key, required this.productUrl});

  @override
  State<CopyableLink> createState() => _CopyableLinkState();
}

class _CopyableLinkState extends State<CopyableLink> {
  bool isCopied = false;

  void copyToClipboard() {
    Clipboard.setData(ClipboardData(text: widget.productUrl));
    setState(() {
      isCopied = true;
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isCopied = false;
      });
    });
  }

  // Function to launch URL
  Future<void> launchProductUrl() async {
    final Uri url = Uri.parse(widget.productUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text(
          'لینک محصول:',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
          ),
        ),
        InkWell(
          onTap: launchProductUrl,
          onLongPress: copyToClipboard,
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              '${widget.productUrl.substring(0, 24)}...',
              style: const TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
        if (isCopied)
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              "کپی شد!",
              style: TextStyle(color: Colors.green, fontSize: 12.0),
            ),
          ),
      ],
    );
  }
}
