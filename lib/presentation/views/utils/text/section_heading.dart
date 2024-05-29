import 'package:flutter/material.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    Key? key,
    required this.title,
    this.buttonTitle = 'Lihat Semua',
    this.textColor,
    this.showActionButton = true,
    this.onPressed,
  }) : super(key: key);

  final String title;
  final String buttonTitle;
  final Color? textColor;
  final bool showActionButton;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, ), // Sesuaikan dengan kebutuhan
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .headline6!
                .apply(color: textColor), // Sesuaikan ukuran teks sesuai kebutuhan
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          if (showActionButton)
            TextButton(
              onPressed: onPressed,
              child: Text(
                buttonTitle,
                style: TextStyle(
                  color: Theme.of(context).primaryColor, // Sesuaikan warna sesuai kebutuhan
                ),
              ),
            ),
        ],
      ),
    );
  }
}
