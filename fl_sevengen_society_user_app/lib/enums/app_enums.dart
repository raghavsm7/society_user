enum ApiStatusParams { status, message, success, error, data }

extension ApiStatusParamsExtension on ApiStatusParams {
  String? get value {
    switch (this) {
      case ApiStatusParams.success:
        return "Success";
      case ApiStatusParams.status:
        return "status_code";
      case ApiStatusParams.message:
        return "message";
      case ApiStatusParams.data:
        return "data";
      default:
        return null;
    }
  }
}

enum UserTypeEnums { customer, vendor, both }

extension UserTypeEnumsExtension on UserTypeEnums {
  String? get value {
    switch (this) {
      case UserTypeEnums.customer:
        return "1";
      case UserTypeEnums.vendor:
        return "2";
      case UserTypeEnums.both:
        return "3";
    }
  }
}

enum VendorAvailabilityEnum { online, offline }

extension VendorAvailabilityEnumExtension on VendorAvailabilityEnum {
  int? get value {
    switch (this) {
      case VendorAvailabilityEnum.online:
        return 1;
      case VendorAvailabilityEnum.offline:
        return 0;
    }
  }
}

enum EarningFilterEnum{week,months,threeMonth,custom}

extension EarningFilterExtension on EarningFilterEnum {
  int? get value {
    switch (this) {
      case EarningFilterEnum.week:
        return 0;
      case EarningFilterEnum.months:
        return 1;
      case EarningFilterEnum.threeMonth:
        return 2;
      case EarningFilterEnum.custom:
        return 3;
    }
  }
}


enum VendorDocStatusEnum { pending, approved, rejected, noAction }

extension VendorDocStatusEnumExtension on VendorDocStatusEnum {
  int? get value {
    switch (this) {
      case VendorDocStatusEnum.pending:
        return 0;
      case VendorDocStatusEnum.approved:
        return 1;
      case VendorDocStatusEnum.rejected:
        return 2;
      case VendorDocStatusEnum.noAction:
        return 3;
    }
  }
}

enum WorkingRightsEnum {
  australianCitizen,
  permanentResident,
  studentVisa,
  workingHolidayVisa
}

extension WorkingRightsEnumExtension on WorkingRightsEnum {
  int? get value {
    switch (this) {
      case WorkingRightsEnum.australianCitizen:
        return 0;
      case WorkingRightsEnum.permanentResident:
        return 1;
      case WorkingRightsEnum.studentVisa:
        return 2;
      case WorkingRightsEnum.workingHolidayVisa:
        return 3;
    }
  }
}

enum HowDidYouHearEnum { bubbler, worldOfMouth, socialMedia, other }

extension HowDidYouHearEnumExtension on HowDidYouHearEnum {
  int? get value {
    switch (this) {
      case HowDidYouHearEnum.bubbler:
        return 0;
      case HowDidYouHearEnum.worldOfMouth:
        return 1;
      case HowDidYouHearEnum.socialMedia:
        return 2;
      case HowDidYouHearEnum.other:
        return 3;
    }
  }
}

enum OTPNavigationEnums {
  fromEnterMobile,
  fromVerifyOTP,
}

extension OTPNavigationEnumsExtension on OTPNavigationEnums {
  String get value {
    switch (this) {
      case OTPNavigationEnums.fromEnterMobile:
        return "1";
      case OTPNavigationEnums.fromVerifyOTP:
        return "0";
      default:
        return "1";
    }
  }
}

enum AppMode { production, staging, test }

enum VendorAvailabilityStatus { online, offline }

extension VendorAvailabilityStatusExtension on VendorAvailabilityStatus {
  String? get value {
    switch (this) {
      case VendorAvailabilityStatus.online:
        return "ONLINE";
      case VendorAvailabilityStatus.offline:
        return "OFFLINE";
      default:
        return null;
    }
  }
}

enum CheckUserEnum { email, phoneNumber }

extension CheckUserEnumExtension on CheckUserEnum {
  String? get value {
    switch (this) {
      case CheckUserEnum.email:
        return "2";
      case CheckUserEnum.phoneNumber:
        return "1";
    }
  }
}

