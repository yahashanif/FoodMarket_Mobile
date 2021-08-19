part of 'services.dart';

class UserServices {
  static Future<ApiReturnValue<User>> signIn(String email, String password,
      {http.Client? client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseURL + 'login';
    var response = await client.post(Uri.parse(url),
        headers: {'content-Type': 'application/json'},
        body:
            jsonEncode(<String, String>{'email': email, 'password': password}));

    if (response.statusCode != 200) {
      return ApiReturnValue(message: "Wrong Email Or Password");
    }

    var data = jsonDecode(response.body);
    User.token = data['data']['access_token'];
    User value = User.fromJson(data['data']['user']);

    // await Future.delayed(Duration(microseconds: 500));
    return ApiReturnValue(value: value);
    // return ApiReturnValue(message: "Wrong Email or Password");
  }

  static Future<ApiReturnValue<User>> signUp(User user, String password,
      {File? pictureFile, http.Client? client}) async {
    if (client == null) {
      client = http.Client();
    }

    String url = baseURL + 'register';

    var response = await client.post(Uri.parse(url),
        headers: {'content-Type': "application/json"},
        body: jsonEncode(<String, String>{
          'name': user.name!,
          'email': user.email!,
          'password': password,
          'password_confirmation': password,
          'address': user.address!,
          'city': user.city!,
          'houseNumber': user.houseNumber!,
          'phoneNumber': user.phoneNumber!,
        }));

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please try again');
    }

    var data = jsonDecode(response.body);

    User.token = data['data']['access_token'];
    User value = User.fromJson(data['data']['user']);

    if (pictureFile != null) {
      ApiReturnValue<String> result = await uploadProfilePicture(pictureFile);
      if (result.value != null) {
        value = value.copyWith(
            picturePath:
                "http://ikhwanulmuslimin.com/laravel_foodMarket/storage/app/public/" +
                    result.value!);
      }
    }

    return ApiReturnValue(value: value);
  }

  static Future<ApiReturnValue<String>> uploadProfilePicture(File pictureFile,
      {http.MultipartRequest? request}) async {
    String url = baseURL + 'user/photo';
    var uri = Uri.parse(url);

    if (request == null) {
      request = http.MultipartRequest('POST', uri)
        ..headers["Content-Type"] = "application/json"
        ..headers["Authorization"] = "Bearer ${User.token}";
    }

    var multipartFile =
        await http.MultipartFile.fromPath('file', pictureFile.path);
    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      String responseBody = await response.stream.bytesToString();
      var data = jsonDecode(responseBody);
      String imagePath = data['data'][0];
      return ApiReturnValue(value: imagePath);
    } else {
      return ApiReturnValue(message: 'Uploading Profile Picture Failed');
    }
  }

  static Future<ApiReturnValue<bool>> logOut({http.Client? client}) async {
    client ??= http.Client();
    String url = baseURL + 'logout';

    var response = await client.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${User.token}"
    });

    if (response.statusCode != 200) {
      return ApiReturnValue(message: 'Please Try Again');
    }

    var data = jsonDecode(response.body);

    return ApiReturnValue(value: true);
  }
}
