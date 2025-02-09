import 'package:fleather/fleather.dart';
import 'package:flutter/material.dart';

import 'const.dart';

EmbeddableObject buildEmbeddableObject<T>(
  MentionData<T> data,
  Map<String, dynamic> Function(T) toJsonT,
) =>
    EmbeddableObject(
      mentionEmbedKey,
      inline: true,
      data: data.toJson(toJsonT),
    );

class MentionData<T> {
  final String value;
  final String trigger;
  final T? associated;
  final Map<String, dynamic> style;

  const MentionData({
    required this.value,
    required this.trigger,
    this.associated,
    this.style = const {},
  });

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    final map = <String, dynamic>{
      'value': value,
      'trigger': trigger,
      'style': style,
    };
    if (associated != null) {
      map['associated'] = toJsonT(associated!);
    }
    return map;
  }

  factory MentionData.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    return MentionData<T>(
      value: json['value'] as String,
      trigger: json['trigger'] as String,
      style: json['style'] as Map<String, dynamic>? ?? {},
      associated: json.containsKey('associated')
          ? fromJsonT(json['associated'] as Map<String, dynamic>)
          : null,
    );
  }
}

class MentionStyle {
  final TextStyle? style;
  final Color? color;
  final TextDecoration decoration;

  const MentionStyle({
    required this.style,
    this.color,
    this.decoration = TextDecoration.none,
  });
}

class MentionCallbackAction<T extends Intent> extends CallbackAction<T> {
  MentionCallbackAction({required super.onInvoke, this.enabled = true});

  bool enabled;

  @override
  bool isEnabled(covariant T intent) => enabled;

  @override
  bool consumesKey(covariant T intent) => enabled;
}
