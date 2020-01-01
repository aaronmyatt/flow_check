import 'package:flow_check/base/BaseAppBar.dart';
import 'package:flow_check/bottom_navigation_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FlowInfoPage extends StatelessWidget {
  final String pageTitle;

  FlowInfoPage(this.pageTitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(pageTitle, context, backButton: true),
        bottomNavigationBar: BottomNavBar(1),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: paragraphs(context),
            ),
          ),
        ));
  }

  List<Widget> paragraphs(context) {
    return [
      Text(
        'Summary:',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      Text('''
* This is an app for leaders who care more about their people than their outputs.

* This app can help track the internal state of your team so that you may serve them better.

* This app provides a neutral and self appraising technique to initiate deep transformative conversations.
'''),
      Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
        child: Divider(
          thickness: 3.0,
          height: 0.0,
        ),
      ),
      RichText(
        text: TextSpan(
            style: Theme.of(context).textTheme.body1,
            children: <TextSpan>[
              TextSpan(text: 'Flow Check was inspired by this interview with '),
              TextSpan(
                  text: 'Cynthia Maxwell',
                  style: TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launch(
                          'https://firstround.com/review/track-and-facilitate-your-engineers-flow-states-in-this-simple-way/');
                    }),
              TextSpan(
                  text:
                  ', and a quote of hers succinctly articulates my intentions behind building it and the kind of manager and leader I strive to be:'),
            ]),
      ),
      Text(
          '“The question is: how I can get you more into your work, not get more work out of you?”'),
      Text(
          'This app is humble attempt to digitise a graph (fig.1) that is commonly referred to when discussing flow, and how people may deviate from the flow state. This app was made by a manager looking to support their team better and may provide benefit to other managers with similar aspirations.'),
      Column(
        children: <Widget>[
          Image.asset('assets/skill-vs-challenge-better.jpg'),
          Text('Figure 1')
        ],
      ),
      Text(
          '1-on-1s and coaching can only yield as much information as the coachee is willing to divulge. Sometimes an abstract format to rate oneself acts as a more comfortable and simplified format for representing how we feel. With this information the user of this app can glean meaningful information to best support their team and guide team members back towards flow.'),
      Text(
        'What is flow?',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text(
          'Flow is a mental state that you have most likely experienced at one point or another. Recall a time when you felt your most productive, or when a colleague turned to you and said, “wow, you’re really rocking it today!”, or perhaps in school when writing an essay seemed to be effortless, with the words flowing from your fingers.'),
      Text(
          'Flow was named by Mihály Csíkszentmihályi, a pyschologist, in 1975, and wrote an excellent book of the same name. Mihály provided an alternative diagram (that inspired the one this app has adapted) to describe flow (fig 2).'),
      Column(
        children: <Widget>[
          Image.asset(
            'assets/challenge-vs-skill.png',
          ),
          Text('Figure 2')
        ],
      ),
      Text(
          '''It is suggested that there are eight(8) criteria for one to experience flow. A person must:

1) be engaged in a doable task
2) be able to focus
3) have a clear goal
4) receive immediate feedback
5) be able to move without worrying
6) have a sense of control
7) have suspended the sense of self
8) have temporarily lost a sense of time
'''),
      Text(
          'Flow is the state where all intrinsically motivated people yield maximum satisfaction from the work they are doing. It is the state we want our team to be in to ensure we are creating a space within which people can enjoy what they do, grow optimally, be free from anxiety or boredom, and, as a pleasant side effect, do their best work for whomever employs them.'),
      Text(
          'Flow Check seeks to be the app to help your team orient towards flow.')
    ].map((p) {
      if (p is Padding) {
        return p;
      }
      return Padding(padding: const EdgeInsets.all(8.0), child: p);
    }).toList();
  }
}
