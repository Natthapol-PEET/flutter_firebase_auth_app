import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth_app/models/wrong_model.dart';

class AppVerifyWrong extends StatelessWidget {
  final List<WrongModel> worng;

  const AppVerifyWrong({super.key, required this.worng});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade100.withOpacity(0.6),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (WrongModel elem in worng) ...[
              Text(
                elem.title,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (String desc in elem.description) ...[
                      Text(
                        '▪ $desc',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(height: 8),
            ],
          ],
        ));
  }
}
