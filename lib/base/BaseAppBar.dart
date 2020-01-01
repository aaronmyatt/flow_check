import 'package:feature_discovery/feature_discovery.dart';
import 'package:flutter/material.dart';

Widget BaseAppBar(pageTitle, context, {backButton: false}) {
  return AppBar(
    automaticallyImplyLeading: backButton,
    title: Text(pageTitle),
    actions: [InfoButton(context)],
  );
}

Widget InfoButton(context) {
  // cc:onboarding#3;Highlight info button;
  return DescribedFeatureOverlay(
      featureId: 'info_button',
      // Unique id that identifies this overlay.
      tapTarget: const Icon(Icons.info),
      // The widget that will be displayed as the tap target.
      title: Text('Learn more about flow and Flow Check.'),
      backgroundColor: Theme.of(context).backgroundColor,
      targetColor: Colors.white,
      textColor: Colors.white,
      child: IconButton(
          icon: const Icon(Icons.info),
          onPressed: () {
            Navigator.pushNamed(context, '/info');
          }));
}
