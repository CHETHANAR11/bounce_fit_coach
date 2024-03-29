import 'package:bounce_fit_coach/rive_app/components/time.dart';
import 'package:flutter/material.dart';
import 'package:bounce_fit_coach/rive_app/theme.dart';

class TimerTab extends StatefulWidget {
  const TimerTab({Key? key}) : super(key: key);

  @override
  _TimerTabState createState() => _TimerTabState();
}

class _TimerTabState extends State<TimerTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RiveAppTheme.background,
      appBar: AppBar(
        
        title:  const Padding(
          padding:  EdgeInsets.only(left: 40),
          child: Text('Time')),
        ),
        body: const Column(
          children: [
           Time(),
          ],
          )
    );
     }
}
