import 'package:fleather/fleather.dart';
import 'package:fleather_mention/src/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'const.dart';

Widget? defaultMentionEmbedBuilder(
  BuildContext context,
  EmbedNode node, {
  Function(MentionData)? onTap,
}) {
  if (node.value.type == mentionEmbedKey && node.value.inline) {
    try {
      final data = MentionData.fromJson(node.value.data);

      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap != null
              ? () {
                  onTap(data);
                }
              : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Text(
              '${data.trigger}${data.value}',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                decoration: TextDecoration.underline,
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
