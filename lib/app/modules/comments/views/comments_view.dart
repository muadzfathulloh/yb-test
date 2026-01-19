import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/theme/app_colors.dart';
import '../controllers/comments_controller.dart';

class CommentsView extends GetView<CommentsController> {
  const CommentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Comments',
          style: GoogleFonts.poppins(
            color: AppColors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.comments.length,
                itemBuilder: (context, index) {
                  final comment = controller.comments[index];
                  return _buildCommentItem(comment);
                },
              ),
            ),
          ),
          _buildInputSection(),
        ],
      ),
    );
  }

  Widget _buildCommentItem(CommentModel comment) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 18, backgroundImage: NetworkImage(comment.avatarUrl)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment.userName,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  comment.content,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.greyDarker,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text(
                      comment.timeAgo,
                      style: GoogleFonts.poppins(fontSize: 11, color: AppColors.greyMedium),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.favorite_border, size: 14, color: AppColors.greyMedium),
                    const SizedBox(width: 4),
                    Text(
                      controller.formatLikes(comment.likes),
                      style: GoogleFonts.poppins(fontSize: 11, color: AppColors.greyMedium),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'reply',
                      style: GoogleFonts.poppins(
                        fontSize: 11,
                        color: AppColors.greyMedium,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (comment.userName == 'Wilson Franci' || comment.userName == 'Marley Botosh')
                  Text(
                    'See more (2)',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.greyMedium,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputSection() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.greyLight)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.greyLight),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: controller.commentController,
                decoration: InputDecoration(
                  hintText: 'Type your comment',
                  hintStyle: GoogleFonts.poppins(fontSize: 13, color: AppColors.greyMedium),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: AppColors.white, size: 20),
              onPressed: controller.postComment,
            ),
          ),
        ],
      ),
    );
  }
}
