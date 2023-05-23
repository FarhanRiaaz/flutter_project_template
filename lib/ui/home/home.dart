import 'package:animations/animations.dart';
import 'package:another_flushbar/flushbar_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:second_opinion_app/data/sharedpref/constants/preferences.dart';
import 'package:second_opinion_app/di/components/service_locator.dart';
import 'package:second_opinion_app/models/home/home_api_response.dart';
import 'package:second_opinion_app/stores/category/category_store.dart';
import 'package:second_opinion_app/ui/add_user.dart';
import 'package:second_opinion_app/ui/categories/categories.dart';
import 'package:second_opinion_app/ui/profile/profile_store.dart';
import 'package:second_opinion_app/utils/routes/routes.dart';
import 'package:second_opinion_app/stores/language/language_store.dart';
import 'package:second_opinion_app/stores/post/post_store.dart';
import 'package:second_opinion_app/stores/theme/theme_store.dart';
import 'package:second_opinion_app/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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

  CategoryStore _categoryStore = getIt<CategoryStore>();
  ProfileStore _profileStore = getIt<ProfileStore>();

  @override
  void initState() {
    _categoryStore.getAllCategories();
    _profileStore.getProfile();
    _profileStore.getSubUserProfiles();
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

  static const placeholderImage =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/Placeholder_view_vector.svg/681px-Placeholder_view_vector.svg.png';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildBody(),
    );
  }

  // app bar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: Image.asset(
          'assets/icons/icon.png',
          scale: 3.1,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      leading: _buildLeadingButton(),
      actions: _buildActions(context),
    );
  }

  Widget _buildLeadingButton() {
    return IconButton(
      icon: ImageIcon(AssetImage(
        'assets/icons/Headphones.png',
      )),
      onPressed: () {
        SharedPreferences.getInstance().then((preference) {
          preference.setBool(Preferences.is_logged_in, false);
          Navigator.of(context).pushReplacementNamed(Routes.login);
        });
      },
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
          Navigator.pushNamed(context, Routes.profile);
        },
        customBorder: CircleBorder(),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 18,
          backgroundImage: CachedNetworkImageProvider(
            _profileStore.currentUserProfile?.profileImg ?? placeholderImage,
          ),
        ),
      ),
    );
  }

  Widget _buildGoodMorningText() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '👋 Good morning!',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        Text(
          _profileStore.currentUserProfile?.name ?? '',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return OpenContainer(
      transitionDuration: Duration(milliseconds: 300),
      middleColor: Colors.white,
      transitionType: ContainerTransitionType.fade,
      closedElevation: 0,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      closedColor: Colors.white,
      openBuilder: (BuildContext context, VoidCallback _) {
        // Replace the return statement with the desired widget to be shown when opened (e.g., another page)
        return CategoriesScreen(
          autoFocus: true,
        );
      },
      closedBuilder: (BuildContext context, VoidCallback openContainer) {
        return GestureDetector(
          onTap: openContainer,
          child: TextField(
            readOnly: true,
            onTap: openContainer,
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
          ),
        );
      },
    );
  }

  Widget _buildCard() {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.20,
        child: PageView(allowImplicitScrolling: true,
          children: [
            Card(
              color: const Color(0xFFDCF1F5),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    //Todo Change to Image slider . Only URL images full card
                    Expanded(
                      flex: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Better Healthcare, Better Tomorrow', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
            Card(
              color: const Color(0xFFDCF1F5),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    //Todo Change to Image slider . Only URL images full card
                    Expanded(
                      flex: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Better Healthcare, Better Tomorrow', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
            Card(
              color: const Color(0xFFDCF1F5),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    //Todo Change to Image slider . Only URL images full card
                    Expanded(
                      flex: 6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Better Healthcare, Better Tomorrow', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
          ],
        ));
  }

  Widget _buildNotificationButton() {
    return IconButton(
      icon: Stack(
        children: const [
          ImageIcon(AssetImage(
            'assets/icons/BellIcon.png',
          )),
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
      onPressed: () {
        Navigator.pushNamed(context, Routes.notification);
      },
    );
  }

  Widget _buildCategories() {
    return Column(
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
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: _categoryStore.allCategoryList == null ? 0 : _categoryStore.allCategoryList?.allCategoryList?.length,
          itemBuilder: (context, index) => MedicalFieldGridTile(
            title: _categoryStore.allCategoryList!.allCategoryList![index].title!,
            url: _categoryStore.allCategoryList!.allCategoryList![index].image ?? placeholderImage,
          ),
        )
      ],
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

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.35,
            child: Opacity(opacity: 0.25, child: Image.asset('assets/images/background/bottomRight.png')),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Opacity(opacity: 0.25, child: Image.asset('assets/images/background/topLeft.png')),
          ),
        ),
        _handleErrorMessage(),
        _buildMainContent(),
      ],
    );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12, bottom: 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildGoodMorningText(),
                      SizedBox(
                        height: 20,
                      ),
                      _buildCard(),
                      _buildMyUser(),
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
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMyUser() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 8,
        ),
        Text(
          'My Users',
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.myUsers);
              },
              child: Container(
                height: 70,
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 18,
                      backgroundImage: CachedNetworkImageProvider(
                        _profileStore.currentUserProfile?.profileImg ?? placeholderImage,
                      ),
                    ),
                    Text(
                      'You',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 6,
            ),
            Expanded(
                child: Container(
              height: 70,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: _profileStore.currentSubUserProfile?.subProfile?.length != null
                    ? _profileStore.currentSubUserProfile?.subProfile?.length.clamp(0, 3)
                    : 0,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.myUsers);
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 18,
                          backgroundImage: CachedNetworkImageProvider(
                              _profileStore.currentSubUserProfile?.subProfile?[index].profileImg ?? placeholderImage),
                        ),
                        SizedBox(
                          width: 50,
                          child: Center(
                            child: Text(
                              _profileStore.currentSubUserProfile!.subProfile![index].name!.split(' ').first,
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )),
            SizedBox(
              width: 2,
            ),
            SizedBox(
              height: 70,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddUserScreen()));
                    },
                    child: CircleAvatar(
                      radius: 18,
                      child: Icon(Icons.add),
                    ),
                  ),
                  Text('', style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        )
      ],
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
}
