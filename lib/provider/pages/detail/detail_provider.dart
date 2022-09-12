import 'dart:math';

import 'package:flutter/material.dart';
import 'package:online_last_lesson/provider/pages/detail/detail_provider_page.dart';

import '../../model/post_model.dart';
import '../../services/network_service.dart';

class DetailProvider extends ChangeNotifier{
  TextEditingController titleController = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  bool isLoading = false;

  void init(DetailState state,PostProvider? post) {
    if (state == DetailState.update) {
      titleController = TextEditingController(text: post!.title);
      bodyController = TextEditingController(text: post.body);
    }
  }

  void updatePostProvider(BuildContext context) async {
    String title = titleController.text.trim();
    String body = bodyController.text.trim();
    PostProvider post = PostProvider(
        id: Random().nextInt(100),
        title: title,
        body: body,
        userId: Random().nextInt(100));
    isLoading = true;
    notifyListeners();
    Network.PUT(Network.API_UPDATE + post.id.toString(), post.toJson()).then((value) {
      Navigator.pop(context, "refresh");
    });
    isLoading = false;
    notifyListeners();
  }

  void addPage(BuildContext context) async {
    String title = titleController.text.trim();
    String body = bodyController.text.trim();
    PostProvider post = PostProvider(
        id: Random().nextInt(100),
        title: title,
        body: body,
        userId: Random().nextInt(100));
    isLoading = true;
    notifyListeners();
    Network.POST(Network.API_CREATE, post.toJson()).then((value) {
      Navigator.pop(context, "add");
    });
    isLoading = false;
    notifyListeners();
  }
}