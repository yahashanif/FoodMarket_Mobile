part of 'pages.dart';

class ProfilePage extends StatefulWidget {
  final User? user;

  ProfilePage({this.user});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedIndex = 0;
  List<String> account = [
    "Edit Profile",
    "Home Address",
    "Security",
    "Payments"
  ];
  List<String> foodMarket = [
    "Rate App",
    "Help Center",
    "Privacy & Policy",
    "Terms & Conditions"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 26),
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/photo_border.png"))),
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                (context.bloc<UserCubit>().state as UserLoaded)
                                    .user
                                    .picturePath!,
                              ),
                              fit: BoxFit.cover)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: SizedBox(
                      child: Center(
                        child: Text(
                          (context.bloc<UserCubit>().state as UserLoaded)
                              .user
                              .name
                              .toString(),
                          style: blackFontStyle3.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 26),
                    child: SizedBox(
                      child: Center(
                        child: Text(
                            (context.bloc<UserCubit>().state as UserLoaded)
                                .user
                                .email
                                .toString(),
                            style: greyFontStyle),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  CustomTabBar(
                    selectedIndex: selectedIndex,
                    titles: ["Account", "FoodMarket"],
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Column(
                    children: (selectedIndex == 0 ? account : foodMarket)
                        .map((e) => Padding(
                              padding: EdgeInsets.fromLTRB(
                                  defaulMargin, 0, defaulMargin, 10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    e,
                                    style: blackFontStyle2,
                                  ),
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/right_arrow.png"))),
                                    ),
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
