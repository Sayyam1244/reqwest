import 'dart:io';

import 'package:file_picker/file_picker.dart';

class FilePickerService {
  static Future<List<File>> pickImage({bool allowMultiple = false}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: allowMultiple,
    );
    if (result == null) return [];

    return result.files.map((e) => File(e.path!)).toList();
  }

  static Future<List<File>> pickFile(
      {required FileType type,
      bool allowMultiple = true,
      List<String>? allowedExtensions}) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: type,
      allowMultiple: allowMultiple,
      allowedExtensions: allowedExtensions,
    );
    if (result == null) return [];

    return result.files.map((e) => File(e.path!)).toList();
  }
}
