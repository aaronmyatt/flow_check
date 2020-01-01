import 'package:flow_check/base/BaseAppBar.dart';
import 'package:flow_check/bottom_navigation_bar.dart';
import 'package:flow_check/flow_view_page.dart';
import 'package:flow_check/services/actions.dart';
import 'package:flow_check/services/flow_list_service.dart' as flow_service;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:strings/strings.dart';

const ONE_MINUTE = 60000;
const ONE_DAY = 86400000;

class FlowListPage extends StatelessWidget {
  final String pageTitle;
  final int currentIndex = 1;

  FlowListPage(this.pageTitle);

  @override
  Widget build(BuildContext context) {
    // cc:list_flows#2;Read froms from Service via Provider
    List<flow_service.Flow> flows =
        Provider.of<flow_service.FlowListService>(context).allFlows;
    return Scaffold(
      appBar: BaseAppBar(this.pageTitle, context),
      bottomNavigationBar: BottomNavBar(currentIndex),
      body: FlowList(items: flows),
    );
  }
}

class FlowList extends StatelessWidget {
  const FlowList({
    Key key,
    @required this.items,
  }) : super(key: key);

  final List<flow_service.Flow> items;

  @override
  Widget build(BuildContext context) {
    // cc:list_flows#3;Render via ListView.builder
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        flow_service.Flow item = items[index];
        return ListTile(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => FlowViewPage('Flow View', item)));
          },
          leading: SvgPicture.asset(
            // cc:list_flows#4;Map Icon to flow.flowType
            flowTypeIconPath(item.flowType),
            color: Colors.black,
            width: 60.0,
            height: 60.0,
          ),
          title: Row(
            children: <Widget>[
              Expanded(
                child: Text(capitalize(item.name)),
              ),
              // cc:list_flows#5;Convert timestamp into human readable format; e.g. "3 Days Ago"
              timeAgo(item.timestamp),
              Icon(Icons.chevron_right),
            ],
          ),
          subtitle: Text(
            "Feeling: ${capitalize(item.flowType)}",
          ),
        );
      },
    );
  }
}

Widget timeAgo(int timestamp) {
  if (timestamp == null) return Text('');
  int now = DateTime
      .now()
      .millisecondsSinceEpoch;
  if (((now - timestamp) / ONE_MINUTE) < 6) return Text('Just Now');
  if (((now - timestamp) ~/ ONE_DAY) >= 1)
    return Text('${((now - timestamp) ~/ ONE_DAY)} Days Ago');
  return Text('Today');
}
