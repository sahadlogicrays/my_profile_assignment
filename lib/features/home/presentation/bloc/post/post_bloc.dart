// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// part 'post_event.dart';
// part 'post_state.dart';

// class PostBloc extends Bloc<PostEvent, PostState> {
//   PostBloc(super.initialState);
//   // PostBloc() : super(PostInitial()) {
//   //   on<GetPostEvent>(
//   //     (event, emit) async {
//   //       final stream = ApiClient().apiRequest(
//   //         apiEvent: const Get(
//   //           ApiEndPoint.post,
//   //         ),
//   //       );
//   //       await for (final state in stream) {
//   //         emit(state);
//   //         if (state is ApiSuccess) {
//   //           List<PostModel> post = [];
//   //           post =
//   //               (state.data as List).map((e) => PostModel.fromJson(e)).toList();
//   //           emit(ListOfPost(post: post));
//   //         } else if (state is ApiError) {
//   //           emit(PostInitial());
//   //         }
//   //       }
//   //     },
//   //   );
//   // }
// }
