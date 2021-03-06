import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:chat_app/app/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

import 'firebase_options.dart';

Future<void> main() {
  return BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      final authenticationRepository = AuthenticationRepository();
      await authenticationRepository.user.first;
      runApp(
        App(authenticationRepository: authenticationRepository),
      );
    },
    blocObserver: AppBlocObserver(),
  );
}
