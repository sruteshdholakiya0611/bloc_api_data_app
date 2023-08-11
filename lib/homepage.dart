import 'package:bloc_api_data_app/blocs/app_blocs.dart';
import 'package:bloc_api_data_app/blocs/app_events.dart';
import 'package:bloc_api_data_app/blocs/app_states.dart';
import 'package:bloc_api_data_app/model/user_model.dart';
import 'package:bloc_api_data_app/repo/repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(UserRepository()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 80,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.tune_rounded),
            iconSize: 45,
            splashRadius: 45,
            splashColor: const Color(0xFF6895ED),
            color: const Color(0xFF999999),
          ),
          title: const Text('BloC App'),
          titleTextStyle: const TextStyle(
            fontFamily: 'Consolas',
            fontSize: 30,
            color: Color(0xFF777777),
          ),
          toolbarHeight: 200,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            background: Icon(
              Icons.settings_suggest_outlined,
              size: 200,
              color: const Color(0xFF999999).withOpacity(0.2),
            ),
          ),
        ),
        body: blocBody(),
      ),
    );
  }

  Widget blocBody() {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(5),
          boxShadow: const [
            BoxShadow(
              color: Color(0xFFB0C4DE),
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ]
      ),
      child: BlocProvider(
        create: (context) => UserBloc(
          UserRepository(),
        )..add(LoadUserEvent()),
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is UserLoadedState) {
              List<UserModel> userList = state.users;
              return ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (_, index) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F8FF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        tileColor: const Color(0xFF999999),
                        minVerticalPadding: 10,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        minLeadingWidth: 60,
                        contentPadding: const EdgeInsets.all(10),
                          title: Text(
                            '${userList[index].firstName}  ${userList[index].lastName}',
                            style: const TextStyle(fontSize: 25),
                          ),
                        textColor: const Color(0xFF777777),
                          subtitle: Text(
                            '${userList[index].email}',
                            style: const TextStyle(fontSize: 20),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                userList[index].avatar.toString()),
                            radius: 25,
                          ),
                        trailing: IconButton(onPressed: (){
                          /*Navigator.push(context, MaterialPageRoute(builder: (context)=>
                              Container(
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                color: const Color(0xFFFFFFFF),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Color(0xFFB0C4DE),
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                  ),
                                ]
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                      userList[index].avatar.toString(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  '${userList[index].firstName}  ${userList[index].lastName}',
                                  style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 25
                                  ),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                Text(
                                  '${userList[index].email}',
                                  style: const TextStyle(
                                      color: Colors.black38,
                                    fontSize: 20
                                  ),
                                ),
                              ],
                            ),
                          )
                          ));*/
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: const Color(0xFFF0F8FF),
                                contentPadding: const EdgeInsets.all(10),
                                title: const Text(
                                  'User Profile',
                                  style: TextStyle(
                                    fontSize: 35,
                                    letterSpacing: 10,
                                    wordSpacing: 10,
                                    color: Color(0xFF778899),
                                    fontWeight: FontWeight.normal,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10)),
                                  side: BorderSide(
                                    color: Color(0xFFF0F8FF),
                                    width: 2,
                                  ),
                                ),
                                content: Container(
                                  height:
                                  MediaQuery.of(context).size.height,
                                  width: 500,
                                  constraints: const BoxConstraints(
                                    minHeight: 150,
                                    maxHeight: 250,
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF0FFFF),
                                    borderRadius:
                                    BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          userList[index].avatar.toString(),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Text(
                                        '${userList[index].firstName}  ${userList[index].lastName}',
                                        style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 25
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 25,
                                      ),
                                      Text(
                                        '${userList[index].email}',
                                        style: const TextStyle(
                                            color: Colors.black38,
                                            fontSize: 20
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(fontSize: 25),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text(
                                        'Ok',
                                        style: TextStyle(fontSize: 25),
                                      )),
                                ],
                              ));
                        },
                            color: Colors.black38,
                            icon: const Icon(Icons.swap_horiz_rounded),
                          iconSize: 40,
                        ),
                      ),
                    );
                  });
            }
            if (state is UserErrorState) {
              return const Center(
                child: Text("Error"),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
