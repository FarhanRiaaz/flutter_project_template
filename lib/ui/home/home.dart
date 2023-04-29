import 'package:another_flushbar/flushbar_helper.dart';
import 'package:second_opinion_app/data/sharedpref/constants/preferences.dart';
import 'package:second_opinion_app/utils/routes/routes.dart';
import 'package:second_opinion_app/stores/language/language_store.dart';
import 'package:second_opinion_app/stores/post/post_store.dart';
import 'package:second_opinion_app/stores/theme/theme_store.dart';
import 'package:second_opinion_app/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'categories_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //stores:---------------------------------------------------------------------
  late PostStore _postStore;
  late ThemeStore _themeStore;
  late LanguageStore _languageStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
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
      actions: _buildActions(context),
    );
  }

  Widget _buildLeadingButton() {
    return IconButton(
      icon: const Icon(Icons.headphones_outlined),
      onPressed: () {},
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

  Widget _buildGoodMorningText() {
    return Text(
      'Good morning!',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
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

  Widget _buildCard() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.20,
      child: Card(
        color: const Color(0xFFDCF1F5),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text('Better Healthcare, Better Tomorrow', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                    Text('You need our best consultancy and assistance ',
                        style: TextStyle(fontSize: 12, color: Color(0xFF6E6E6E))),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Image.asset(
                    'assets/images/doctor_image.png',
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ],
          ),
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

  Widget _buildCategories() {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Categories',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF222B2C)),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.categories);
                  },
                  child: const Text(
                    'See all',
                    style: TextStyle(color: Color(0xFF16CAEA)),
                  ))
            ],
          ),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: gridItems
                .take(6)
                .map((item) => MedicalFieldGridTile(
                      title: item['name'],
                      path: item['imagePath'],
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeButton() {
    return Observer(
      builder: (context) {
        return IconButton(
          onPressed: () {
            _themeStore.changeBrightnessToDark(!_themeStore.darkMode);
          },
          icon: Icon(
            _themeStore.darkMode ? Icons.brightness_5 : Icons.brightness_3,
          ),
        );
      },
    );
  }

  Widget _buildLogoutButton() {
    return IconButton(
      onPressed: () {
        SharedPreferences.getInstance().then((preference) {
          preference.setBool(Preferences.is_logged_in, false);
          Navigator.of(context).pushReplacementNamed(Routes.login);
        });
      },
      icon: Icon(
        Icons.power_settings_new,
      ),
    );
  }

  Widget _buildLanguageButton() {
    return IconButton(
      onPressed: () {
        _buildLanguageDialog();
      },
      icon: Icon(
        Icons.language,
      ),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        _handleErrorMessage(),
        _buildMainContent(),
      ],
    );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGoodMorningText(),
              SizedBox(
                height: 20,
              ),
              _buildCard(),
              SizedBox(
                height: 20,
              ),
              _buildSearchBar(),
              SizedBox(
                height: 20,
              ),
              _buildCategories(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildListView() {
    return _postStore.postList != null
        ? ListView.separated(
            itemCount: _postStore.postList!.posts!.length,
            separatorBuilder: (context, position) {
              return Divider();
            },
            itemBuilder: (context, position) {
              return _buildListItem(position);
            },
          )
        : Center(
            child: Text(
              AppLocalizations.of(context).translate('home_tv_no_post_found'),
            ),
          );
  }

  Widget _buildListItem(int position) {
    return ListTile(
      dense: true,
      leading: Icon(Icons.cloud_circle),
      title: Text(
        '${_postStore.postList?.posts?[position].title}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        '${_postStore.postList?.posts?[position].body}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
      ),
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_postStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(_postStore.errorStore.errorMessage);
        }

        return SizedBox.shrink();
      },
    );
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: AppLocalizations.of(context).translate('home_tv_error'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }

  _buildLanguageDialog() {
    _showDialog<String>(
      context: context,
      child: MaterialDialog(
        borderRadius: 5.0,
        enableFullWidth: true,
        title: Text(
          AppLocalizations.of(context).translate('home_tv_choose_language'),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        headerColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        closeButtonColor: Colors.white,
        enableCloseButton: true,
        enableBackButton: false,
        onCloseButtonClicked: () {
          Navigator.of(context).pop();
        },
        children: _languageStore.supportedLanguages
            .map(
              (object) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.all(0.0),
                title: Text(
                  object.language!,
                  style: TextStyle(
                    color: _languageStore.locale == object.locale
                        ? Theme.of(context).primaryColor
                        : _themeStore.darkMode
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // change user language based on selected locale
                  _languageStore.changeLanguage(object.locale!);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  _showDialog<T>({required BuildContext context, required Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T? value) {
      // The value passed to Navigator.pop() or null.
    });
  }
}
