// ignore_for_file: file_names
class ApiConst {
  // ignore: non_constant_identifier_names
  static String BASEURL = "https://devfinder.xyz/";
  static String getAccessToken = "api/token/";
  static String refreshAccessToken = "api/token/refresh/";
  static String verifyAuthentication =
      "user-api/profiles/c48554e6-f19b-4fb5-900c-2afe6573323f/";
  static String getCurrentUser = "user-api/current-user/";
  static String getAllProfiles = "user-api/profiles/";
  static String getAllProjects = "project-api/projects/";
  static String createSkill = "user-api/profiles/<str:pk>/skills/create/";
  static String getCurrentUserProjects = "user-api/profiles/<str:pk>/projects/";
}
