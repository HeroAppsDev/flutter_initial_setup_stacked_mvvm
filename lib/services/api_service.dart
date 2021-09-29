import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:initial_setup_flutter_stacked_mvvm/models/models.dart';

/// The service responsible for networking requests
class ApiService {
  static const endpoint = 'https://jsonplaceholder.typicode.com';

  var client = http.Client();

  Future<Post> getPost(int id) async {
    // Get posts for id
    var response = await client.get(Uri.parse('$endpoint/posts/$id'));

    // Convert and return
    return Post.fromJson(json.decode(response.body));
  }

  Future<List<Post>> getPosts() async {
    var posts = <Post>[];
    // Get list of posts
    var response = await client.get(Uri.parse('$endpoint/posts'));

    // parse into List
    var parsed = json.decode(response.body) as List<dynamic>;

    // loop and convert each item to Post
    for (var post in parsed) {
      posts.add(Post.fromJson(post));
    }

    return posts;
  }

  Future<List<Comment>> getComments(int postId) async {
    var comments = <Comment>[];
    // Get comments for postId
    var response =
        await client.get(Uri.parse('$endpoint/posts/$postId/comments'));

    if (response.statusCode == 200) {
      // if has results
      // parse into List
      var parsed = json.decode(response.body) as List<dynamic>;

      // loop and convert each item to Comment
      for (var comment in parsed) {
        comments.add(Comment.fromJson(comment));
      }
    }
    return comments;
  }
}