enum SocialLoginEnum { google, facebook, apple, none }

enum BlockEnum {
  vendorBlocked,
  vendorUnBlocked,
}

extension BlockEnumExtension on BlockEnum {
  int get value {
    switch (this) {
      case BlockEnum.vendorBlocked:
        return 1;
      case BlockEnum.vendorUnBlocked:
        return 0;
    }
  }
}

enum LoginWithPhoneOrEmail { email, phone }

enum Timer {
  sec,
}

extension TimerExtention on Timer {
  int? get value {
    switch (this) {
      case Timer.sec:
        return 2;
      default:
        return null;
    }
  }
}

enum VerifyOtpFromEnum { email, phoneNumber }

extension VerifyOtpFromExtension on VerifyOtpFromEnum {
  int? get value {
    switch (this) {
      case VerifyOtpFromEnum.email:
        return 1;
      case VerifyOtpFromEnum.phoneNumber:
        return 2;
      default:
        return null;
    }
  }
}

enum VendorOrderListingEnum { current, requests }

extension VendorOrderListingEnumExtension on VendorOrderListingEnum {
  int? get value {
    switch (this) {
      case VendorOrderListingEnum.current:
        return 1;
      case VendorOrderListingEnum.requests:
        return 2;
      default:
        return null;
    }
  }
}

enum StorageUtilsEnum {
  userData,
  fcmToken,
  currentLocation,
  serviceData,
  docData,
  Intro
}

extension StorageUtilsEnumExtension on StorageUtilsEnum {
  String get value {
    switch (this) {
      case StorageUtilsEnum.userData:
        return "user_data";
      case StorageUtilsEnum.fcmToken:
        return "fcm_token";
      case StorageUtilsEnum.currentLocation:
        return "current_location";
      case StorageUtilsEnum.serviceData:
        return "service_data";
      case StorageUtilsEnum.docData:
        return "doc_data";
      case StorageUtilsEnum.Intro:
        return "intro";
    }
  }
}

enum SelectionEnum { selected, unselected }

extension SelectionExtension on SelectionEnum {
  int get value {
    switch (this) {
      case SelectionEnum.selected:
        return 1;
      case SelectionEnum.unselected:
        return 0;
    }
  }
}

enum EditProfileType { email, phoneNumber }

enum PlatformTypeEnum { app }

extension PlatformTypeEnumExtension on PlatformTypeEnum {
  int get value {
    switch (this) {
      case PlatformTypeEnum.app:
        return 1;
    }
  }
}

enum UserVerificationEnum { verified, unverified }

extension UserVerificationEnumExtension on UserVerificationEnum {
  String get value {
    switch (this) {
      case UserVerificationEnum.verified:
        return "1";
      case UserVerificationEnum.unverified:
        return "0";
    }
  }
}

enum GenderSelectionEnum { none, male, female, other }

extension GenderSelectionEnumExtension on GenderSelectionEnum {
  int get value {
    switch (this) {
      case GenderSelectionEnum.none:
        return -1;
      case GenderSelectionEnum.male:
        return 1;
      case GenderSelectionEnum.female:
        return 2;
      case GenderSelectionEnum.other:
        return 3;
    }
  }
}

enum VendorDocumentNeededEnum {
  age,
  rightToWork,
  IDProof,
  equipment,
  smartphone
}
enum ApiStatus { success, failure, updated, noChange, updateRequired, notFound }

extension ApiStatusExtension on ApiStatus {
  int get value {
    switch (this) {
      case ApiStatus.success:
        return 200;
      case ApiStatus.failure:
        return 0;
      case ApiStatus.updated:
        return 1;
      case ApiStatus.noChange:
        return 0;
      case ApiStatus.updateRequired:
        return 403;
      case ApiStatus.notFound:
        return 404;
    }
  }
}

enum OrderListEnum { current, request, completed }

extension OrderListEnumExtension on OrderListEnum {
  int get value {
    switch (this) {
      case OrderListEnum.current:
        return 2;
      case OrderListEnum.request:
        return 1;
      case OrderListEnum.completed:
        return 3;
    }
  }
}

enum ImageSelectionEnum { camera, gallery, remove }

