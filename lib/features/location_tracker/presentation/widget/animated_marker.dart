import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prixz_techical_test/features/location_tracker/presentation/widget/circular_wave.dart';

class AnimatedMarker extends StatefulWidget {
  final double size;
  final bool isMoving;

  const AnimatedMarker({
    Key key,
    this.size,
    this.isMoving,
  }) : super(key: key);

  @override
  _AnimatedMarkerState createState() => _AnimatedMarkerState();
}

class _AnimatedMarkerState extends State<AnimatedMarker> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
          Container(
            width: widget.size,
            height: widget.size,
            child: CircleWaveRoute(),
          ),
        Padding(
          padding: EdgeInsets.only(
            bottom: widget.size,
          ),
          child: SvgPicture.asset(
            'assets/marker.svg',
            width: widget.size,
            height: widget.size,
          ),
        ),
      ],
    );
  }
}
