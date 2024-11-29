import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_sevengen_society_user_app/common/data/model/common_response_model.dart';
import 'package:fl_sevengen_society_user_app/enums/app_enums.dart';
import 'package:fl_sevengen_society_user_app/screens/post_listing/data/model/post_listing_response_model.dart';
import 'package:fl_sevengen_society_user_app/screens/post_listing/data/provider/post_listing_provider.dart';
import 'package:fl_sevengen_society_user_app/utils/app_utils.dart';
import 'package:fl_sevengen_society_user_app/utils/network_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import '../../../controller/base_controller.dart';

class PostListingController extends BaseController
    with GetSingleTickerProviderStateMixin {
  late List<Widget> tabsList;
  late TabController tabController;
  int _currentIndex = 0;

  // Selected tab
  late PostListingEnums selectedTab;

  // Page
  int adminPostPage = 1;

  // int userPostPage = 1;

  bool noAdminPostFound = false;

//  bool noUserPostFound = false;

  // Scroll controller
  ScrollController adminPostScrollController = ScrollController();

  //ScrollController userPostScrollController = ScrollController();

  bool noVerifiedUserFound = false;
  bool noUnverifiedUserFound = false;
  late PostListingProvider _provider;
  PostResponseModelData? adminPostListingResponseModel;

//  PostListingReponseModel? userPostListingResponseModel;

  @override
  void onInit() {
    super.onInit();
    _provider = Get.find<PostListingProvider>();
    tabsList = <Widget>[
      const Tab(text: 'Verified User'),
      const Tab(text: 'Unverified User'),
    ];
    tabController = TabController(vsync: this, length: tabsList.length);
    tabController.addListener(_handleTabSelection);
    adminPostScrollController.addListener(_addAdminPostScrollListener);
    // userPostScrollController.addListener(_addUserPostScrollListener);
    callAdminPostListingAPI();
    setInitialTab();
  }

  // Scroll Listener
  _addAdminPostScrollListener() {
    if (adminPostScrollController.offset >=
            adminPostScrollController.position.maxScrollExtent &&
        !adminPostScrollController.position.outOfRange &&
        loading == false) {
      NetworkUtils.networkUtilsInstance.getConnectivityStatus().then((value) {
        if (value) {
          adminPostPage = adminPostPage + 1;
          callAdminPostListingAPI();
        }
      });
    }
  }

  /*_addUserPostScrollListener() {
    if (userPostScrollController.offset >=
            userPostScrollController.position.maxScrollExtent &&
        !userPostScrollController.position.outOfRange &&
        loading == false) {
      NetworkUtils.networkUtilsInstance.getConnectivityStatus().then((value) {
        if (value) {
          userPostPage = userPostPage + 1;
          callUserPostListingAPI();
        }
      });
    }
  }*/

  @override
  void dispose() {
    super.dispose();
    adminPostScrollController.removeListener(_addAdminPostScrollListener);
    //userPostScrollController.removeListener(_addUserPostScrollListener);
    tabController.dispose();
  }

  void setInitialTab() {
    selectedTab = PostListingEnums.adminPost;
    tabController.index = PostListingEnums.adminPost.value;
    //changeTab(SocietyUserListingEnums.verified.value);
  }

  // on change tab
  changeTab(int index) {
    if (index == PostListingEnums.adminPost.value) {
      selectedTab = PostListingEnums.adminPost;
      noAdminPostFound = true;
      adminPostPage = 1;
      callAdminPostListingAPI();
    }
    /*else if (index == PostListingEnums.userPost.value) {
      selectedTab = PostListingEnums.userPost;
      noUserPostFound = true;
      userPostPage = 1;
      callUserPostListingAPI();
    }*/
    updateLoading();
  }

  _handleTabSelection() {
    if (!tabController.indexIsChanging) {
      _currentIndex = tabController.index;
      print("The index is $_currentIndex");
      changeTab(_currentIndex);
    }
  }

  //method to call admin post listing API
  void callAdminPostListingAPI() {
    print("Admin post API");
    NetworkUtils.networkUtilsInstance
        .getConnectivityStatus(showSnackBar: true)
        .then((value) async {
      if (value) {
        updateLoading(value: true);

        var result = await _provider.callGetPostApi(
            page: adminPostPage, recordPerPage: 10,isAdminNotice: 0);

        if (result is CommonResponseModel) {
          // show error
          if (adminPostPage > 1) {
            adminPostPage = adminPostPage - 1;
          } else {
            adminPostListingResponseModel = null;
            if (result.statusCode == ApiStatus.notFound.value) {
              noAdminPostFound = true;
            } else {
              // some error
              AppUtils.appUtilsInstance.setSnackBarType(
                  isError: true,
                  message: result.message ?? "Something went wrong");
            }
          }
        } else if (result is PostResponseModelData) {
          noAdminPostFound = false;
          PostResponseModelData model = result;
          /*getAdminPostData(_result);*/
          if (adminPostPage > 1) {
            adminPostListingResponseModel?.data?.posts
                ?.addAll(model.data!.posts!);
          } else {
            adminPostListingResponseModel = model;
          }
        }
        updateLoading();
      }
    });
  }

  // void callUserPostListingAPI() {
  //   print("User post API");
  //   NetworkUtils.networkUtilsInstance
  //       .getConnectivityStatus(showSnackBar: true)
  //       .then((value) async {
  //     if (value) {
  //       updateLoading(value: true);
  //       var _result = await _provider.callGetPostApi(
  //           page: userPostPage, recordPerPage: 5);
  //
  //       if (_result is CommonResponseModel) {
  //         // show error
  //         if (userPostPage > 1) {
  //           userPostPage = userPostPage - 1;
  //         } else {
  //           userPostListingResponseModel = null;
  //           if (_result.statusCode == ApiStatus.notFound.value) {
  //             noUserPostFound = true;
  //           } else {
  //             // some error
  //             AppUtils.appUtilsInstance.setSnackBarType(
  //                 isError: true,
  //                 message: _result.message ?? "Something went wrong");
  //           }
  //         }
  //       } else if (_result is PostListingReponseModel) {
  //         noUserPostFound = false;
  //         PostListingReponseModel _model = /*_result*/ getUserPostData(_result);
  //         if (userPostPage > 1) {
  //           userPostListingResponseModel?.data?.posts
  //               ?.addAll(_model.data!.posts!);
  //         } else {
  //           userPostListingResponseModel = _model;
  //         }
  //       }
  //       updateLoading(value: false);
  //     }
  //   });
  // }

/*  PostListingReponseModel getAdminPostData(PostListingReponseModel result) {
    List<PostListingReponseModelDataPosts> userPostData = [];
    PostListingReponseModel postListingResponseModel =
        PostListingReponseModel();
    postListingResponseModel.statusCode = result.statusCode;
    postListingResponseModel.message = result.message;
    postListingResponseModel.data?.currentPage = result.data?.currentPage;
    postListingResponseModel.data?.totalRecords = result.data?.totalRecords;
    postListingResponseModel.data = result.data;

    for (int index = 0; index < result.data!.posts!.length; index++) {
      if (result.data!.posts![index]!.adminNotice == 1) {
        userPostData.add(result.data!.posts![index]!);
      }
    }
    postListingResponseModel.data?.posts = userPostData;
    return postListingResponseModel;
  }

  PostListingReponseModel getUserPostData(PostListingReponseModel result) {
    List<PostListingReponseModelDataPosts> userPostData = [];
    PostListingReponseModel postListingResponseModel =
        PostListingReponseModel();
    postListingResponseModel.statusCode = result.statusCode;
    postListingResponseModel.message = result.message;
    postListingResponseModel.data?.currentPage = result.data?.currentPage;
    postListingResponseModel.data?.totalRecords = result.data?.totalRecords;
    postListingResponseModel.data = result.data;

    for (int index = 0; index < result.data!.posts!.length; index++) {
      if (result.data!.posts![index]!.adminNotice == 0) {
        userPostData.add(result.data!.posts![index]!);
      }
    }
    postListingResponseModel.data?.posts = userPostData;
    return postListingResponseModel;
  }*/

  //call Like or dislike Post API
  void callLikeOrDislikePostApi(int? id, int postType) {
    NetworkUtils.networkUtilsInstance
        .getConnectivityStatus()
        .then((value) async {
      if (value == true) {
        updateLoading(value: true);
        var apiResult = await _provider.callLikeOrDislikePostApi(postId: id);

        if (apiResult is CommonResponseModel) {
          // success
          if (apiResult.statusCode == HttpStatus.ok) {
            updateLoading();

            callAdminPostListingAPI();
            adminPostPage = 1;

            AppUtils.appUtilsInstance.setSnackBarType(
                isError: false,
                message: apiResult.message ?? "Something went wrong");
          } else {
            updateLoading();
            AppUtils.appUtilsInstance.setSnackBarType(
                isError: true,
                message: apiResult.message ?? "Something went wrong");
          }
        } else {
          updateLoading();
          AppUtils.appUtilsInstance
              .setSnackBarType(isError: true, message: "Something went wrong");
        }
      }
    });
  }

  void showFullScreenImage(BuildContext context, String url) {
    Navigator.push(context, MaterialPageRoute(builder: (_) {
      return DetailScreen(url);
    }));
  }
}

class DetailScreen extends StatelessWidget {
  String? imageUrl;

  DetailScreen(String url, {super.key}) {
    imageUrl = url;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: CachedNetworkImage(
              imageUrl: imageUrl ?? "",
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
