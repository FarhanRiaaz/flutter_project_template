
import 'package:second_opinion_app/stores/post/post_store.dart';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../home/categories_widget.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  //stores:---------------------------------------------------------------------
  late PostStore _postStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores

    _postStore = Provider.of<PostStore>(context);

    // check to see if already called api
    if (!_postStore.loading) {
      _postStore.getPosts();
    }
  }

  static const List<Map<String, dynamic>> gridItems = [
    {
      'name': 'Cardiologist',
      'imagePath': 'assets/images/organs/heart.png',
    },
    {
      'name': 'Dentist',
      'imagePath': 'assets/images/organs/tooth.png',
    },
    {
      'name': 'Hepatologist',
      'imagePath': 'assets/images/organs/liver.png',
    },
    {
      'name': 'Nephrologists',
      'imagePath': 'assets/images/organs/kidney.png',
    },
    {
      'name': 'Pulmonologist',
      'imagePath': 'assets/images/organs/lungs.png',
    },
    {
      'name': 'Neurologists',
      'imagePath': 'assets/images/organs/brain.png',
    },
    // add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  // app bar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: _buildLeadingButton(),
      centerTitle: true,
      title: _buildTitle (),
      actions: _buildActions(context),
    );
  }

  Widget _buildTitle (){
    return Text('Categories',style: Theme.of(context).textTheme.headlineMedium,);
  }

  Widget _buildLeadingButton() {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_rounded),
      onPressed: () {Navigator.pop(context);},
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return <Widget>[
      _buildNotificationButton(),
      _buildAvatarButton(),
      // _buildThemeButton(),
      //_buildLogoutButton(),
    ];
  }

  Widget _buildAvatarButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: InkWell(
        onTap: () {
          // Do something when the button is tapped
        },
        customBorder: CircleBorder(),
        child: CircleAvatar(
          radius: 18,
          backgroundImage: AssetImage('assets/images/circleAvatar.png'),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: Icon(
          Icons.search,
          color: Color(0xFFCCD2D8),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
    );
  }

  Widget _buildNotificationButton() {
    return IconButton(
      icon: Stack(
        children: const [
          Icon(Icons.notifications_none_rounded),
          Positioned(
            top: 0,
            right: 0,
            child: CircleAvatar(
              radius: 7,
              backgroundColor: Colors.redAccent,
              child: Text(
                '1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
          ),
        ],
      ),
      onPressed: () {},
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return _buildMainContent();
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              SizedBox(
                height: 20,
              ),
              _buildGridView(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      itemCount: gridItems.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (BuildContext context, int index) => _buildGridItem(index),
    );
  }

  Widget _buildGridItem(int index) {
    return MedicalFieldGridTile(
      title: gridItems[index]['name'],
      path: gridItems[index]['imagePath'],
    );
  }
}
