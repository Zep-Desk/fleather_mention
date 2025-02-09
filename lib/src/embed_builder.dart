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
      final double? fontSize = data.style['fontSize'] is num
          ? (data.style['fontSize'] as num).toDouble()
          : null;
      final Color? color =
          data.style['color'] is int ? Color(data.style['color'] as int) : null;

      final defaultStyle = DefaultTextStyle.of(context).style;
      final textStyle = defaultStyle.copyWith(
        color: color ?? Theme.of(context).colorScheme.primary,
        fontSize: fontSize ?? defaultStyle.fontSize,
        decoration: TextDecoration.underline,
      );

      return Material(
        color: Colors.transparent,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            overlayColor: WidgetStateProperty.all(Colors.transparent),
            enableFeedback: false,
            onTap: () {
              onTap?.call(data);
            },
            highlightColor: Colors.transparent,
            onHover: (hover) {
              onHover?.call(data);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 2,
              ),
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
