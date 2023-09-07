// import 'package:flutter/material.dart';
// import 'package:flutter_demo_project/core/routes/route_path.dart';
// import 'package:flutter_demo_project/features/post/models/post.dart';
// import 'package:flutter_demo_project/features/shared/widgets/conditional_widget.dart';
// import 'package:go_router/go_router.dart';

// typedef PostTitleAndBody = ({String title, String body});

// class PostDetailScreen extends StatelessWidget {
//   final PostTitleAndBody postModel;
//   const PostDetailScreen({super.key, required this.postModel});
//   static Widget routeBuilder(
//     BuildContext context,
//     GoRouterState state,
//   ) {
//     return PostDetailScreen(
//       postModel: state.extra as PostTitleAndBody,
//     );
//   }

//   static navigateTo(BuildContext context, PostModel postModel) {
//     final PostTitleAndBody params =
//         (title: postModel.title, body: postModel.body);
//     context.push(RoutePath.postDetail, extra: params);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(postModel.title),
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Text(' body : ${postModel.body}'),
//             const ConditionalWidget(
//               condition: 2 == 2,
//               trueChild: Text('true'),
//               falseChild: Text('false'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
