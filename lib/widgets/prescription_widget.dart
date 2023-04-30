import 'package:flutter/material.dart';

class PrescriptionWidget extends StatelessWidget {
  const PrescriptionWidget({Key? key}) : super(key: key);

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
                    '22 \n March',
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
                    'Flue, Cough, Fever',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Text(
                    'Dr. Sanukay',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    'March 22, 2023',
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