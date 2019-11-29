import 'package:flow_check/base/BaseAppBar.dart';
import 'package:flutter/material.dart';

import 'bottom_navigation_bar.dart';

class FlowInfoPage extends StatelessWidget {
  final String pageTitle;

  FlowInfoPage(this.pageTitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          BaseAppBar(pageTitle, context, backButton: true, infoButton: false),
      bottomNavigationBar: BottomNavBar(1),
      body: Text('Info'),
    );
  }
}
