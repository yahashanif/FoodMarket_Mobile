part of 'pages.dart';

class OrderHistoryPage extends StatefulWidget {
  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(builder: (_, state) {
      if (state is TransactionLoaded) {
        if (state.transaction.length == 0) {
          return IllustrationPage(
            title: "Ouch! Hungry",
            subtitle: "Seems like you have not\nordered any food yet",
            picturePath: "assets/love_burger.png",
            buttonTap1: () {
              Get.offAll(MainPage(
                initialPage: 0,
              ));
            },
            buttonTitle1: "Find Foods",
          );
        } else {
          double listItemWidth =
              MediaQuery.of(context).size.width - 2 * defaulMargin;
          // return ListView(
          //   children: [
          //     Column(
          //       children: [
          //         Container(
          //           height: 100,
          //           width: double.infinity,
          //           margin: EdgeInsets.symmetric(horizontal: defaulMargin),
          //           padding: EdgeInsets.symmetric(horizontal: defaulMargin),
          //           color: Colors.white,
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Text(
          //                 "Your Orders",
          //                 style: blackFontStyle1,
          //               ),
          //               Text(
          //                 "Wait for the best meal",
          //                 style:
          //                     greyFontStyle.copyWith(fontWeight: FontWeight.w300),
          //               )
          //             ],
          //           ),
          //         )
          //       ],
          //     )
          //   ],
          // );
          return RefreshIndicator(
            onRefresh: () async {
              // User user;
              print(User.token);
              print(TransactionServices.getTransactions());
              await context.bloc<TransactionCubit>().getTransactions();
            },
            child: GeneralPage(
              title: "Your Orders",
              subtitle: "Wait for the best meal",
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  children: [
                    CustomTabBar(
                      titles: ['In Progress', 'Pass Orders'],
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
                    Builder(builder: (_) {
                      List<Transaction> transaction = (selectedIndex == 0)
                          ? state.transaction
                              .where((element) =>
                                  element.status ==
                                      TransactionStatus.on_delivery ||
                                  element.status == TransactionStatus.pending)
                              .toList()
                          : state.transaction
                              .where((element) =>
                                  element.status ==
                                      TransactionStatus.delivered ||
                                  element.status == TransactionStatus.cancelled)
                              .toList();
                      return Column(
                        children: transaction
                            .map((e) => Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      defaulMargin, 0, defaulMargin, 16),
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (e.status ==
                                          TransactionStatus.pending) {
                                        await launch(e.paymentUrl!);
                                      }
                                    },
                                    child: OrderListItem(
                                      e,
                                      itemWidth: listItemWidth,
                                    ),
                                  ),
                                ))
                            .toList(),
                      );
                    }),
                    SizedBox(
                      height: 60,
                    )
                  ],
                ),
              ),
            ),
          );
        }
      } else {
        return Center(
          child: loadingIndicator,
        );
      }
    });
  }
}
