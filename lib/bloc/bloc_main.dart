import 'dart:async';

import 'package:flutter/material.dart';

class BlocMain {
  final debugClass = 'BlocMain';
  final _progressIndicator = StreamController<bool>.broadcast();

  Stream<bool> get showProgress => _progressIndicator.stream;

  updateShowProgress(bool showProgress) {
    debugPrint('$debugClass showProgress $showProgress');
    _progressIndicator.sink.add(showProgress);
  }

  void dispose() {
    _progressIndicator.close();
  }
}

final blocMain = BlocMain();
