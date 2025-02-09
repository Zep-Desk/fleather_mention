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

  const MentionData({
    required this.value,
    required this.trigger,
    this.associated,
  });

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T) toJsonT) {
    final map = <String, dynamic>{
      'value': value,
      'trigger': trigger,
    };
    if (associated != null) {
      map['associated'] = toJsonT(associated as T);
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
      associated: json.containsKey('associated')
          ? fromJsonT(json['associated'] as Map<String, dynamic>)
          : null,
    );
  }
}


class MentionCallbackAction<T extends Intent> extends CallbackAction<T> {
  MentionCallbackAction({required super.onInvoke, this.enabled = true});

  bool enabled;

  @override
  bool isEnabled(covariant T intent) => enabled;

  @override
  bool consumesKey(covariant T intent) => enabled;
}
