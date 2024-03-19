// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:myapp/Controller/loadImage.dart';

class AccountDetails extends ChangeNotifier {
  List<ImageDetails>? _steps;

  AccountDetails() {
    imageDetailsProgress();
  }

  List<ImageDetails>? get steps => _steps;

  setSteps(List<ImageDetails>? steps) {
    _steps = steps;

    notifyListeners();
  }

  imageDetailsProgress() async {
    ImageDetails? step1 = await loadImagesToPaint(
        "https://i.postimg.cc/J7yncPbZ/authorisation.jpg",
        const Size(150, 150));
    var step2 = await loadImagesToPaint(
        "https://i.postimg.cc/L84Fv8rw/cong-s.jpg", const Size(150, 150));
    var step3 = await loadImagesToPaint(
        "https://i.postimg.cc/5NnR4qRK/history.jpg", const Size(150, 150));
    var step4 = await loadImagesToPaint(
        "https://i.postimg.cc/LXpTBnWZ/teletravail.jpg", const Size(150, 150));

    List<ImageDetails>? steps = [step1!, step2!, step3!, step4!];
    setSteps(steps);
  }
}
