import 'package:flutter/material.dart';
import 'package:online_last_lesson/provider/model/post_model.dart';
import 'package:online_last_lesson/provider/pages/detail/detail_provider_page.dart';
import '../../services/network_service.dart';

class HomeProvider extends ChangeNotifier {
  List<PostProvider> items = [];
  bool isLoading = false;

  Future apiPostList() async {
    isLoading = true;
    notifyListeners();
    List? response =
    await Network.GET(Network.API_LIST, Network.paramsEmpty());
    if (response != null) {
      items = Network.parsePostProviderList(response);
    } else {
      items = [];
    }
    isLoading = false;
    notifyListeners();
  }

  Future<bool> apiPostDelete(PostProvider post) async {
    isLoading = true;
    notifyListeners();

    Map? response = await Network.DELETE(
        Network.API_DELETE + post.id.toString(), Network.paramsEmpty());

    isLoading = false;
    notifyListeners();
    return response != null;
  }

  void goToDetailPage(BuildContext context) async {
    String? response =
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const DetailPage(
        state: DetailState.create,
      );
    }));
    if (response == "add") {
      apiPostList();
    }
  }

  void goToDetailPageUpdate(PostProvider post, BuildContext context) async {
    String? response = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return DetailPage(
            post: post,
            state: DetailState.update,
          );
        },
      ),
    );
    if (response == "refresh") {
      apiPostList();
    }
  }
}
