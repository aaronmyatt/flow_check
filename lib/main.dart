import 'package:feature_discovery/feature_discovery.dart';
import 'package:flow_check/flow_info_page.dart' as flow_info;
import 'package:flow_check/flow_list_page.dart' as flow_list;
import 'package:flow_check/home_page.dart';
import 'package:flow_check/services/flow_list_service.dart';
import 'package:flow_check/services/local_storage_service.dart';
import 'package:flow_check/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // cc:app_init#1;Initialise app
  runApp(FlowCheck());
}

class FlowCheck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // cc:onboarding#1;Initialise feature discovery library
    // cc:app_init#2;Initialise Providers
    return FeatureDiscovery(
      child: FutureProvider<FlowListService>(
        catchError: (BuildContext context, err) {
          print(err.toString());
        },
        create: (_) async {
          // cc:app_init#3;Initialise FlowListService
          String store = await LocalStorageService.init();
          return FlowListService.fromJson(store);
        },
        child: MaterialApp(
          // cc:app_init#6;Setup Theme and Routes
          debugShowCheckedModeBanner: false,
          theme: flowCheckTheme,
          initialRoute: '/',
          routes: {
            '/': (_) => ChangeNotifierProvider<ValueNotifier<Offset>>(
                  create: (_) => ValueNotifier<Offset>(Offset.zero),
                  child: HomePage('Flow Check'),
                ),
            '/list': (_) => flow_list.FlowListPage('Flow History'),
            '/info': (_) => flow_info.FlowInfoPage('What is flow?'),
          },
        ),
      ),
    );
  }
}
