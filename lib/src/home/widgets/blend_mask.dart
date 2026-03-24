import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BlendMask extends SingleChildRenderObjectWidget {
  final BlendMode blendMode;

  const BlendMask({super.key, required this.blendMode, super.child});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _RenderBlendMask(blendMode: blendMode);
  }

  @override
  void updateRenderObject(BuildContext context, _RenderBlendMask renderObject) {
    renderObject.blendMode = blendMode;
  }
}

class _RenderBlendMask extends RenderProxyBox {
  BlendMode blendMode;
  _RenderBlendMask({required this.blendMode, RenderBox? child}) : super(child);

  @override
  void paint(PaintingContext context, Offset offset) {
    // This tells the canvas to apply the blend mode only to what the child draws!
    context.canvas.saveLayer(offset & size, Paint()..blendMode = blendMode);
    super.paint(context, offset);
    context.canvas.restore();
  }
}
