class AppUrls {
  // static const String baseUrl =
  //     "https://rebaturtechnologies.com/panigraha/public/api";
  // static const String baseUrlImage =
  //     "https://rebaturtechnologies.com/panigraha";

  static const String baseUrl = "https://paanigraha.ebsgl.com/api";
  // static const String baseUrlImage =
  //     "https://rebaturtechnologies.com/panigraha";
  static const String profilepicture =
      "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png";

  /// register
  /// get religion
  static const String getReligionurl = "$baseUrl/religions";
  static const String getCasteUrl = "/caste";
  static const String getCountryUrl = "$baseUrl/country";
  static const String getStateUrl = "/state";
  static const String getDistrictUrl = "/district";
  static const String getEducationUrl = "$baseUrl/education";
  static const String getOccupationUrl = "$baseUrl/occupation";
  static const String getInterestUrl = "$baseUrl/interest";
  static const String getMovieUrl = "$baseUrl/movie";
  static const String getMusicUrl = "$baseUrl/music";
  static const String getFoodUrl = "$baseUrl/food";
  static const String getPlaceUrl = "$baseUrl/places";
  static const String getSportUrl = "$baseUrl/sports";
  static const String getBookUrl = "$baseUrl/book";
  static const String getHeightUrl = "$baseUrl/height";
  static const String getBirthStarUrl = "$baseUrl/birthstar";


  /// register
  static const String registerUrl = "$baseUrl/register";

  static const String generateOtpWithPhoneUrl =
      "$baseUrl/generateAndSendOTP_phone";
  static const String generateOtpWithEmailUrl =
      "$baseUrl/generateAndSendOTP_email";

  /// login

  static const String loginPhoneOtpUrl = "$baseUrl/login_phone";
  static const String loginPhonePasswordUrl = "$baseUrl/login_phone_password";
  static const String loginEmailOtpUrl = "$baseUrl/login_email";
  static const String loginEmailPasswordUrl = "$baseUrl/login_email_password";
  static const String otpUrl = "$baseUrl/generate_otp";
  static const String forgotPassword = "$baseUrl/updatePassword";
  static const String checkEmail = "$baseUrl/checkemail";
  static const String checkPhone = "$baseUrl/checkphone";
  static const String verifyOtpUrl = "$baseUrl/otp_checking";

  /// notification
  static getNotificationExistOrNotUrl({required String userId}) =>
      "$baseUrl/$userId/notification_exist_checking";
  static getUnreadNotificationUrl({required String userId}) =>
      "$baseUrl/$userId/getUnreadNotifications";
  static getReadNotificationUrl({required String userId}) =>
      "$baseUrl/$userId/getreadNotifications";
  static const String markAsReadNotificationUrl =
      "$baseUrl/notification_markAsRead";

  /// edit profile
  static const String editBasicProfile = "$baseUrl/edit_basicdetail";
  static const String editLocationUrl = "$baseUrl/edit_location";
  static const String editHobbiesUrl = "$baseUrl/edit_hobbies";
  static const String editProfessionalUrl = "$baseUrl/edit_professionaldetail";
  static const String editFamilyUrl = "$baseUrl/edit_familydetail";
  static const String editAboutYourSelfUrl = "$baseUrl/edit_about";
  static const String editContactUrl = "$baseUrl/edit_contactdetail";

  /// home
  /// profile
  static getProfileUrl(
          {required String userId, required String viewedUserId}) =>
      "$baseUrl/$userId/profile?viewer_id=$viewedUserId";
  static getProfileImageUrl({required String userId}) =>
      "$baseUrl/$userId/user_photos";
  static getProfilePercentageUrl({required String userId}) =>
      "$baseUrl/$userId/profile_percentage";
  static getHobbiesUrl({required String userId}) =>
      "$baseUrl/$userId/hobbies_intrest";
  static String updateProfileUrl = "$baseUrl/photo_edit";