extension VendorDocumentNeededEnumExtension on VendorDocumentNeededEnum {
  int get value {
    switch (this) {
      case VendorDocumentNeededEnum.age:
        return 0;
      case VendorDocumentNeededEnum.rightToWork:
        return 1;
      case VendorDocumentNeededEnum.IDProof:
        return 2;
      case VendorDocumentNeededEnum.equipment:
        return 3;
      case VendorDocumentNeededEnum.smartphone:
        return 4;

      /* case VendorDocumentNeededEnum.rightToWork:
        return "Have the right to work in australia";
      case VendorDocumentNeededEnum.IDProof:
        return "Proof of ID(driver's licence,passport)";
      case VendorDocumentNeededEnum.equipment:
        return "Equipment(eg.washing machine,iron,carry bag)";
      case VendorDocumentNeededEnum.smartphone:
        return "Smartphone with iOS 12/ Android 6.0 or above";*/
    }
  }
}

enum SettingsMenuEnums {
  editProfile,
  notifications,
  savedAddresses,
  offers,
  jobHistory,
  shareProfile,
  referrals,
  howItWorks,
  helpAndSupport,
  termsAndServices
}

enum InfoNavigationEnum {
  termsServices,
  privacyPolicy,
  howItWorks,
}

extension InfoNavigationEnumExtension on InfoNavigationEnum {
  int get value {
    switch (this) {
      case InfoNavigationEnum.termsServices:
        return 1;
      case InfoNavigationEnum.privacyPolicy:
        return 0;
      case InfoNavigationEnum.howItWorks:
        return 2;
    }
  }
}

enum NotificationSettingEnum {
  orderEmail,
  orderPushNotifications,
  orderTextMessages,
  promotionsEmail,
  promotionsPushNotifications,
  promotionsTextMessages,
}

enum OrderStatusUserEnum {
  orderPlaced,
  vendorAssigned,
  orderCanceled,
  vendorOnTheWay,
  vendorReached,
  confirmChanges,
  orderInProgress,
  vendorReturningOrder,
  orderCompleted,
  none,
}

enum VendorOrderStatusEnum {
  orderPlaced,
  vendorAssigned,
  vendorOnTheWay,
  vendorReached,
  orderInProgress,
  orderCompleted,
  orderCancelled,
  orderRejectedByVendor,
  autoCancelled
}

enum OrderStatusEnum {
  orderPlaced,
  vendorAssigned,
  autoCanceled,
  canceledByCustomer,
  canceledByVendor,
  vendorOnTheWay,
  vendorReached,
  vendorChangedOrder,
  customerApprovedChanges,
  customerRejectChanges,
  vendorConfirmChanges,
  orderInProgress,
  vendorReturningOrder,
  vendorFinishOrder,
  none
}

extension OrderStatusEnumExtension on OrderStatusEnum {
  int get value {
    switch (this) {
      case OrderStatusEnum.orderPlaced:
        return 0;
      case OrderStatusEnum.vendorAssigned:
        return 1;
      case OrderStatusEnum.autoCanceled:
        return 8;
      case OrderStatusEnum.canceledByCustomer:
        return 6;
      case OrderStatusEnum.canceledByVendor:
        return 7;
      case OrderStatusEnum.vendorOnTheWay:
        return 2;
      case OrderStatusEnum.vendorReached:
        return 3;
      /*   case OrderStatusEnum.vendorChangedOrder:
        return "VENDOR_CHANGED_ORDER";*/
      /* case OrderStatusEnum.customerApprovedChanges:
        return "CUSTOMER_APPROVED_CHANGES";*/
      /*    case OrderStatusEnum.customerRejectChanges:
        return "CUSTOMER_REJECT_CHANGES";*/
      /*case OrderStatusEnum.vendorConfirmChanges:
        return "VENDOR_CONFIRMED_ORDER";*/
      case OrderStatusEnum.orderInProgress:
        return 4;
      /*  case OrderStatusEnum.vendorReturningOrder:
        return "VENDOR_RETURNING_ORDER";*/
      case OrderStatusEnum.vendorFinishOrder:
        return 5;

      case OrderStatusEnum.vendorChangedOrder:
        return 11;
      /*case OrderStatusEnum.none:
        return "NONE";*/
      default:
        return 10;
    }
  }
}


