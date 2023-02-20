/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsSvgsGen {
  const $AssetsSvgsGen();

  /// File path: assets/svgs/ic_calender_filled.svg
  String get icCalenderFilled => 'assets/svgs/ic_calender_filled.svg';

  /// File path: assets/svgs/ic_calender_unfilled.svg
  String get icCalenderUnfilled => 'assets/svgs/ic_calender_unfilled.svg';

  /// File path: assets/svgs/ic_facebook.svg
  String get icFacebook => 'assets/svgs/ic_facebook.svg';

  /// File path: assets/svgs/ic_google.svg
  String get icGoogle => 'assets/svgs/ic_google.svg';

  /// File path: assets/svgs/ic_home_filled.svg
  String get icHomeFilled => 'assets/svgs/ic_home_filled.svg';

  /// File path: assets/svgs/ic_lock.svg
  String get icLock => 'assets/svgs/ic_lock.svg';

  /// File path: assets/svgs/ic_message.svg
  String get icMessage => 'assets/svgs/ic_message.svg';

  /// File path: assets/svgs/ic_notification_bell_filled.svg
  String get icNotificationBellFilled =>
      'assets/svgs/ic_notification_bell_filled.svg';

  /// File path: assets/svgs/ic_person_filled.svg
  String get icPersonFilled => 'assets/svgs/ic_person_filled.svg';

  /// File path: assets/svgs/ic_person_unfilled.svg
  String get icPersonUnfilled => 'assets/svgs/ic_person_unfilled.svg';

  /// File path: assets/svgs/ic_twitter.svg
  String get icTwitter => 'assets/svgs/ic_twitter.svg';

  /// List of all assets
  List<String> get values => [
        icCalenderFilled,
        icCalenderUnfilled,
        icFacebook,
        icGoogle,
        icHomeFilled,
        icLock,
        icMessage,
        icNotificationBellFilled,
        icPersonFilled,
        icPersonUnfilled,
        icTwitter
      ];
}

class Assets {
  Assets._();

  static const $AssetsSvgsGen svgs = $AssetsSvgsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider() => AssetImage(_assetName);

  String get path => _assetName;

  String get keyName => _assetName;
}
