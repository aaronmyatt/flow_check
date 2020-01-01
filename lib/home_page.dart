import 'package:feature_discovery/feature_discovery.dart';
import 'package:flow_check/base/BaseAppBar.dart';
import 'package:flow_check/bottom_navigation_bar.dart';
import 'package:flow_check/flow_areas.dart';
import 'package:flow_check/flow_view_page.dart';
import 'package:flow_check/graph.dart';
import 'package:flow_check/services/flow_list_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  final String pageTitle;
  final int currentIndex = 0;
  String name;

  HomePage(this.pageTitle);

  @override
  Widget build(BuildContext context) {
    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      // cc:onboarding#2;Trigger onboarding;+5;If this is the first time the app is opened
      if (prefs.getBool('welcome') == null) {
        SchedulerBinding.instance.addPostFrameCallback((Duration duration) {
          FeatureDiscovery.discoverFeatures(
              context, {'info_button', 'graph', 'submit'});
        });
        // cc:onboarding#6;Toggle onboarding;+1;Ensure onboarding is not triggered on next app open
        prefs.setBool('welcome', true);
      } else {}
    });

    return Scaffold(
      appBar: BaseAppBar(this.pageTitle, context),
      bottomNavigationBar: BottomNavBar(currentIndex),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // cc:app_init#7;Initialise home page widgets
            Graph(),
            NameInput(),
          ],
        ),
      ),
    );
  }
}

class NameInput extends StatelessWidget {
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(color: Theme.of(context).backgroundColor),
        ],
      ),
      child: Column(
        children: <Widget>[
          TextField(
            textCapitalization: TextCapitalization.words,
            controller: textController,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.person,
                color: Theme.of(context).iconTheme.color,
              ),
              // cc:onboarding#5;Highlight the name input
              suffixIcon: DescribedFeatureOverlay(
                featureId: 'submit',
                tapTarget: const Icon(
                  Icons.check,
                  size: 44.0,
                  color: Colors.green,
                ),
                title: Text('Enter their name and submit.'),
                backgroundColor: Theme.of(context).backgroundColor,
                targetColor: Colors.white,
                textColor: Colors.white,
                child: IconButton(
                  icon: const Icon(Icons.check),
                  color: Colors.green,
                  onPressed: () {
                    onSubmit(context);
                  },
                ),
              ),
              hintText: 'Enter a name',
            ),
            onSubmitted: (_) {
              onSubmit(context);
            },
          ),
        ],
      ),
    );
  }

  void onSubmit(BuildContext context) {
    Offset offset = Provider.of<ValueNotifier<Offset>>(context).value;
    if (offset != Offset.zero) {
      if (textController.text != '') {
        String name = textController.text;

        double width = MediaQuery.of(context).size.width * 0.9;
        FlowAreas flowAreas = FlowAreas(width, width);
        String flowType = flowAreas.flowCheck(offset.dx, offset.dy);

        // cc:create_flow#2;Use name and tap location to create Flow
        FlowListService service = Provider.of<FlowListService>(context)
            .add(name, offset.dx, offset.dy, flowType);
        textController.clear();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    FlowViewPage('Flow View', service.allFlows.last)));
      }
    } else {
        FeatureDiscovery.discoverFeatures(context, {'graph'});
      }
  }
}
