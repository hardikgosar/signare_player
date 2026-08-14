

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:path/path.dart' as p;

class FileUtils {
const FileUtils._();

  static String generateFileNameFromUrl(String url) {
    final digest = sha1.convert(utf8.encode(url)).toString();
    final extension = p.extension(Uri.parse(url).path).toLowerCase();
    final safeExtension = extension.isEmpty ? '.media' : extension;
    return '$digest$safeExtension';
    }
}