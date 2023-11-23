// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:youtube_music/constants/tabs.dart';
import 'package:youtube_music/extension/color_extension.dart';

class DefaultAppBarTabButton extends StatefulWidget {
  final AppLocalizations d;
  final int index;
  final bool? isSelected;
  final Function() onPressed;
  const DefaultAppBarTabButton({
    required this.d,
    required this.index,
    this.isSelected,
    required this.onPressed,
  });

  @override
  State<DefaultAppBarTabButton> createState() => _DefaultAppBarTabButtonState();
}

class _DefaultAppBarTabButtonState extends State<DefaultAppBarTabButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            foregroundColor:
                (widget.isSelected == true) ? Colors.black : Colors.white,
            backgroundColor: (widget.isSelected == true)
                ? Colors.white
                : Colors.transparent.getLighterColor()),
        onPressed: widget.onPressed,
        child: Text(TabsConstants.getTabTitle(widget.index, widget.d)));
  }
}