  static String latestRecommendationsUrl = "$baseUrl/recomended_matches";
  static String premiumMembersUrl = "$baseUrl/premium_members";
  static String allMatchesUrl = "$baseUrl/get_matches";
  static String mutualMatchUrl = "$baseUrl/mutual_matches";
  static String getAdsUrl = "$baseUrl/adds_listing";
  static String getHappyStoriesUrl = "$baseUrl/happy_stories";
  static String getNews = "$baseUrl/news";
  static String getBanners = "$baseUrl/get_banner";

  /// home
  /// photo upload
  static String uploadPhotoUrl = "$baseUrl/uploadPhotos";

  /// upgrade
  static String getPlansUrl = "$baseUrl/plans";
  static String planByCategory = "$baseUrl/get_plan_bycategory";
  static String createOrderId = "$baseUrl/createOrder";
  static String createOrderSubscription = "$baseUrl/verifyPayment";

  /// verify with id
  static String verifyIdUrl = "$baseUrl/verify_idproof";

  /// matches
  static String getNewlyJoinedUsersUrl = "$baseUrl/new_users";
  static getShortlistedByYouUrl({required String userId}) =>
      "$baseUrl/$userId/shortlist_byyou";
  static getShortlistedYouUrl({required String userId}) =>
      "$baseUrl/$userId/shortlist_you";
  static String viewedByYouMatchUrl = "$baseUrl/viewed-profiles";
  static String viewedYouMatchUrl = "$baseUrl/profile-visitors";
  static String getNearByMatchesUrl = "$baseUrl/nearby_matches";
  static getSendInterestUrl({required String userId}) =>
      "$baseUrl/$userId/sendintrest_byyou";
  static String acceptedUrl = "$baseUrl/accept_intrest";
  static String rejectinterest = "$baseUrl/reject_intrest";

  static getrecievedInterestUrl({required String userId}) =>
      "$baseUrl/$userId/receive_intrest";
  static getAcceptedInterestUrl({required String userId}) =>
      "$baseUrl/$userId/accepted_intrest";
  static getSavedYouUrl({required String userId}) =>
      "$baseUrl/$userId/saved_you";

  /// profile
  /// customer support
  static String customerSupportUrl = "$baseUrl/store_support";
  static String deleteAccountUrl = "$baseUrl/delete_account";

  /// edit phone number
  static String editPhoneNumber = "$baseUrl/edit_phone";
  static String editEmail = "$baseUrl/edit_email";
  static String otpeditUrl = "$baseUrl/generate_phoneotp";

  /// single profile
  // create short list
  static String createShortList = "$baseUrl/store";
  // remove short list
  static String deleteShortList = "$baseUrl/destroy_from_shortlist";
  // checking shortlisted
  static String checkShortlisted = "$baseUrl/shortlist_checking";
  // checking saved profile
  static String checkSavedProfile = "$baseUrl/saved_checking";
  // create saved profile
  static String createSavedProfile = "$baseUrl/save_profile";
  // remove saved profile
  static String deleteSavedSearch = "$baseUrl/destroy_saved";
  // create view profile
  static String createViewProfile = "$baseUrl/storeVisit";
  // checking interest
  static String checkInterest = "$baseUrl/intrest_checking";
  // create interest
  static String createInterest = "$baseUrl/send_intrest";
  // remove interest
  static String deleteInterest = "$baseUrl/remove_intrest";
  // partner preference
  static String createPartnerPreference = "$baseUrl/preferenced_profile";
  // contacted profile
  static String contactedProfile = "$baseUrl/contacted";

  /// search
  /// search by id
  static String searchByIdUrl = "$baseUrl/profile_byid";
  static getSavedSearchByUUrl({required String userId}) =>
      "$baseUrl/$userId/saved_byyou";
  static String searchByCriteriaUrl = "$baseUrl/criteria_search";
  static String searchBySavedNameUrl =
      "$baseUrl/search_byname_from_savedprofile";

  /// preference
  /// get preference
  static getPartnerPreferenceUrl({required String userId}) =>
      "$baseUrl/$userId/view_preference";
  static String addPartnerPreference = "$baseUrl/store_preference";
  static String editPartnerPreference = "$baseUrl/update_preference";
}