enum PostListingEnums {
  adminPost,
  userPost,
}

extension PostListingEnumsExtension on PostListingEnums {
  int get value {
    switch (this) {
      case PostListingEnums.adminPost:
        return 0;
      case PostListingEnums.userPost:
        return 1;
    }
  }
}

enum NotificationStatusEnums {
  userBlocked,
  userUnBlocked,
  orderPlaced,
  vendorAssigned,
  orderCanceled,
  vendorOnTheWay,
  vendorReached,
  vendorChangedOrder,
  customerApprovedChanges,
  orderInProgress,
  vendorReturningOrder,
  vendorFinishedOrder,
  canceledByVendor,
  autoCanceled,
  vendorConformedOrder,
  canceledByCustomer,
  chat,
  promotions,
  vendorBlocked,
  vendorUnBlocked
}

extension NotificationStatusExtension on NotificationStatusEnums {
  String get value {
    switch (this) {
      case NotificationStatusEnums.userBlocked:
        return "30";
      case NotificationStatusEnums.userUnBlocked:
        return "31";
      case NotificationStatusEnums.orderPlaced:
        return "0";
      case NotificationStatusEnums.vendorAssigned:
        return "1";
      case NotificationStatusEnums.vendorOnTheWay:
        return "2";
      case NotificationStatusEnums.vendorReached:
        return "3";
      case NotificationStatusEnums.orderInProgress:
        return "4";
      case NotificationStatusEnums.vendorFinishedOrder:
        return "5";
      case NotificationStatusEnums.orderCanceled:
        return "6";
      case NotificationStatusEnums.canceledByVendor:
        return "7";
      case NotificationStatusEnums.autoCanceled:
        return "8";
      case NotificationStatusEnums.vendorConformedOrder:
        return "9";
      case NotificationStatusEnums.canceledByCustomer:
        return "10";
      case NotificationStatusEnums.vendorChangedOrder:
        return "11";
      case NotificationStatusEnums.customerApprovedChanges:
        return "13";
      case NotificationStatusEnums.vendorReturningOrder:
        return "12";
      case NotificationStatusEnums.chat:
        return "88";
      case NotificationStatusEnums.promotions:
        return "55";
      case NotificationStatusEnums.vendorBlocked:
        return "32";
      case NotificationStatusEnums.vendorUnBlocked:
        return "33";
    }
  }
}

/*extension OrderStatusEnumExtension on OrderStatusEnum {
  String get value {
    switch (this) {
      case OrderStatusEnum.orderPlaced:
        return "ORDER_PLACED";
      case OrderStatusEnum.vendorAssigned:
        return "VENDOR_ASSIGNED";
      case OrderStatusEnum.autoCanceled:
        return "AUTO_CANCELED";
      case OrderStatusEnum.canceledByCustomer:
        return "CANCELED_BY_CUSTOMER";
      case OrderStatusEnum.canceledByVendor:
        return "CANCELED_BY_VENDOR";
      case OrderStatusEnum.vendorOnTheWay:
        return "VENDOR_ON_THE_WAY";
      case OrderStatusEnum.vendorReached:
        return "VENDOR_REACHED";
      case OrderStatusEnum.vendorChangedOrder:
        return "VENDOR_CHANGED_ORDER";
      case OrderStatusEnum.customerApprovedChanges:
        return "CUSTOMER_APPROVED_CHANGES";
      case OrderStatusEnum.customerRejectChanges:
        return "CUSTOMER_REJECT_CHANGES";
      case OrderStatusEnum.vendorConfirmChanges:
        return "VENDOR_CONFIRMED_ORDER";
      case OrderStatusEnum.orderInProgress:
        return "ORDER_IN_PROGRESS";
      case OrderStatusEnum.vendorReturningOrder:
        return "VENDOR_RETURNING_ORDER";
      case OrderStatusEnum.vendorFinishOrder:
        return "VENDOR_FINISH_ORDER";
      case OrderStatusEnum.none:
        return "NONE";
    }
  }
}*/
