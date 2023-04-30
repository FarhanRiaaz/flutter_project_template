import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PrescriptionWidget extends StatelessWidget {
  const PrescriptionWidget({Key? key, required this.symptoms, required this.doctorName, required this.dateTime}) : super(key: key);

  final String symptoms;
  final String doctorName;
  final DateTime dateTime;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                height: 80,
                child: Center(
                  child: Text(
                    '${DateFormat('d').format(dateTime)}\n${DateFormat('MMMM').format(dateTime)}',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 9,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    symptoms,
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(
                    doctorName,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    DateFormat('MMMM d, y').format(dateTime),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildActionWidget(icon: Icons.remove_red_eye_outlined, onPressed: () {},context: context),
                    _buildActionWidget(icon: Icons.download_for_offline_outlined, onPressed: () {},context: context),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildActionWidget({required IconData icon, required VoidCallback onPressed,required BuildContext context}) {
    return SizedBox(width: double.infinity,height: 40,
      child: IconButton(splashRadius:10,
          color: Theme.of(context).primaryColor,
          onPressed: () {
            onPressed();
          },
          icon: Icon(icon,size: 20,)),
    );
  }
}