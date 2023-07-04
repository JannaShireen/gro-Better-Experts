import 'package:expert_app/home/home_screen.dart';
import 'package:expert_app/provider/bottom_navigation_bar_provider.dart';
import 'package:expert_app/provider/expert_provider.dart';
import 'package:expert_app/provider/register_user.dart';
import 'package:expert_app/screens/widgets/wrapper.dart';
import 'package:expert_app/services/auth.dart';
import 'package:expert_app/shared/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:expert_app/model/user_model.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<UserModel?>.value(
            value: AuthService().userlog, initialData: null),
        ChangeNotifierProvider<RegisterUserState>(
            create: (context) => RegisterUserState()),
        ChangeNotifierProvider(create: (context) => BottomState()),
        ChangeNotifierProvider(create: (context) => ExpertProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gro Better Experts',
        initialRoute: '/',
        routes: {
          '/': (context) => const Wrapper(),
          '/home': (context) => const HomeScreen(),
        },
        theme: ThemeData(
          scaffoldBackgroundColor: kBackgroundColor,
          primaryColor: kPrimaryColor,
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: kTextColor,
                fontFamily: GoogleFonts.robotoCondensed().fontFamily,
              ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //  home: const Wrapper(),
      ),
    );
  }
}
