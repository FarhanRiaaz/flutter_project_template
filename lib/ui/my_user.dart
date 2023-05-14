import 'package:flutter/material.dart';
import 'package:second_opinion_app/utils/routes/routes.dart';

class MyUsers extends StatefulWidget {
  const MyUsers({Key? key}) : super(key: key);

  @override
  State<MyUsers> createState() => _MyUsersState();
}

class _MyUsersState extends State<MyUsers> {
  List<Map<String, String>> users = [
    {
      'name': 'John Doe',
      'relationship': 'Me',

    },
    {
      'name': 'Jane Smith',
      'relationship': 'Daughter',

    },
    {
      'name': 'Bob Johnson',
      'relationship': 'Son',

    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: _buildTitle(),
      centerTitle: true,
      leading: _buildLeadingButton(),
    );
  }

  _buildBody() {
    return Stack(
      children: [
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
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSearchBarWithButton(),
              SizedBox(
                height: 10,
              ),
              _buildCardList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLeadingButton() {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back_ios_new_rounded,
        color: Colors.black,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _buildTitle() {
    return Text(
      'Chat',
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.black),
    );
  }

  Widget _buildSearchBarWithButton() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),

      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                color: Colors.white,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(
                    Icons.search,
                    color: Color(0xFFCCD2D8),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          SizedBox(width: 5,),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                  Radius.circular(10),

              ),
              color: Theme.of(context).primaryColor,
            ),
            child: IconButton(
              icon: Icon(Icons.add_circle_outline_rounded),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: users.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildUserWidget(users[index]['name']!, users[index]['relationship']! );
      },

    );
  }

  Widget _buildUserWidget(String name, String relation ) {
    return InkWell(onTap: (){Navigator.pushNamed(context,Routes.profile);},
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/profilePicture.png',
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),

              SizedBox(
                width: 12,
              ),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      relation,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildActionWidget(icon: Icons.delete_outline, onPressed: () {}, context: context),

                ],
              ),
            ],
          ),
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
