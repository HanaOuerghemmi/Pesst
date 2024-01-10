import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pesst/features/auth/controller/auth_controller.dart';
import 'package:pesst/features/auth/screens/home_auh_screen.dart';
import 'package:pesst/features/home/screen/home_application_screen.dart';
import 'package:pesst/firebase_options.dart';
import 'package:pesst/routes/router.dart';
import 'package:pesst/utils/colors.dart';
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        scaffoldBackgroundColor: whiteColor,
        appBarTheme: AppBarTheme(
          backgroundColor: whiteColor,
        ),
        
        colorScheme: ColorScheme.fromSeed(seedColor: lightColor),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: //const HomeAuthScreen(),
          //! +++ we can use  Future BUilder and handle all case of State Connecction
          
         // ref.watch(userDataProvider).when(
          ref.watch(userDataStreamProvider).when(
                data: (user) {
                  if (user == null) {
                    return const HomeAuthScreen();
                  }
                  // user;
                  print(user.uid);
                  return HomeApplicationScreen(
                    userModel: user,
                  );
                },
                error: (err, trace) {
                  return ErrorScreen(
                    error: err.toString(),
                  );
                },
                loading: () => const Loader(),
              ),
    );
  }
}

class Loader extends StatelessWidget {
  const Loader();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class ErrorScreen extends StatelessWidget {
  final String error;

  const ErrorScreen({super.key, required this.error});
  @override
  Widget build(Object context) {
    return Scaffold(
      body: Center(
        child: Text(error),
      ),
    );
  }
}