import 'package:flutter/material.dart';
import 'package:chat_app/profile/cubit/profile_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController nameeditcontroller = TextEditingController();
  TextEditingController phonennoditcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget bottomsheet() {
    return Container(
      height: 100,
      width: 50,
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          const Text(
            "Choose Profile Photo",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton.icon(
                onPressed: () {
                  context.read<ProfileCubit>().editPhoto(ImageSource.camera);
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text("Camera"),
              ),
              TextButton.icon(
                onPressed: () {
                  context.read<ProfileCubit>().editPhoto(ImageSource.gallery);
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text("Gallery"),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
        buildWhen: (previous, next) =>
            previous.userState != next.userState ||
            previous.userState.model != null,
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                elevation: 1,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.green.shade900,
                  ),
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => const HomePage()),
                    // );
                  },
                ),
                actions: [
                  IconButton(
                    onPressed: () => context.read<ProfileCubit>().editProfile(),
                    icon: const Icon(Icons.settings_applications),
                    iconSize: 35.0,
                  ),
                ],
              ),
              body: Container(
                padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Center(
                        child: Stack(
                          children: <Widget>[
                            const CircleAvatar(
                                // radius: 100.0,
                                // backgroundImage: _imageFile == null
                                //     ? const AssetImage('images/Edit.png')
                                //         as ImageProvider
                                //     : FileImage(File(_imageFile!.path)),
                                //image: DecorationImage( image: true ? NetworkImage('someNetWorkLocation.com') : AssetImage('assets/images/noImageAvailable.png') as ImageProvider ),
                                ),
                            Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.grey,
                                    ),
                                    color: Colors.green.shade900,
                                  ),
                                  child: IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                            context: context,
                                            builder: ((builder) =>
                                                bottomsheet()));
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      )),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Name',
                            style: TextStyle(
                              color: Colors.green.shade900,
                              fontSize: 19.0,
                            ),
                          ),
                          const SizedBox(
                            height: 13.0,
                          ),
                          Container(
                            color: Colors.black12,
                            alignment: Alignment.centerLeft,
                            height: 60.0,
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              controller: nameeditcontroller,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.account_box_rounded,
                                  color: Colors.black,
                                ),
                                // icon: IconButton(
                                //   icon: Icons.edit,
                                //   onPressed: () => nameeditcontroller.clear(),
                                // ),
                                hintText: "",
                              ),
                              maxLength: 50,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 13.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Mobile Number',
                            style: TextStyle(
                              color: Colors.green.shade900,
                              fontSize: 19.0,
                            ),
                          ),
                          const SizedBox(
                            height: 13.0,
                          ),
                          Container(
                            color: Colors.black12,
                            alignment: Alignment.centerLeft,
                            height: 60.0,
                            child: TextFormField(
                              keyboardType: TextInputType.name,
                              controller: phonennoditcontroller,
                              style: const TextStyle(color: Colors.black),
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14.0),
                                prefixIcon: Icon(
                                  Icons.logout,
                                  color: Colors.black,
                                ),
                                hintText: "",
                              ),
                              maxLength: 50,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlineButton(
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const HomePage()),
                              // );
                            },
                            child: const Text(
                              "CANCEL",
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2.2,
                                  color: Colors.black),
                            ),
                          ),
                          RaisedButton(
                            onPressed: () async {
                              final snackBar = const SnackBar(
                                content: Text('Profile Edited'),
                                duration: const Duration(seconds: 10),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);

                              // final snackBar = const SnackBar(
                              //   content: const Text(
                              //       'Enter Valid Name and Phone Details'),
                              //   duration: const Duration(seconds: 5),
                              // );
                              // ScaffoldMessenger.of(context)
                              //     .showSnackBar(snackBar);
                            },
                            color: Colors.green.shade900,
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: const Text(
                              "SAVE",
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 2.2,
                                  color: Colors.white),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ));
        });
  }
}
