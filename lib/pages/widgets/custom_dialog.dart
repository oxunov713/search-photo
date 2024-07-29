import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

class ShowDialog {
  void showDownloadDialog(
      BuildContext context, String result, String? imageUrl) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("Do you want to download this image?"),
          content: Text(result),
          actions: [
            TextButton(
              onPressed: () async {
                try {
                  final success = await GallerySaver.saveImage(
                    "$imageUrl.jpg",
                    toDcim: true,
                    albumName: "Tonyblack713",
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(success != null && success
                          ? 'Image saved to gallery'
                          : 'Failed to save image'),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('An error occurred: $e')),
                  );
                }
                Navigator.pop(context);
              },
              child: const Text("Download"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("No"),
            ),
          ],
        );
      },
    );
  }
}
