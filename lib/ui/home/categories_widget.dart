import 'package:flutter/material.dart';
import 'package:second_opinion_app/utils/routes/routes.dart';

class MedicalFieldGridTile extends StatefulWidget {
  const MedicalFieldGridTile({
    super.key,
    required this.title,
    required this.url,
  });

  final String title;
  final String url;

  @override
  State<MedicalFieldGridTile> createState() => _MedicalFieldGridTileState();
}

class _MedicalFieldGridTileState extends State<MedicalFieldGridTile> {
  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: () {
            _showBottomSheet(context);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  height: 40,
                  width: 40,
                  child: Image.network(
                    widget.url,
                    fit: BoxFit.fitHeight,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  widget.title,
                  style: const TextStyle(fontSize: 11),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    String _selectedOption = '-1';

    showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Select User',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Card(
                elevation: 1,
                child: RadioListTile<String>(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage('https://imglarger.com/Images/before-after/ai-image-enlarger-1-before-2.jpg'),
                        ),
                        SizedBox(width: 8.0),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Muhammad Zeeshan'),
                            Text(
                              'Personal',
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Color(0xFF8b8b8b)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  value: 'Muhammad Zeeshan',
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value!;
                    });
                  },
                  activeColor: Colors.green,
                  controlAffinity: ListTileControlAffinity.trailing,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  selected: _selectedOption == 'option1',
                ),
              ),
              Card(
                elevation: 1,
                child: RadioListTile<String>(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage('https://imglarger.com/Images/before-after/ai-image-enlarger-1-before-2.jpg'),
                        ),
                        SizedBox(width: 8.0),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Muhammad Zeeshan'),
                            Text(
                              'Son',
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Color(0xFF8b8b8b)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  value: 'option2',
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value!;
                    });
                  },
                  activeColor: Colors.green,
                  controlAffinity: ListTileControlAffinity.trailing,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  selected: _selectedOption == 'option1',
                ),
              ),
              Card(
                elevation: 1,
                child: RadioListTile<String>(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              NetworkImage('https://imglarger.com/Images/before-after/ai-image-enlarger-1-before-2.jpg'),
                        ),
                        SizedBox(width: 8.0),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Muhammad Zeeshan'),
                            Text(
                              'Daughter',
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Color(0xFF8b8b8b)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  value: 'option3',
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value!;
                    });
                  },
                  activeColor: Colors.green,
                  controlAffinity: ListTileControlAffinity.trailing,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  selected: _selectedOption == 'option1',
                ),
              ),
              SizedBox(height: 16.0),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.question);
                  },
                  child: Text('Continue'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
