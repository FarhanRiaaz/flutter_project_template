import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:second_opinion_app/stores/report/report_store.dart';
import 'package:second_opinion_app/ui/pdf_view.dart';
import 'package:second_opinion_app/ui/profile/profile_store.dart';
import 'package:second_opinion_app/ui/reports/view_report_image_screen.dart';
import 'package:second_opinion_app/widgets/helper/DialogHelper.dart';

import '../di/components/service_locator.dart';
import '../models/report/get_all_document_response.dart';

class PrescriptionWidget extends StatelessWidget {
    PrescriptionWidget(
      {Key? key,
      required this.result,required this.reportStore, required this.id})
      : super(key: key);

  final int id;
 final Result result;
  final ReportStore reportStore;

 final ProfileStore _profileStore = getIt<ProfileStore>();

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
                  child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: result.file!.endsWith('.jpg') || result.file!.endsWith('.png')
                    ? result.file!
                    : 'https://cdn-icons-png.flaticon.com/512/4208/4208479.png',
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
                    result.fileName!,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(fontSize: 16),
                  ),
                  Text(
                    result.user! ,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 12,color: Color(int.parse('0xFF${_profileStore.getColorFromName(result.user!)}')),),
                  ),
                  Text(
                    DateFormat('MMMM d, yyyy').format(DateTime.parse(result.createdDate!)),
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
                          result.file!.endsWith('.jpg') || result.file!.endsWith('.png')
                              ? Navigator.push(
                                  context, MaterialPageRoute(builder: (context) => ViewReportImage(fileName: result.fileName!, imageUrl: result.file!)))
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewPDF(
                                            fileName: result.fileName!,
                                            pdfURL: result.file!,
                                          )));
                        },
                        context: context),
                    SizedBox(
                      height: 8,
                    ),
                    _buildActionWidget(
                        icon: Icons.delete_outline,
                        onPressed: () {
                          DialogHelper.showDeleteConfirmationDialog(context, result.user!, () async {
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
