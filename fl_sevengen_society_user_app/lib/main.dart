import 'dart:io';
import 'package:fl_sevengen_society_user_app/common/binding/app_binding.dart';
import 'package:fl_sevengen_society_user_app/localization/localization.dart';
import 'package:fl_sevengen_society_user_app/route/app_pages.dart';
import 'package:fl_sevengen_society_user_app/route/app_routes.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/controller/auth_controller.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:fl_sevengen_society_user_app/utils/app_utils.dart';
import 'package:fl_sevengen_society_user_app/utils/notification_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'localization/localization_const.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  /* SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: colorPrimary,
    statusBarBrightness: Brightness.light,
  ));*/

  // await dotenv.load(fileName: "assets/.env");
  await GetStorage.init();
  await GetStorage.init("PermanentStorage");
  await Get.putAsync<AuthController>(() async => AuthController(),
      permanent: true);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  NotificationUtils.notificationUtilsInstance
      .showBackGroundNotification(message);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(locale);
  }

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AppUtils.appUtilsInstance.getDeviceID();
    NotificationUtils.notificationUtilsInstance.initFirebase();
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    getIntLanguageValue();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return GetMaterialApp(
      title: 'Gate Bro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          primary: primaryColor,
        ),
        primaryColor: primaryColor,
        scaffoldBackgroundColor: whiteColor,
        fontFamily: 'Inter',
      ),
      //home:Routes.splash,
      initialRoute: Routes.initial,
      initialBinding: AppBinding(),
      locale: _locale,
      getPages: AppPages.pages,
      supportedLocales: const [
        Locale('en'),
        Locale('hi'),
        Locale('id'),
        Locale('zh'),
        Locale('ar'),
      ],
      localizationsDelegates: [
        DemoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      localeResolutionCallback: (deviceLocale, supportedLocale) {
        for (var locale in supportedLocale) {
          if (locale.languageCode != deviceLocale?.languageCode) {
            return deviceLocale;
          }
        }
        return supportedLocale.first;
      },
    );
  }

/* Route<dynamic>? routes(settings) {
    switch (settings.name) {
      case '/':
        return PageTransition(
          child: const SplashScreen(),
          type: PageTransitionType.fade,
          settings: settings,
        );
      case '/onboarding':
        return PageTransition(
          child: const OnboardingScreen(),
          type: PageTransitionType.fade,
          settings: settings,
        );
      case '/login':
        return PageTransition(
          child: EnterMobileNumberPage(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/register':
        return PageTransition(
          child: const RegisterScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/otp':
        return PageTransition(
          child: const OTPScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/bottomBar':
        return PageTransition(
          child: const BottomBar(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/home':
        return PageTransition(
          child: const HomeScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/members':
        return PageTransition(
          child: const MembersScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/call':
        return PageTransition(
          child: const CallScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/message':
        return PageTransition(
          child: const MessageScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/visitors':
        return PageTransition(
          child: const VisitorsScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/preApproveVisitors':
        return PageTransition(
          child: const PreApproveVisitorsScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/noticeBoard':
        return PageTransition(
          child: const NoticeBoardScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/payment':
        return PageTransition(
          child: const PaymentScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/success':
        return PageTransition(
          child: const SuccessScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/paymentMethods':
        return PageTransition(
          child: const PaymemtMethodScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/creditCard':
        return PageTransition(
          child: const CreditCardScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/bookAmenities':
        return PageTransition(
          child: const BookedAmenitiesScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/selectAmenities':
        return PageTransition(
          child: const SelectAmenitiesScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/bookAmenitiesProceed':
        return PageTransition(
          child: const BookAmenitiesProceedScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/helpDesk':
        return PageTransition(
          child: const HelpDeskScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/complaintDetail':
        return PageTransition(
          child: const ComplaintDetailScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/addComplaint':
        return PageTransition(
          child: const AddComplaintScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/notification':
        return PageTransition(
          child: const NotificationScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/calling':
        return PageTransition(
          child: const CallingScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/chats':
        return PageTransition(
          child: const ChatsScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/search':
        return PageTransition(
          child: const SearchScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/service':
        return PageTransition(
          child: const ServiceScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/profile':
        return PageTransition(
          child: const ProfileScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/settings':
        return PageTransition(
          child: const SettingsScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/editProfile':
        return PageTransition(
          child: const EditProfileScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/language':
        return PageTransition(
          child: const LanguageScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/getSupport':
        return PageTransition(
          child: const GetSupportScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/termsAndCondition':
        return PageTransition(
          child: const TermsAndConditionScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      case '/privacyPolicy':
        return PageTransition(
          child: const PrivacyPolicyScreen(),
          type: PageTransitionType.rightToLeft,
          settings: settings,
        );
      default:
        return null;
    }
  }*/
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
