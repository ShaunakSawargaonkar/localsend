import 'dart:async';
import 'dart:io';

import 'package:common/model/file_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localsend_app/gen/strings.g.dart';
import 'package:localsend_app/util/native/channel/android_channel.dart'
    as android_channel;
import 'package:localsend_app/util/native/open_file.dart';
import 'package:refena_flutter/refena_flutter.dart';
import 'package:localsend_app/util/native/open_folder.dart';
import 'package:path/path.dart' as path;
import 'package:localsend_app/util/native/pick_directory_path.dart';
import 'package:localsend_app/provider/settings_provider.dart';
import 'package:routerino/routerino.dart';

class OpenFolderNotExistDialog extends StatefulWidget {
  final String filePath;

  const OpenFolderNotExistDialog({
    super.key,
    required this.filePath,
  });

  static Future<String?> open(
    BuildContext context, {
    required String filePath,
  }) async {
    return await showDialog(
      context: context,
      builder: (context) => OpenFolderNotExistDialog(
        filePath: filePath,
      ),
    );
  }

  @override
  State<OpenFolderNotExistDialog> createState() =>
      _OpenFolderNotExistDialogState();
}

class _OpenFolderNotExistDialogState extends State<OpenFolderNotExistDialog> {
  late Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // title: Text(t.dialogs.openFile.title),
      title: Text(t.dialogs.folderNotFound.title),
      content: Text(t.dialogs.folderNotFound.content),
      actions: [
        TextButton(
          onPressed: () async {
            final directory = await pickDirectoryPath();
            if (directory != null) {
              final ref = context.ref;
              await ref.notifier(settingsProvider).setDestination(directory);
              Navigator.of(context).pop(directory); // Return the directory
            }
          },
          child: Text("Select New Folder"),
        ),
        TextButton(
          onPressed: () {
            //cancelSession();//TODO Shaunak
            context.pop();
          },
          child: Text(t.general.close),
        ),
      ],
    );
  }
}
