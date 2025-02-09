import 'package:flutter/material.dart';

import 'const.dart';

import 'package:fleather/fleather.dart';
import 'package:fleather_mention/src/utils.dart';

Widget? defaultMentionEmbedBuilder<T>(
  BuildContext context,
  EmbedNode node, {
  required Function(MentionData<T>) onTap,
  required T Function(Map<String, dynamic>) fromJsonT,
}) {
  if (node.value.type == mentionEmbedKey && node.value.inline) {
    try {
      final data = MentionData<T>.fromJson(node.value.data, fromJsonT);
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            onTap(data);
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Text(
              '${data.trigger}${data.value}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ),
      );
    } catch (e) {
      debugPrint("Error: $e");
    }
  }
  return null;
}
