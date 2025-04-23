import 'package:flutter/material.dart';
import '../widgets/dummy_map.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEEE8D5), // Light beige color for the map
      child: const DummyMap(),
    );
  }
}