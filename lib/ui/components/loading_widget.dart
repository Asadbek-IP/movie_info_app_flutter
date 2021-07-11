import 'package:flutter/material.dart';
import 'package:movie_info_app_flutter/ui/theme/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 16),
      child: Center(
        child: CircularProgressIndicator(color: accentColor),
      ),
    );
  }
}
