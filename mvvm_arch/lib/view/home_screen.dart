// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:mvvm_arch/data/response/status.dart';
import 'package:mvvm_arch/utils/routes/routes_name.dart';
import 'package:mvvm_arch/utils/utility.dart';
import 'package:mvvm_arch/view_model/home_view_model.dart';
import 'package:mvvm_arch/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel homeViewModel = HomeViewModel();

  @override
  void initState() {
    super.initState();
    homeViewModel.getMoviesList();
  }

  @override
  Widget build(BuildContext context) {
    final userPref = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies List'),
        automaticallyImplyLeading: false,
        actions: [
          Center(
            child: InkWell(
              onTap: () async {
                final response = await userPref.remove();
                if (response == true) {
                  Navigator.pushReplacementNamed(
                      context, RoutesName.loginScreen);
                }
              },
              child: const Text('Logout'),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: SafeArea(
        child: ChangeNotifierProvider<HomeViewModel>(
          create: (context) => homeViewModel,
          child: Consumer<HomeViewModel>(
            builder: (context, value, _) {
              switch (value.moviesList.status) {
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Center(
                    child: Text(value.moviesList.message.toString()),
                  );
                case Status.COMPLETED:
                  return ListView.builder(
                      itemCount: value.moviesList.data!.movies!.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: Image.network(
                              height: 40,
                              width: 40,
                              value.moviesList.data!.movies![index].posterurl
                                  .toString(),
                              errorBuilder: ((context, error, stackTrace) {
                                return const Icon(
                                  Icons.error,
                                  color: Colors.red,
                                );
                              }),
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              value.moviesList.data!.movies![index].title
                                  .toString(),
                            ),
                            subtitle: Text(
                              value.moviesList.data!.movies![index].year
                                  .toString(),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(Utility.averageRating(value.moviesList
                                        .data!.movies![index].ratings!)
                                    .toString()),
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                )
                              ],
                            ),
                          ),
                        );
                      });
                default:
                  return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}
