import 'package:flutter/material.dart';
import 'package:online_last_lesson/provider/model/post_model.dart';
import 'package:online_last_lesson/provider/pages/detail/detail_provider.dart';
import 'package:provider/provider.dart';


enum DetailState { create, update }

class DetailPage extends StatelessWidget {
  final PostProvider? post;
  final DetailState state;

  const DetailPage({Key? key, this.post, this.state = DetailState.create})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailProvider>(
      create: (BuildContext context) => DetailProvider(),
      builder: (context, child) {
        var provider = context.read<DetailProvider>();
        provider.init(state, post);
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: state == DetailState.create
                ? const Text("Add post")
                : const Text("Update post"),
          ),
          body: Consumer<DetailProvider>(
            builder: (context, provider, child) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          controller: provider.titleController,
                          decoration: InputDecoration(
                              label: const Text("Title"),
                              hintText: "Title",
                              hintStyle: TextStyle(
                                color: Colors.grey.shade400,
                              ),
                              border: const OutlineInputBorder()),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.done,
                          controller: provider.bodyController,
                          decoration: InputDecoration(
                              label: const Text("Body"),
                              hintText: "Body",
                              hintStyle: TextStyle(color: Colors.grey.shade400),
                              border: const OutlineInputBorder()),
                        ),
                        const SizedBox(height: 20,),
                        MaterialButton(
                          color: Colors.blue,
                          onPressed: () {
                            if (state == DetailState.create) {
                              provider.addPage(context);
                            } else {
                              provider.updatePostProvider(context);
                            }
                          },
                          child: const Text("Submit Text"),
                        )
                      ],
                    ),
                  ),
                  Visibility(
                    visible: provider.isLoading,
                    child: const CircularProgressIndicator(
                      color: Colors.red,
                    ),

                  )
                ],
              );
            },
          ),
        );
      },
    );
  }
}