import 'package:flutter/material.dart';

import 'const.dart';

import 'package:fleather/fleather.dart';
import 'package:fleather_mention/src/utils.dart';

Widget? defaultMentionEmbedBuilder<T>(
  BuildContext context,
  EmbedNode node, {
  Function(MentionData<T>)? onTap,
  Function(MentionData<T>)? onHover,
  required T Function(Map<String, dynamic>) fromJson,
}) {
  if (node.value.type == mentionEmbedKey && node.value.inline) {
    try {
      final data = MentionData<T>.fromJson(node.value.data, fromJson);
      return Material(
        color: Colors.transparent,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onHover: (event) {
            onHover?.call(data);
          },
          child: GestureDetector(
            onTap: () {
              onTap?.call(data);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 2,
              ),
              child: Text(
                '${data.trigger}${data.value}',
                style: DefaultTextStyle.of(context).style.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
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
