import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageService {
  static const int maxWidth = 1920;
  static const int maxHeight = 1080;
  static const int quality = 85;

  /// Compresses an image file to reduce size while maintaining quality
  static Future<File?> compressImage(File file) async {
    try {
      final filePath = file.absolute.path;
      final lastIndex = filePath.lastIndexOf('.');
      final extension = filePath.substring(lastIndex);
      final targetPath = filePath.replaceAll(extension, '_compressed$extension');

      final result = await FlutterImageCompress.compressAndGetFile(
        filePath,
        targetPath,
        minWidth: maxWidth,
        minHeight: maxHeight,
        quality: quality,
      );

      return result != null ? File(result.path) : null;
    } catch (e) {
      debugPrint('Error compressing image: $e');
      return null;
    }
  }

  /// Compresses image data from bytes
  static Future<Uint8List?> compressImageData(Uint8List data) async {
    try {
      final result = await FlutterImageCompress.compressWithList(
        data,
        minWidth: maxWidth,
        minHeight: maxHeight,
        quality: quality,
      );
      return result;
    } catch (e) {
      debugPrint('Error compressing image data: $e');
      return null;
    }
  }

  /// Loads and caches frequently used assets
  static Future<Uint8List?> loadAsset(String assetPath) async {
    try {
      final ByteData data = await rootBundle.load(assetPath);
      return data.buffer.asUint8List();
    } catch (e) {
      debugPrint('Error loading asset: $e');
      return null;
    }
  }
}