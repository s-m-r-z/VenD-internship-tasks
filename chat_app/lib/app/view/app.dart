import 'package:authentication_repository/authentication_repository.dart';
import 'package:chat_app/app/app.dart';
import 'package:chat_app/chat/cubit/chat_cubit.dart';
import 'package:chat_app/chat/repository/chat_repository.dart';
import 'package:chat_app/theme.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;

  @override
  // create: (_) => AppBloc(
  // authenticationRepository: _authenticationRepository,
  // ),
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (_) =>
                  AppBloc(authenticationRepository: _authenticationRepository)),
          BlocProvider(create: (_) => ChatCubit(repository: ChatRepository())),
        ],
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: FlowBuilder<AppStatus>(
        state: context.select((AppBloc bloc) => bloc.state.status),
        onGeneratePages: onGenerateAppViewPages,
      ),
    );
  }
}
