part of 'pages.dart';

class FoodPage extends StatefulWidget {
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    print((context.bloc<UserCubit>().state as UserLoaded)
        .user
        .picturePath
        .toString());
  }

  @override
  Widget build(BuildContext context) {
    double listItemWidth = MediaQuery.of(context).size.width - 2 * defaulMargin;
    return ListView(
      children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: defaulMargin),
              color: Colors.white,
              height: 100,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Food Market",
                        style: blackFontStyle1,
                      ),
                      Text(
                        "Let's get some foods",
                        style:
                            greyFontStyle.copyWith(fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      // var result = await context.bloc<UserCubit>().logOut();
                      // setState(() {});

                      Get.offAll(SignInPage());
                      await context.bloc<UserCubit>().logout();

                      // print();
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: NetworkImage(URLPhoto +
                                  (context.bloc<UserCubit>().state
                                          as UserLoaded)
                                      .user
                                      .picturePath!),
                              fit: BoxFit.cover)),
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 258,
              width: double.infinity,
              child: BlocBuilder<FoodCubit, FoodState>(
                builder: (_, state) => (state is FoodLoaded)
                    ? ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          Row(
                            children: state.foods
                                .map((e) => Padding(
                                      padding: EdgeInsets.only(
                                          left: (e == state.foods.first)
                                              ? defaulMargin
                                              : 0,
                                          right: defaulMargin),
                                      child: GestureDetector(
                                          onTap: () {
                                            Get.to(FoodDetailsPage(
                                              transaction: Transaction(
                                                  food: e,
                                                  user: (context
                                                          .bloc<UserCubit>()
                                                          .state as UserLoaded)
                                                      .user),
                                              onBackButtonOnpressed: () {
                                                Get.back();
                                              },
                                            ));
                                            print(e);
                                          },
                                          child: FoodCard(e)),
                                    ))
                                .toList(),
                          )
                        ],
                      )
                    : Center(child: loadingIndicator),
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Column(
                children: [
                  CustomTabBar(
                    titles: ['New Taste', 'Popular', 'Recommended'],
                    selectedIndex: selectedIndex,
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<FoodCubit, FoodState>(builder: (_, state) {
                    if (state is FoodLoaded) {
                      List<Food> foods = state.foods
                          .where((element) =>
                              element.types!.contains((selectedIndex == 0)
                                  ? FoodType.new_food
                                  : (selectedIndex == 1)
                                      ? FoodType.popular
                                      : FoodType.recommended))
                          .toList();

                      return Column(
                          children: foods
                              .map((e) => GestureDetector(
                                    onTap: () {
                                      Get.to(FoodDetailsPage(
                                        transaction: Transaction(
                                            food: e,
                                            user: (context
                                                    .bloc<UserCubit>()
                                                    .state as UserLoaded)
                                                .user),
                                        onBackButtonOnpressed: () {
                                          Get.back();
                                        },
                                      ));
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          defaulMargin, 0, defaulMargin, 16),
                                      child: FoodListItem(
                                        e,
                                        itemWidth: listItemWidth,
                                      ),
                                    ),
                                  ))
                              .toList());
                    } else {
                      return Center(
                        child: loadingIndicator,
                      );
                    }
                  }),
                  ////
                ],
              ),
            ),
            SizedBox(
              height: 80,
            )
          ],
        )
      ],
    );
  }
}
