import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:second_opinion_app/di/components/service_locator.dart';
import 'package:second_opinion_app/ui/profile/profile_store.dart';

import '../utils/routes/routes.dart';

class SelectUserModal extends StatefulWidget {
  const SelectUserModal({Key? key}) : super(key: key);

  @override
  State<SelectUserModal> createState() => _SelectUserModalState();
}

class _SelectUserModalState extends State<SelectUserModal> {
  ProfileStore _profileStore = getIt<ProfileStore>();
  String _selectedOption = '-1';
  static const placeholderImage =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/681px-Placeholder_view_vector.svg.png';


  @override
  Widget build(BuildContext context) {
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
          SizedBox(
            height: 300,
            child: ListView.builder(
              itemCount: _profileStore.currentSubUserProfile?.subProfile?.length??0,
              itemBuilder: (BuildContext context, int index) => Card(
                elevation: 1,
                child: RadioListTile<String>(
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage:
                              CachedNetworkImageProvider(_profileStore.currentSubUserProfile?.subProfile?[index].profileImg??placeholderImage),
                        ),
                        SizedBox(width: 8.0),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_profileStore.currentSubUserProfile?.subProfile?[index].name ?? '',style: TextStyle(color:   Color(int.parse('0xFF${_profileStore.currentSubUserProfile!.subProfile![index].color}')),),),
                            Text(
                              'Personal',
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Color(0xFF8b8b8b)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  value: _profileStore.currentSubUserProfile!.subProfile![index].id!.toString(),
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value!;
                    });
                  },
                  activeColor: Colors.green,
                  controlAffinity: ListTileControlAffinity.trailing,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                  selected: _selectedOption == _profileStore.currentSubUserProfile?.subProfile?[index].id,
                ),
              ),
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
  }
}
