// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_demo_project/api/bloc/api_state.dart';
// import 'package:flutter_demo_project/api/bloc/base_state.dart';
// import 'package:flutter_demo_project/core/constants/ui_constants.dart';
// import 'package:flutter_demo_project/core/extensions/context_extension.dart';
// import 'package:flutter_demo_project/core/snackbar_message.dart';
// import 'package:flutter_demo_project/features/post/models/post.dart';
// import 'package:flutter_demo_project/features/post/presentation/bloc/post/post_bloc.dart';
// import 'package:flutter_demo_project/features/post/presentation/screens/post_detail_screen.dart';
// import 'package:skeletonizer/skeletonizer.dart';

// class PostScreen extends StatelessWidget {
//   const PostScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Posts'),
//         ),
//         body: Center(
//           child: BlocConsumer<PostBloc, BaseState>(
//             listener: (_, state) {
//               if (state is ApiError) {
//                 ShowMessage.errorMessage(context, state.errorMessage);
//               }
//             },
//             builder: (context, state) {
//               if (state is PostInitial) {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: 200,
//                       width: 200,
//                       color: context.colorScheme.secondary,
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         context.read<PostBloc>().add(GetPostEvent());
//                       },
//                       child: const Text(
//                         'Get post',
//                       ),
//                     )
//                   ],
//                 );
//               } else if (state is ApiLoading || state is ListOfPost) {
//                 final bool isLoading = state is ApiLoading;
//                 List<PostModel> posts = [];
//                 if (isLoading) {
//                   posts = List.generate(
//                       8,
//                       (index) => PostModel(
//                           userId: 0,
//                           id: 0,
//                           title:
//                               'sunt aut facere repellat provident occaecati excepturi optio reprehenderit',
//                           body:
//                               'quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto'));
//                 } else if (state is ListOfPost) {
//                   posts = state.post;
//                 }
//                 return Skeletonizer(
//                   enabled: isLoading,
//                   child: ListView.separated(
//                     itemCount: isLoading ? 7 : posts.length,
//                     itemBuilder: (context, index) {
//                       final post = posts[index];
//                       return GestureDetector(
//                         onTap: () {
//                           PostDetailScreen.navigateTo(context, post);
//                         },
//                         child: ListTile(
//                           title: Text(post.title),
//                           subtitle: Text(post.body),
//                         ),
//                       );
//                     },
//                     separatorBuilder: (context, index) => verticalMargin8,
//                   ),
//                 );
//               } else if (state is ApiConnectionError) {
//                 return Container(
//                   height: 200,
//                   width: 200,
//                   color: Colors.yellow,
//                 );
//               } else {
//                 return const SizedBox.shrink();
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
