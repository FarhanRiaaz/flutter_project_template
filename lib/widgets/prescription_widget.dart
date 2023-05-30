import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:second_opinion_app/stores/report/report_store.dart';
import 'package:second_opinion_app/ui/pdf_view.dart';
import 'package:second_opinion_app/widgets/helper/DialogHelper.dart';

class PrescriptionWidget extends StatelessWidget {
  const PrescriptionWidget(
      {Key? key,
      required this.symptoms,
      required this.doctorName,
      required this.dateTime,
      required this.id,
      required this.reportStore,
      required this.pdfUrl})
      : super(key: key);

  final int id;
  final String symptoms;
  final String doctorName;
  final String dateTime;
  final ReportStore reportStore;
  final String pdfUrl;

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
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8.0),
              ),
              height: 90,
              width: 90,
              child: Center(
                  child: Image.asset(
                'assets/icons/blankImage.png',
                scale: 2.6,
              )),
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
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 16),
                  ),
                  Text(
                    doctorName,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 12),
                  ),
                  Text(
                    DateFormat('MMMM d, yyyy').format(DateTime.parse(dateTime)),
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _buildActionWidget(
                        icon: Icons.remove_red_eye_outlined,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewPDF(
                                    fileName:symptoms,
                                        pdfURL: pdfUrl,
                                      )));
                        },
                        context: context),
                    SizedBox(
                      height: 8,
                    ),
                    _buildActionWidget(
                        icon: Icons.delete_outline,
                        onPressed: () {
                          DialogHelper.showDeleteConfirmationDialog(context, symptoms, () async {
                            reportStore.currentDocumentToDelete = id;
                            reportStore.deleteDocument();
                            Navigator.pop(context);
                          });
                        },
                        context: context),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildActionWidget({
    required IconData icon,
    required VoidCallback onPressed,
    required BuildContext context,
  }) {
    return SizedBox(
      width: 30,
      height: 30,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).primaryColor.withOpacity(0.1),
        ),
        child: IconButton(
          splashRadius: 10,
          color: Theme.of(context).primaryColor,
          onPressed: onPressed,
          icon: Icon(icon, size: 15),
        ),
      ),
    );
  }
}
