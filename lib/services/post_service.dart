import 'dart:convert';

import 'package:euphoriafx/config/constants.dart';
import 'package:euphoriafx/config/injector_container.dart';
import 'package:euphoriafx/models/post_model.dart';
import 'package:euphoriafx/services/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PostService {
  var jsonOnlyHeader = {"Accepts": "application/json"};

  var url = Constants.baseUrl + "feeds/";

  var authService = s1<AuthService>();

  //Fetch a list of post from the server
  Future<List<PostModel>> getPosts() async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)["data"];
      List<PostModel> posts = body
          .map(
            (dynamic item) => PostModel.fromJson(item),
          )
          .toList();
      // If the server did return a 200 OK response, then parse the JSON.
      return posts;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load post');
    }
  }

  //Fetch a single post
  Future<PostModel> getPost(int id) async {
    final response = await http.get(this.url + id.toString(),
        headers: authService.httpHeaders);

    print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return PostModel.fromJson(json.decode(response.body)["data"]);
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load post');
    }
  }

  Future<Response> addPost(Map<String, dynamic> post) async {
    final response = await http.post(Constants.baseUrl + "posts/",
        body: post, headers: authService.httpHeaders);
    return response;
  }

  Future<PostModel> deletePost(PostModel postModel) {}

  List<PostModel> trendingPosts(List<PostModel> posts) {
    List<PostModel> tempSortedPosts = [];

    if (posts.length < 7) {
      for (var i = 0; i < posts.length; i++) {
        if (DateTime.now().millisecondsSinceEpoch -
                posts[i].createdAt.millisecondsSinceEpoch <
            518400000) {
          tempSortedPosts.add(posts[i]);
        }
      }
    } else {
      for (var i = 0; i < posts.length; i++) {
        if (DateTime.now().millisecondsSinceEpoch -
                posts[i].createdAt.millisecondsSinceEpoch <
            518400000) {
          if (tempSortedPosts.length < 7) {
            tempSortedPosts.add(posts[i]);
          } else {
            break;
          }
        }
      }
    }

    for (var i = 0; i < tempSortedPosts.length; i++) {
      var tempPost = tempSortedPosts[i];

      var totalTempLikesAndComments =
          tempPost.comments.length + tempPost.likes.length;

      for (var j = 0; j < tempSortedPosts.length; j++) {
        var comPost = tempSortedPosts[i];

        var totalComLikesAndPost =
            comPost.comments.length + comPost.likes.length;

        if (totalTempLikesAndComments > totalComLikesAndPost) {
          tempSortedPosts.insert(j, tempPost);
        }
      }
    }

    for (var i = 0; i < posts.length; i++) {
      var tempPost = posts[i];

      var tempPostTotal = tempPost.likes.length + tempPost.comments.length;

      for (var j = 0; j < tempSortedPosts.length; j++) {
        var comPost = tempSortedPosts[j];
        var comPostTotal = comPost.comments.length + comPost.likes.length;
        if (tempPostTotal > comPostTotal) {
          tempSortedPosts.insert(j, comPost);
          var index = tempSortedPosts.length - 1;
          tempSortedPosts.removeAt(index);
        }
      }
    }
    return tempSortedPosts;
  }
}
