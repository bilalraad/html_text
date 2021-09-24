import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'helper.dart';
import 'html_text_model.dart';

class HtmlText extends StatelessWidget {
  final String value;

  HtmlText(this.value, {Key key})
      : assert(value != null),
        super(key: key);

  FontWeight get _normal => FontWeight.w400;

  TextStyle get _style => GoogleFonts.montserrat(fontSize: 20, fontWeight: _normal, color: Colors.black);

  FontWeight _getFontWeight(HtmlTextFormat value) {
    switch (value) {
      case HtmlTextFormat.bold:
        return FontWeight.bold;
      default:
        return _normal;
    }
  }

  @override
  Widget build(BuildContext context) {
    var texts = HtmlTextHelper.mountText(value);

    var first = texts.first;
    texts = texts.where((e) => e.text != first.text).toList();

    return RichText(
      text: TextSpan(
        text: first.text,
        style: _style.copyWith(
          fontWeight: _getFontWeight(first.format),
          decoration: first.format == HtmlTextFormat.underline ? TextDecoration.underline : TextDecoration.none,
          fontStyle: first.format == HtmlTextFormat.italic ? FontStyle.italic : FontStyle.normal,
        ),
        children: texts
            .map(
              (e) => TextSpan(
                text: e.text,
                style: _style.copyWith(
                  fontWeight: _getFontWeight(e.format),
                  decoration: e.format == HtmlTextFormat.underline ? TextDecoration.underline : TextDecoration.none,
                  fontStyle: e.format == HtmlTextFormat.italic ? FontStyle.italic : FontStyle.normal,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
