import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentModel {
  final String userName;
  final String content;
  final String avatarUrl;
  final String timeAgo;
  final int likes;
  final bool isLiked;

  CommentModel({
    required this.userName,
    required this.content,
    required this.avatarUrl,
    required this.timeAgo,
    this.likes = 0,
    this.isLiked = false,
  });
}

class CommentsController extends GetxController {
  final commentController = TextEditingController();
  final RxList<CommentModel> comments = <CommentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadDummyComments();
  }

  void _loadDummyComments() {
    comments.value = [
      CommentModel(
        userName: 'Wilson Franci',
        content: 'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
        avatarUrl: 'https://i.pravatar.cc/150?u=wilson',
        timeAgo: '4w',
        likes: 125,
      ),
      CommentModel(
        userName: 'Madelyn Saris',
        content: 'Lorem ipsum is simply dummy text of the printing and type..',
        avatarUrl: 'https://i.pravatar.cc/150?u=madelyn',
        timeAgo: '4w',
        likes: 3,
      ),
      CommentModel(
        userName: 'Marley Botosh',
        content: 'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
        avatarUrl: 'https://i.pravatar.cc/150?u=marley',
        timeAgo: '4w',
        likes: 12,
      ),
      CommentModel(
        userName: 'Alfonso Septimus',
        content: 'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
        avatarUrl: 'https://i.pravatar.cc/150?u=alfonso',
        timeAgo: '4w',
        likes: 14000,
      ),
      CommentModel(
        userName: 'Omar Herwitz',
        content: 'Lorem ipsum is simply dummy text of the printing and typesetting industry.',
        avatarUrl: 'https://i.pravatar.cc/150?u=omar',
        timeAgo: '4w',
        likes: 16,
      ),
    ];
  }

  void postComment() {
    if (commentController.text.trim().isEmpty) return;

    final newComment = CommentModel(
      userName: 'John due', // Current user
      content: commentController.text,
      avatarUrl: 'https://i.pravatar.cc/150?u=muadz',
      timeAgo: 'just now',
    );

    comments.insert(0, newComment);
    commentController.clear();
  }

  String formatLikes(int likes) {
    if (likes >= 1000) {
      return '${(likes / 1000).toStringAsFixed(0)}K';
    }
    return likes.toString();
  }

  @override
  void onClose() {
    commentController.dispose();
    super.onClose();
  }
}
