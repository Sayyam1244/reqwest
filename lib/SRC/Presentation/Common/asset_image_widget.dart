import 'dart:io'; // To support File for local images
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reqwest/SRC/Presentation/Common/app_text.dart';

class AssetImageWidget extends StatelessWidget {
  final String? url;
  final double scale;
  final double? width;
  final double? height;
  final Color? color;
  final bool? isCircle;
  final double? radius;
  final BoxFit? fit;
  final String? name;

  const AssetImageWidget({
    super.key,
    this.name,
    this.url,
    this.fit = BoxFit.contain,
    this.scale = 1,
    this.width,
    this.height,
    this.color,
    this.isCircle,
    this.radius,
  });

  final String errorImageUrl = ""; // Error image fallback URL

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // If no URL is provided, show a fallback CircleAvatar with the name's first letter
    if (url == null) {
      return CircleAvatar(
        backgroundColor: theme.colorScheme.tertiary,
        radius: radius ?? 20,
        child: AppText(
          name != null ? name![0] : '?', // Handle null name case
          style: theme.textTheme.headlineSmall!
              .copyWith(fontSize: 14.sp, color: theme.colorScheme.primary),
        ),
      );
    }

    // Check if the URL is a local file path or a network/asset image
    if (_isFilePath(url!)) {
      return _buildImageFromFile(url!, theme);
    }

    // If it's not a file path, treat it as a network or asset URL
    return isCircle != null && isCircle!
        ? CircleAvatar(
            radius: radius,
            backgroundColor: color,
            backgroundImage: _isNetworkImage(url!)
                ? NetworkImage(url!)
                : AssetImage(url!) as ImageProvider,
          )
        : _buildImageFromUrl(url!, theme);
  }

  // Check if the URL is a file path (local file)
  bool _isFilePath(String url) {
    return url.startsWith('file://') || File(url).existsSync();
  }

  // Check if the URL is a network URL (i.e., it starts with http or https)
  bool _isNetworkImage(String url) {
    return url.startsWith('http') || url.startsWith('https');
  }

  // Build image from a local file path
  Widget _buildImageFromFile(String filePath, ThemeData theme) {
    final File imageFile = File(filePath);

    return isCircle == true
        ? CircleAvatar(
            radius: radius ?? 20,
            backgroundColor: color,
            backgroundImage: FileImage(imageFile),
          )
        : Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius ?? 0),
            ),
            child: Image.file(
              imageFile,
              fit: fit ?? BoxFit.cover,
              color: color,
              errorBuilder: (context, error, stackTrace) {
                return _buildErrorImage(theme);
              },
              width: width == null ? null : width! * scale,
              height: height == null ? null : height! * scale,
            ),
          );
  }

  // Build image from a URL (Network or Asset)
  Widget _buildImageFromUrl(String url, ThemeData theme) {
    if (_isNetworkImage(url)) {
      return Image.network(
        url,
        fit: fit ?? BoxFit.cover,
        color: color,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorImage(theme);
        },
        width: width == null ? null : width! * scale,
        height: height == null ? null : height! * scale,
      );
    } else {
      // It's an asset image
      return Image.asset(
        url,
        fit: fit ?? BoxFit.cover,
        color: color,
        errorBuilder: (context, error, stackTrace) {
          return _buildErrorImage(theme);
        },
        width: width == null ? null : width! * scale,
        height: height == null ? null : height! * scale,
      );
    }
  }

  // Fallback error image (in case image loading fails)
  Widget _buildErrorImage(ThemeData theme) {
    return Container(
      color: theme.colorScheme.secondary,
      width: width,
      height: height,
      child: Center(
        child: AppText(
          'Error loading image',
          style: theme.textTheme.bodyMedium!
              .copyWith(color: theme.colorScheme.onError),
        ),
      ),
    );
  }
}
