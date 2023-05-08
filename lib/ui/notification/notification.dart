import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  List<Map<String, dynamic>> notificationData = [
    {
      'label': 'Appointment Confirmed',
      'description': 'Your appointment will start in 15 minutes',
      'timeago': DateTime.now().subtract(
        Duration(hours: 5),
      ),
    },
    {
      'label': 'Appointment Alarm',
      'description': 'Your appointment will start in 15 minutes',
      'timeago': DateTime.now().subtract(
        Duration(hours: 568),
      ),
    },
    {
      'label': 'New Feature',
      'description': 'Your appointment will start in 15 minutes',
      'timeago': DateTime.now().subtract(
        Duration(minutes: 15),
      ),
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: RefreshIndicator(
          onRefresh: () async {},
          child: ListView.builder(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            itemCount: notificationData.length,
            itemBuilder: (context, index) {
              return NotificationsTile(
                label: notificationData[index]['label'],
                description: notificationData[index]['description'],
                timeStamp: notificationData[index]['timeago'],
                iconData: Icons.notifications_rounded,
              );
            },
          ),
        ));
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: _buildLeadingButton(),
      centerTitle: true,
      title: _buildTitle(),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Notifications',
      style: Theme.of(context).textTheme.headlineMedium,
    );
  }

  Widget _buildLeadingButton() {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
}

class NotificationsTile extends StatelessWidget {
  const NotificationsTile({
    Key? key,
    required this.label,
    required this.description,
    required this.timeStamp,
    required this.iconData,
  }) : super(key: key);

  final String label;
  final String description;
  final DateTime timeStamp;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 4.0,
      ),
      child: Material(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(padding: const EdgeInsets.all(8.0), child: _buildIcon()),
              const SizedBox(width: 8.0),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.69,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      description,
                    ),
                    Text(
                      timeago.format(timeStamp),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  CircleAvatar _buildIcon() {
    if (label == 'Appointment Confirmed') {
      return CircleAvatar(
          foregroundColor: Colors.white,
          backgroundColor: Color(0xFF1ce0a3),
          child: ImageIcon(
            AssetImage('assets/icons/appointmentConfirmed.png'),
            size: 18,
          ));
    } else if (label == 'Appointment Alarm') {
      CircleAvatar(
          foregroundColor: Colors.white,
          backgroundColor: Color(0xFFec652a),
          child: ImageIcon(
            AssetImage('assets/icons/notificationClock.png'),
            size: 18,
          ));
    }

    return CircleAvatar(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xFF16caea),
        child: ImageIcon(
          AssetImage('assets/icons/notification.png'),
          size: 18,
        ));
  }
}
