import 'package:flutter/material.dart';

import 'package:fleather/fleather.dart';
import 'package:fleather_mention/fleather_mention.dart';

Widget? defaultMentionEmbedBuilder<T>({
  required BuildContext context,
  required EmbedNode node,
  required T Function(Map<String, dynamic>) fromJson,
  TextStyle? editorTextStyle,
  Function(MentionData<T>)? onTap,
  Function(MentionData<T>)? onHover,
}) {
  if (node.value.type == mentionEmbedKey && node.value.inline) {
    try {
      final data = MentionData<T>.fromJson(node.value.data, fromJson);
      final Color? color =
          data.style['color'] is int ? Color(data.style['color'] as int) : null;

      final baseStyle = editorTextStyle ?? DefaultTextStyle.of(context).style;

      final textStyle = baseStyle.copyWith(
        color: color ?? Theme.of(context).colorScheme.primary,
        decoration: TextDecoration.none,
      );

      return Material(
        color: Colors.transparent,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          onEnter: (_) => onHover?.call(data),
          child: GestureDetector(
            onTap: () => onTap?.call(data),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              child: Text('${data.trigger}${data.value}', style: textStyle),
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
