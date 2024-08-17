import 'package:architecture_demo/Screens/another_screen.dart';
import 'package:architecture_demo/model/user_model.dart';
import 'package:architecture_demo/provider/provider.dart';
import 'package:architecture_demo/utility/strings_utility.dart';
import 'package:architecture_demo/utility/styles_utility.dart';
import 'package:architecture_demo/utility/widget_utility.dart';
import 'package:architecture_demo/widgets/shimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterScreen extends ConsumerStatefulWidget {
  CounterScreen({Key? key}) : super(key: key);

  @override
  _CounterScreenState createState() => _CounterScreenState();
}

class _CounterScreenState extends ConsumerState<CounterScreen> {
  PageController? _pageController;
  List userLists = [];
  int _page = 0;
  int _count = 0, _drawerCount = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  var apiService;
  @override
  Widget build(BuildContext context) {
    final isConnected = ref.watch(networkProvider);
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final apiService = ref.watch(userDataProvider);

    final exampleValue = ref.watch(exampleValueProvider);

    final alertMessage = ref.watch(alertMessageProvider);

    if (alertMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        WidgetUtility.showAlertDialog(context, ref, alertMessage);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text(StringsUtil.HEADING_LABEL_TEXT)),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      body: Scaffold(
        key: scaffoldKey,
        drawer: _getDrawer(),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: onPageChanged,
          children: <Widget>[
            Column(
              children: [
                // Text(exampleValue ?? 'No value set'),

                Expanded(
                  child: apiService.when(
                    data: (apiService) {
                      List<Data>? userList =
                          apiService; // Access the data property directly

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.builder(
                          itemCount: userList.length,
                          itemBuilder: (_, index) {
                            Data? userData = userList[
                                index]; // Access individual Data object
                            return InkWell(
                              onTap: () {
                                final selectedUser = userList[index];
                                // ref.read(selectedUserProvider).state =
                                //     selectedUser;
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>const AnotherScreen(),
                                  ),
                                );
                              },
                             
                              child: Card(
                                color: Colors.white,
                                elevation: 4,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: ListTile(
                                  title: Text(
                                    userData.firstName ?? '',
                                    style: AppStyles.heading1(context),
                                  ),
                                  subtitle: Text(
                                    userData.lastName ?? '',
                                    style: AppStyles.heading2(context),
                                  ),
                                  trailing: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(userData.avatar ?? ''),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                    error: (err, s) => Text(err.toString()),
                    loading: () => Center(
                      child: ShimmerList(),
                    ),
                  ),
                ),

//                 apiService.when(
//   data: (apiService) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 10),
//       child: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               itemCount: apiService.length, // Use apiService.length instead of userList.length
//               itemBuilder: (_, index) {
//                 final data = apiService[index].data; // Get the individual Data object
//                 return InkWell(
//                   onTap: () => Navigator.of(context).push(
//                     MaterialPageRoute(
//                       builder: (context) => AnotherScreen(),
//                     ),
//                   ),
//                   child: Card(
//                     color: Colors.blue,
//                     elevation: 4,
//                     margin: const EdgeInsets.symmetric(vertical: 10),
//                     child: ListTile(
//                       title: Text(
//                         data!.firstName, // Access firstName property
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                       subtitle: Text(
//                         data.lastName, // Access lastName property
//                         style: const TextStyle(color: Colors.white),
//                       ),
//                       trailing: CircleAvatar(
//                         backgroundImage: NetworkImage(
//                           data.avatar, // Access avatar property
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   },
//   error: (err, s) => Text(err.toString()),
//   loading: () => const Center(
//     child: CircularProgressIndicator(),
//   ),
// ),

                // apiService.when(
                //     data: (apiService) {
                //       List<List<Data>?> userList =
                //           apiService.map((e) => e.data).toList();
                //       return Padding(
                //         padding: const EdgeInsets.symmetric(horizontal: 10),
                //         child: Column(
                //           children: [
                //             Expanded(
                //                 child: ListView.builder(
                //                     itemCount: userList.length,
                //                     itemBuilder: (_, index) {
                //                       return InkWell(
                //                         onTap: () => Navigator.of(context).push(
                //                           MaterialPageRoute(
                //                             builder: (context) =>
                //                                 AnotherScreen(),
                //                           ),
                //                         ),
                //                         child: Card(
                //                           color: Colors.blue,
                //                           elevation: 4,
                //                           margin: const EdgeInsets.symmetric(
                //                               vertical: 10),
                //                           child: ListTile(
                //                             title: Text(
                //                               userList[index]!.firstName,
                //                               style: const TextStyle(
                //                                   color: Colors.white),
                //                             ),
                //                             subtitle: Text(
                //                                 userList[index]?.lastname,
                //                                 style: const TextStyle(
                //                                     color: Colors.white)),
                //                             trailing: CircleAvatar(
                //                               backgroundImage: NetworkImage(
                //                                   userList[index]?.avatar),
                //                             ),
                //                           ),
                //                         ),
                //                       );
                //                     }))
                //           ],
                //         ),
                //       );
                //     },
                //     error: (err, s) => Text(err.toString()),
                //     loading: () => const Center(
                //           child: CircularProgressIndicator(),
                //         )),

                // Expanded(
                //   child: FutureBuilder<List<Data>>(
                //     future: apiService.fetchData(),
                //     builder: (context, snapshot) {
                //       if (snapshot.connectionState == ConnectionState.waiting) {
                //         return ShimmerList();
                //       } else if (snapshot.hasError) {
                //         return ShimmerList();
                //       } else if (snapshot.hasData && snapshot.data != null) {
                //         return ListView.builder(
                //           itemCount: snapshot.data!.length,
                //           itemBuilder: (context, index) {
                //             final userModel = snapshot.data![index];
                //             if (userModel != null) {
                //               return GestureDetector(
                //                 onTap: () {},
                //                 child: ListTile(
                //                   leading: CircleAvatar(
                //                     backgroundImage:
                //                         NetworkImage(userModel.avatar!),
                //                   ),
                //                   title: Text(
                //                       '${userModel.firstName} ${userModel.lastName}'),
                //                   subtitle: Text(userModel.email!),
                //                 ),
                //               );
                //             } else {
                //               return const Center(
                //                   child: Text('No users found'));
                //             }
                //           },
                //         );
                //       } else {
                //         return const Center(child: Text('No data available'));
                //       }
                //     },
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            _count++;
          });
          ref.read(alertMessageProvider.notifier).state = 'Count is $_count';
        },
        backgroundColor: isConnected ? Colors.green : Colors.grey,
        tooltip: 'Check Network',
        child: const Icon(Icons.network_check),
      ),
    );
  }

  Drawer _getDrawer() {
    return Drawer(
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          GestureDetector(
            onTap: () {
              // Navigator.pop(context);
              // if (_customerData == null) {
              //   SharedPreferenceUtils.getStringValuesSF(Strings.USER_DETAILS)
              //       .then((value) {
              //     if (value != null) {
              //       Utils.printLog("Customer data ==$value");
              //       _customerData = CustomerData.fromJson(jsonDecode(value));
              //     }
              //   });
              // }
              // Utils.routeTransitionStateFullPush(
              //     context, MyProfile(_customerData!, this));
            },
            child: Card(
              color: Colors.orange,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.fromLTRB(8, 20, 5, 30),
                child: Row(
                  children: [
                    // (_customerData != null &&
                    //     _customerData!.identitySource!.length > 0)
                    // ? CircleAvatar(
                    //     backgroundImage: NetworkImage("${Constant.BASE_URL}user/${_customerData!.id!}/${_customerData!.identitySource!}"),
                    //   )
                    // : CircleAvatar(
                    //     backgroundImage: AssetImage(Strings.AVTAR_IMAGE),
                    //   ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Ravi"),
                        SizedBox(
                          height: 7,
                        ),
                        Text("Admin"),
                        SizedBox(
                          height: 7,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              // Map item = Strings.drawerItems[index];
              return Card(
                elevation: 2,
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {
                      if (index == 0) {
                        // Utils.showAlertMessage(
                        //     context,
                        //     "",
                        //     Strings.LOGOUT_ALERT_MESSAGE_TEXT,
                        //     Strings.SIGN_OUT_TEXT,
                        //     Strings.CANCEL_TEXT,
                        //     this);
                      } else {
                        _page = index;
                        _pageController!.jumpToPage(index);
                        // _title = item['name'];
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(8, 15, 2, 15),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.home,
                          // item['icon'],
                          color: Colors.orange,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            "Home Screen",
                            style: TextStyle(),
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _getGoodsInventoryByDateApi(
      WidgetRef ref, BuildContext context) async {
    final isConnected = ref.read(networkProvider);
    if (isConnected) {
      setState(() {
        // apiService = ref.watch(apiServiceProvider);
      });

      print('You are connected to the internet.');
    } else {
      print('You are not connected to the internet.');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You are not connected to the internet.')),
      );
    }
  }
}
