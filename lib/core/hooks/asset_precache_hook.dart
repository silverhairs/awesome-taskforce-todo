import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

Image usePrecacheImage({
  required BuildContext context,
  required double height,
  required double width,
  required String asset,
}) {
  return use(_PrecacheAsset(
    asset: asset,
    height: height,
    width: width,
    context: context,
  ));
}

class _PrecacheAsset extends Hook<Image> {
  final String asset;
  final double height, width;
  final BuildContext context;
  const _PrecacheAsset({
    required this.asset,
    required this.context,
    this.height = 120,
    this.width = 120,
  });
  @override
  __PrecacheAssetState createState() => __PrecacheAssetState();
}

class __PrecacheAssetState extends HookState<Image, _PrecacheAsset> {
  AssetImage? _assetImage;
  @override
  void initHook() {
    super.initHook();
    precacheImage(_assetImage!, this.hook.context);
    _assetImage = AssetImage(this.hook.asset);
  }

  @override
  Image build(BuildContext context) {
    return Image(
      image: _assetImage!,
      height: this.hook.height,
      width: this.hook.width,
    );
  }
}
