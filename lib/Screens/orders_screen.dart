import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:good_deeds_salon/Screens/profiles_screen.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  Stream<QuerySnapshot<Map<String, dynamic>>> getOrdersStream() {
    return FirebaseFirestore.instance
        .collection('orders')
        // .orderBy('createdOn', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: getOrdersStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.deepPurple[200],
                      valueColor: const AlwaysStoppedAnimation<Color>(
                          Colors.deepPurpleAccent),
                    ),
                  ),
                ); // Display a loading indicator while data is loading
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                    child: Text('Looks like there\'s nothing here yet!'));
              }

              // If you reach this point, you have data to display
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var document = snapshot.data!.docs[index];
                  // Access document data using document.data()
                  var data = document.data();

                  double horizontalPaddingValue;
                  double verticalPaddingValue =
                      10.0; // Default vertical padding
                  double screenWidth = MediaQuery.of(context).size.width;

                  // Check if the app is running on the web platform
                  if (screenWidth < 415) {
                    // Apply different padding for web
                    horizontalPaddingValue = 450.0;
                  } else if (screenWidth > 415) {
                    // Default padding value for other platforms (e.g., iOS, Android)
                    horizontalPaddingValue = 10.0;
                  } else {
                    horizontalPaddingValue = 10.0;
                  }

                  // Create widgets to display the document data
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: horizontalPaddingValue,
                        vertical: verticalPaddingValue),
                    child: Container(
                        // width: 400,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: (() {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (builder) {
                                        // setState(() {
                                        //   current_username =
                                        //       data['name'].toString();
                                        // });
                                        return ProfileScreen(
                                            current_username: '');
                                      },
                                    ),
                                  );
                                }),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                        // width: 50,
                                        ),
                                    Text(
                                      data['service_name'].toString(),
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    data['order_date'].toString(),
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.fade,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    data['service_price'],
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.fade,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
